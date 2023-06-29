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

source "$(dirname "$0")/backup_restore_lib.sh"

restore "$@"