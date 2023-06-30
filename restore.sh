#!/bin/bash

# Author: Ahmed Elmelegy
# Date Created: 24/6/2023
# Last Modified: 29/6/2023

# Description
# extract contents of .tar in source_path to destination_path/uncomp
# If user didn`t specify dest_path it will be working directory`

# Usage: 
# ./restore.sh source_path destination_path
# For example
# ./restore.sh . .

echo "Hello, ${USER^}"

if [[ $# -ne 2 ]]; then
  echo "You didn't enter exactly 2 parameters"
  echo "Usage: $0 source_path destination_path"
  exit 1
fi

source=$1
dest=${2}

mkdir ${dest}/uncomp
echo "Hello, ${USER^}"
tar -xvf "${source}/my_backup_*" -C "${dest}/uncomp" 1> uncomp_log.txt 2> uncomp_error_log.txt
echo "Extraction Completed Successfully."

exit 0