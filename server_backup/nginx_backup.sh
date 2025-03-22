#!/bin/bash

# Nginx backup script for Mike
DATE=$(date +%F)
BACKUP_DIR="/backup/nginx"
BACKUP_FILE="${BACKUP_DIR}/nginx_backup_${DATE}.tar.gz"
LOG_FILE="${BACKUP_DIR}/nginx_backup_log_${DATE}.txt"

# Create backup directory if not exists
mkdir -p $BACKUP_DIR

# Create compressed backup
tar -czf $BACKUP_FILE /etc/nginx/ /usr/share/nginx/html/

# Log the backup creation and verify contents
{
    echo "Backup created at: $BACKUP_FILE"
    echo "Verifying backup contents:"
    tar -tzf $BACKUP_FILE
} > $LOG_FILE
