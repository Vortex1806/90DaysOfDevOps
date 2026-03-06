# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab

## Overview

In this project, I implemented real-world system maintenance automation using Bash scripting. The tasks included writing scripts for log rotation, server backups, and scheduling them using cron jobs. I also combined these scripts into a maintenance workflow that runs automatically.

This exercise helped me understand how DevOps engineers automate server maintenance tasks such as managing log growth, maintaining backups, and scheduling periodic jobs.

---

# Task 1 – Log Rotation Script

## Script: `log_rotate.sh`

```bash
#!/bin/bash

set -euo pipefail

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

files_zipped=($(find "$dir_path" -name "*.log" -mtime +7))
echo "No of files to be compressed: ${#files_zipped[@]}"

for file in "${files_zipped[@]}"
do
    gzip "$file"
    echo "ZIPPED: $file"
done

echo ""

echo "Deleting compressed logs older than 30 days..."

files_to_delete=($(find "$dir_path" -name "*.gz" -mtime +30))
echo "No of files to be deleted: ${#files_to_delete[@]}"

for file in "${files_to_delete[@]}"
do
    rm "$file"
    echo "DELETED: $file"
done
```

## Sample Output

```
Compressing logs older than 7 days...
No of files to be compressed: 2
ZIPPED: /var/log/nginx/access.log
ZIPPED: /var/log/nginx/error.log

Deleting compressed logs older than 30 days...
No of files to be deleted: 0
```

---

# Task 2 – Server Backup Script

## Script: `backup.sh`

```bash
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
```

## Sample Output

```
Backup created successfully
Name: backup-2026-03-06.tar.gz
Size: 5.2M
Deleted backup-2026-02-20.tar.gz
```

---

# Task 3 – Crontab Scheduling

## Understanding Cron Syntax

```
* * * * * command
│ │ │ │ │
│ │ │ │ └── Day of week (0-7)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

## Cron Entries

Run log rotation every day at **2 AM**

```
0 2 * * * /home/ubuntu/backupScripts/log_rotate.sh /var/log/nginx
```

Run backup every **Sunday at 3 AM**

```
0 3 * * 0 /home/ubuntu/backupScripts/backup.sh /home/ubuntu/backupScripts/data /home/ubuntu/backupScripts/backups
```

Run health check every **5 minutes**

```
*/5 * * * * echo "Running health check $(date)" >> /home/ubuntu/health.log
```

---

# Task 4 – Maintenance Script

## Script: `maintenance.sh`

```bash
#!/bin/bash

echo "$(date): Starting maintenance job" >> /var/log/maintenance.log

/home/ubuntu/backupScripts/log_rotate.sh /var/log/nginx >> /var/log/maintenance.log 2>&1

/home/ubuntu/backupScripts/backup.sh /home/ubuntu/backupScripts/data /home/ubuntu/backupScripts/backups >> /var/log/maintenance.log 2>&1

echo "$(date): Maintenance job completed" >> /var/log/maintenance.log
```

## Cron Entry

Run daily at **1 AM**

```
0 1 * * * /home/ubuntu/backupScripts/maintenance.sh
```

---

# Problems I Faced and Fixes

### 1. Incorrect strict mode

Initially I wrote:

```
set -euo pipeline
```

This was incorrect. The correct syntax is:

```
set -euo pipefail
```

---

### 2. Incorrect Bash array usage

I initially tried:

```
files_zipped=(find ...)
```

But Bash arrays must use command substitution:

```
files_zipped=($(find ...))
```

---

### 3. Quoting variables

I learned that variables should be quoted to prevent issues with spaces:

```
"$dest_dir/$backup_name"
```

instead of

```
$dest_dir/$backup_name
```

---

### 4. Cron output disappearing

When I ran commands in cron like:

```
*/5 * * * * echo "Running health check"
```

nothing appeared in the terminal.

I learned that cron does not display output unless redirected:

```
>> /home/ubuntu/health.log
```

---

### 5. Running scripts with proper permissions

Scripts must be executable:

```
chmod +x *.sh
```

---

# Key Concepts Learned

### 1. Safer Bash scripting with strict mode

Using:

```
set -euo pipefail
```

helps catch errors early and prevents silent script failures.

---

### 2. Automating system maintenance

Using Bash scripts with cron allows automatic:

- log cleanup
- server backups
- health monitoring

---

### 3. Using `find` for file lifecycle management

Commands like:

```
find /path -name "*.log" -mtime +7
```

are extremely useful for managing old logs and backups automatically.

---

# Conclusion

This project demonstrated how shell scripting and cron can be used together to automate common server maintenance tasks. These patterns are widely used in real-world DevOps environments for log management, backup automation, and periodic monitoring.
