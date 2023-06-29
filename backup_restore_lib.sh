#!/bin/bash

# Function to validate backup parameters
function validate_backup_params() {
  if [[ $# -ne 4 ]]; then
    echo "Error: Invalid number of parameters"
    echo "Usage: $0 source_path destination_path encryption_key num_days"
    exit 1
  fi

  source_path=$1
  destination_path=$2
  encryption_key=$3
  num_days=$4

  # Validate source directory
  if [[ ! -d $source_path ]]; then
    echo "Error: Invalid source directory"
    exit 1
  fi

  # Validate destination directory
  if [[ ! -d $destination_path ]]; then
    echo "Error: Invalid destination directory"
    exit 1
  fi
}

# Function to perform backup
function backup() {
  validate_backup_params "$@"

  source_path=$1
  destination_path=$2
  encryption_key=$3
  num_days=$4

  # Create backup directory with the current date and time
  backup_dir="${destination_path}/backup_$(date +%d-%m-%Y_%H-%M-%S)"
  mkdir "$backup_dir"

  # Loop over directories in the source path
  find "$source_path" -type d -print0 | while IFS= read -r -d $'\0' dir; do
    # Get the directory name
    dir_name=$(basename "$dir")

    # Create a separate compressed tar file for each directory
    tar_file="${backup_dir}/${dir_name}_$(date +%d-%m-%Y_%H-%M-%S)".tar.gz
    tar -czf "$tar_file" -C "$dir" .

    # Encrypt the tar file using the provided encryption key
    encrypted_file="${tar_file}.gpg"
    gpg --batch --yes --passphrase "$encryption_key" -o "$encrypted_file" -c "$tar_file"

    # Delete the original tar file
    rm "$tar_file"
  done

  # Create a single tar file for all files directly under the backup directory
  tar_file="${backup_dir}/all_files_$(date +%d-%m-%Y_%H-%M-%S)".tar
  find "$source_path" -type f -print0 | while IFS= read -r -d $'\0' file; do
    tar -rf "$tar_file" -C "$source_path" "$file"
  done

  # Compress the tar file
  tar_file_gz="${tar_file}.gz"
  gzip "$tar_file"

  # Encrypt the compressed tar file using the provided encryption key
  encrypted_file="${tar_file_gz}.gpg"
  gpg --batch --yes --passphrase "$encryption_key" -o "$encrypted_file" -c "$tar_file_gz"

  # Delete the original tar file
  rm "$tar_file_gz"

	# Copy the backup directory to the remote server
	remote_username="remote_username"
	remote_server="remote_server"
	remote_directory="remote_directory"

	scp -r "$backup_directory" "${remote_username}@${remote_server}:${remote_directory}"

	# Check if the scp command was successful
	if [[ $? -eq 0 ]]; then
		echo "Backup files copied to remote server successfully."
	else
		echo "Error: Failed to copy backup files to remote server."
	fi

  echo "Backup Completed Successfully."
  exit 0
}

# Function to validate restore parameters
function validate_restore_params() {
  if [[ $# -ne 3 ]]; then
    echo "Error: Invalid number of parameters"
    echo "Usage: $0 backup_directory destination_path decryption_key"
    exit 1
  fi

  backup_directory=$1
  destination_path=$2
  decryption_key=$3

  # Validate backup directory
  if [[ ! -d $backup_directory ]]; then
    echo "Error: Invalid backup directory"
    exit 1
  fi

  # Validate destination directory
  if [[ ! -d $destination_path ]]; then
    echo "Error: Invalid destination directory"
    exit 1
  fi
}

# Function to perform restore
function restore() {
  validate_restore_params "$@"

	backup_directory=$1
	destination_directory=$2
	decryption_key=$3

	mkdir -p "${destination_directory}/temp"
	echo "Hello, ${USER^}"

	# Loop over files in the backup directory
	for file in "${backup_directory}"/*; do
		# Use gnupg tool to decrypt the files
		gpg --batch --yes --passphrase "$decryption_key" -o "${destination_directory}/temp/$(basename "$file")" -d "$file"
	done

	# Loop over files stored in the temp directory and extract them
	for file in "${destination_directory}/temp"/*; do
		# Extract the files under the destination directory
		tar -xvf "$file" -C "$destination_directory"
	done
}