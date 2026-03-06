#!/bin/bash

set -euo pipefail

LOG_FILE="/var/log/maintenance.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "Starting maintenance job..."

log "Running log rotation..."
/home/ubuntu/backupScripts/log_rotate.sh /var/log/nginx >> "$LOG_FILE" 2>&1

log "Running backup..."
/home/ubuntu/backupScripts/backup.sh /home/ubuntu/backupScripts/data /home/ubuntu/backupScripts/backups >> "$LOG_FILE" 2>&1

log "Maintenance job completed."
echo "" >> "$LOG_FILE"