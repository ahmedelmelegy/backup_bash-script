#!/bin/bash

# Author: Ahmed Elmelegy
# Date Created: 24/6/2023
# Last Modified: 24/6/2023

# Description
# extract contents of .tar in destination directory user specify

# Usage: 
# restore.sh

source=./my_backup_*
dest=./uncomp/

echo "Hello, ${USER^}"
tar -xvf ${source} -C ${dest} 1> uncomp_log.txt 2> uncomp_error_log.txt
echo "Extraction Completed Successfully."

exit 0