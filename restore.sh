#!/bin/bash

# Author: Ahmed Elmelegy
# Date Created: 24/6/2023
# Last Modified: 25/6/2023

# Description
# extract contents of .tar in source_path to destination_path/uncomp

# Usage: 
# ./restore.sh source_path destination_path
# For example
# ./restore.sh . .

source=$1
dest=$2
mkdir ${dest}/uncomp
echo "Hello, ${USER^}"
tar -xvf ${source}/my_backup_* -C ${dest}/uncomp 1> uncomp_log.txt 2> uncomp_error_log.txt
echo "Extraction Completed Successfully."

exit 0