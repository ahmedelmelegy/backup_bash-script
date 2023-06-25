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

if [[ $# -ne 2 ]]; then
  echo "You didn't enter exactly 2 parameters"
  echo "Usage: $0 source_path destination_path"
  exit 1
fi

source=$1
dest=${2}

tar -cvf "${dest}/my_backup_$(date +%d-%m-%Y_%H-%M-%S)".tar "${source}"/* 1> comp_log.txt 2> error_log.txt
echo "Backup Completed Successfully."
exit 0