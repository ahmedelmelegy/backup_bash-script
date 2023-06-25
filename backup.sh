#!/bin/bash

# Author: Ahmed Elmelegy
# Date Created: 23/6/2023
# Last Modified: 24/6/2023

# Description
# Creates a backup in ~/bash_course of all files in the home directory

# Usage: 
# backup.sh

source=${HOME}
dest=./my_backup
echo "Hello, ${USER^}"
tar -cvf ${dest}_"$(date +%d-%m-%Y_%H-%M-%S)".tar ${source}/* 1> comp_log.txt 2> error_log.txt
echo "Backup Completed Successfully."
exit 0