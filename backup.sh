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

source=$1
dest=${2}
encryption_key=$3
days=$4

if [[ ! -d $target ]]; then
  echo "Target directory does not exist"
  exit 1
fi

if [[ -z $encryption_key ]]; then
  echo "No encryption key provided. Backup will not be encrypted."
  if [[ -z $days ]]; then
    for dir in "$target"/*/; do
      dir_name=$(basename "$dir")
      tar -cvf "${dest}/${dir_name}_backup_$(date +%d-%m-%Y_%H-%M-%S)".tar.gz -C "$dir" . 1> comp_log.txt 2> error_log.txt
    done
  else
    for dir in "$target"/*/; do
      dir_name=$(basename "$dir")
      find "$dir" -type f -mtime -$days -exec tar -rvf "${dest}/${dir_name}_backup_$(date +%d-%m-%Y_%H-%M-%S)".tar.gz {} \; 1> comp_log.txt 2> error_log.txt
    done
  fi
else
  echo "Encrypting backups with the provided encryption key."
  if [[ -z $days ]]; then
    for dir in "$target"/*/; do
      dir_name=$(basename "$dir")
      tar -cvf - -C "$dir" . | openssl enc -aes-256-cbc -salt -k "${encryption_key}" -out "${dest}/${dir_name}_backup_$(date +%d-%m-%Y_%H-%M-%S)".tar.gz 1> comp_log.txt 2> error_log.txt
    done
  else
    for dir in "$target"/*/; do
      dir_name=$(basename "$dir")
      find "$dir" -type f -mtime -$days -exec tar -cvf - {} \; | openssl enc -aes-256-cbc -salt -k "${encryption_key}" -out "${dest}/${dir_name}_backup_$(date +%d-%m-%Y_%H-%M-%S)".tar.gz 1> comp_log.txt 2> error_log.txt
    done
  fi
fi

echo "Backup Completed Successfully."
exit 0