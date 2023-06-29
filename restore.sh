#!/bin/bash

# Author: Ahmed Elmelegy
# Date Created: 24/6/2023
# Last Modified: 29/6/2023

# Description
# Restores the backup by decrypting and extracting the files in reverse order.

# Usage:
# ./restore.sh backup_directory destination_directory decryption_key
# For example:
# ./restore.sh /path/to/backup /path/to/destination mydecryptionkey

if [[ $# -ne 3 ]]; then
  echo "You didn't enter exactly 3 parameters"
  echo "Usage: $0 source_path destination_path decryption_key"
  exit 1
fi

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

exit 0