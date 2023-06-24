#!/bin/bash

# Author: Ahmed Elmelegy
# Date Created: 23/6/2023
# Last Modified: 23/6/2023

# Description
# Creates a backup in ~/bash_course of all files in the home directory

# Usage: 
# backup.sh

source=./my_backup_*
dest=../uncomp/
tar -xvf ${source} -C ${dest} 1> uncomp_log.txt 2> uncomp_error_log.txt
exit 0