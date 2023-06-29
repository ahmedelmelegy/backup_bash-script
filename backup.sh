#!/bin/bash

# Author: Ahmed Elmelegy
# Date Created: 23/6/2023
# Last Modified: 29/6/2023

# Description
# Creates backups of directories within the target directory
# Each directory and its files are backed up in separate compressed tar files

# Usage:
# ./backup.sh target_directory destination_directory [encryption_key] [n]
# For example:
# ./backup.sh /path/to/target /path/to/destination myencryptionkey 7

echo "Hello, ${USER^}"

if [[ $# -ne 4 ]]; then
  echo "You didn't enter the correct number of parameters"
  echo "Usage: $0 source_path destination_path [encryption_key]"
  exit 1
fi

# Print help message if no parameters are provided
if [[ $1 == "-h" || $1 == "--help" ]]; then
  echo "Usage: $0 target_directory destination_directory encryption_key n"
  echo "This script creates backups of modified files within directories under the target_directory."
  echo "The backups are encrypted using the provided encryption key."
  echo "The number of days (n) specifies the range of modified files to backup."
  exit 0
fi

source=$1
dest=${2}
encryption_key=$3
days=$4

# Validate directories
if [[ ! -d $target ]]; then
  echo "Error: Invalid target directory."
  exit 1
fi

if [[ ! -d $destination_directory ]]; then
  echo "Error: Invalid destination directory."
  exit 1
fi

# Take a snapshot of the full date
snapshot_date=$(date +%d-%m-%Y_%H-%M-%S)
snapshot_date=${snapshot_date// /_}
snapshot_date=${snapshot_date//:/_}

# Create a directory with the snapshot date under the destination directory
backup_directory="${destination_directory}/${snapshot_date}"
mkdir -p "$backup_directory"

# Loop over directories under the target directory
for directory in "${target_directory}"/*/; do
  directory_name=$(basename "$directory")

  # Check modification date and backup only modified files within the last n days
  if [[ -z $n ]]; then
    find "$directory" -type f -exec tar -cvf "${backup_directory}/${directory_name}_${snapshot_date}.tar" {} \;
  else
    find "$directory" -type f -mtime -$n -exec tar -cvf "${backup_directory}/${directory_name}_${snapshot_date}.tar" {} \;
  fi

  # Encrypt the backup using the provided encryption key
  gpg --batch --yes --passphrase "$encryption_key" -c "${backup_directory}/${directory_name}_${snapshot_date}.tar"

  # Delete the original tar file and keep the encrypted one
  rm "${backup_directory}/${directory_name}_${snapshot_date}.tar"
done

# Enumerate all files directly under the target directory and create a combined backup
tar -cvf "${backup_directory}/all_files_${snapshot_date}.tar" -C "$target_directory" .
gzip "${backup_directory}/all_files_${snapshot_date}.tar"

echo "Backup Completed Successfully."
exit 0