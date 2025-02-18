#!/usr/bin/bash
echo "This is a backup script for the logs"

# The directory containing log files to be backed up
backup_source="/var/log"
backup_folder="/home/ubiomachine/backupfile"
date=$(date +%Y%m%d_%H%M%S)
backupfile="log_backup_$date.tar.gz"

# Check if the backup folder exists, if not, create it
if [ ! -d "$backup_folder" ]; then
    echo "The directory does not exist. Creating..."
    sudo mkdir -p "$backup_folder"
fi

echo "Compressing the log files..."
tar -czvf "$backup_folder/$backupfile" "$backup_source"

# Check if compression was successful
if [ $? -eq 0 ]; then
    echo "The compression was successful: $backupfile"
    # Change permissions of the backup folder
    sudo chmod -R 777 "$backup_folder"
else
    echo "The backup and compression were not successful"
fi
