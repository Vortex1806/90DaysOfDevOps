#!/bin/bash

set -euo pipefail

if [ $# -le 1 ]; then
	echo "Usage ./backup.sh <src_dir_path> <dest_dir_path>"
	exit 1
fi

source_dir=$1
dest_dir=$2

if [ ! -d "$source_dir" ]; then
	echo "Source directory does not exist"
	exit 1
fi

if [ ! -d "$dest_dir" ]; then
	echo "Destination directory does not exist"
	exit 1
fi

timestamp=$(date +%Y-%m-%d)
backup_name=backup-$timestamp.tar.gz

tar -czf "$dest_dir/$backup_name" "$source_dir"

if [ -f "$dest_dir/$backup_name" ]; then
	echo "Backup created successfully"
	echo "Name: $backup_name"
	echo "Size:" $(du -h "$dest_dir/$backup_name" | awk '{print $1}')
else
	echo "Backup creation failed..."
	exit 1
fi

backups_to_delete=($(find "$dest_dir" -name "*.tar.gz" -mtime +14))
for file in "${backups_to_delete[@]}"
do 
	rm "$file"
	echo "Deleted $file"
done