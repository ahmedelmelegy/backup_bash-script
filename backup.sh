#!/bin/bash

# Author: Ahmed Elmelegy
# Date Created: 23/6/2023
# Last Modified: 23/6/2023
# Description
# Archive contents of home

# Usage: 
# 

tar -cvf ~/bash_course/my_backup_"$(date +%d-%m-%Y_%H-%M-%S)".tar ~/* 1> comp_log.txt 2> error_log.txt
exit 0
