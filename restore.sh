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

echo "Hello, ${USER^}"

if [[ $# -ne 3 ]]; then
  echo "You didn't enter exactly 3 parameters"
  echo "Usage: $0 source_path destination_path decryption_key"
  exit 1
fi

source=$1
dest=${2}
decryption_key=$3

mkdir -p ${dest}/uncomp
echo "Hello, ${USER^}"
gpg --batch --yes --passphrase "$decryption_key" -o "${dest}/uncomp/my_backup.tar" -d "${source}/my_backup_*"

tar -xvf "${dest}/uncomp/my_backup.tar" -C "${dest}/uncomp" 1> uncomp_log.txt 2> uncomp_error_log.txt
echo "Extraction Completed Successfully."

exit 0