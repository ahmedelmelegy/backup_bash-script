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

source "$(dirname "$0")/backup_restore_lib.sh"

backup "$@"