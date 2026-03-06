#!/bin/bash

set -e

if [ $# -eq 0 ]; then
        echo "Usage: ./log_rotate.sh <LOG_DIR_PATH>"
        exit 1
fi

dir_path=$1

if [ ! -d "$dir_path" ]; then
    echo "$dir_path directory does not exist."
    exit 1
fi

echo "Compressing logs older than 7 days..."

files_zipped=($(find $dir_path -name "*.log" -mtime +7))
echo "No of files to be compressed: ${#files_zipped[@]}"
for file in ${files_zipped[@]};
do
        gzip "$file"
        echo "ZIPPED: $file"
done

echo ""
echo "Deleting compressed logs older than 30 days..."

files_to_delete=($(find $dir_path -name "*.gz" -mtime +30))
echo "No of files to be deleted: ${#files_to_delete[@]}"
for file in ${files_to_delete[@]};
do 
        rm "$file"
        echo "DELETED: $file"
done