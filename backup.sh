#!/bin/bash

# Author: Ahmed Elmelegy
# Date Created: 23/6/2023
# Last Modified: 25/6/2023

# Description
# Creates a backup in destination_path of all files in the source_path
# If user didn`t specify dest_path it will be working directory

# Usage: 
# ./backup.sh source_path destination_path
# For example
# ./backup.sh ~ .

echo "Hello, ${USER^}"

if [[ $# -ne 3 ]]; then
  echo "You didn't enter the correct number of parameters"
  echo "Usage: $0 source_path destination_path [encryption_key]"
  exit 1
fi

source=$1
dest=${2}
encryption_key=$3
days=$4

if [[ -z $encryption_key ]]; then
  echo "No encryption key provided. Backup will not be encrypted."
  if [[ -z $days ]]; then
    tar -cvf "${dest}/my_backup_$(date +%d-%m-%Y_%H-%M-%S)".tar "${source}"/* 1> comp_log.txt 2> error_log.txt
  else
    find "${source}" -type f -mtime -$days -exec tar -rvf "${dest}/my_backup_$(date +%d-%m-%Y_%H-%M-%S)".tar {} \; 1> comp_log.txt 2> error_log.txt
  fi
else
  echo "Encrypting backup with the provided encryption key."
  if [[ -z $days ]]; then
    tar -cvf - "${source}"/* | openssl enc -aes-256-cbc -salt -k "${encryption_key}" -out "${dest}/my_backup_$(date +%d-%m-%Y_%H-%M-%S)".tar 1> comp_log.txt 2> error_log.txt
  else
    find "${source}" -type f -mtime -$days -exec tar -cvf - {} \; | openssl enc -aes-256-cbc -salt -k "${encryption_key}" -out "${dest}/my_backup_$(date +%d-%m-%Y_%H-%M-%S)".tar 1> comp_log.txt 2> error_log.txt
  fi
fi

echo "Backup Completed Successfully."
exit 0