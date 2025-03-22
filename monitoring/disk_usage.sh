#!/bin/bash

# This script provides option to save logs on the monitoring
BASE_LOG_DIR=/etc/monitoring/logs
DATE=$(date +"%Y-%m-%d_%H-%M")
FOLDER_DATE=$(date +"%Y-%m-%d")
LOG_DIR=$BASE_LOG_DIR/$FOLDER_DATE

# Create Directory for the day
mkdir -p $LOG_DIR

echo "====== Capturing logs in $LOG_DIR ======="

# Disk usage log
echo "====== Capturing disk usage... on $DATE ======= "
df -h > $LOG_DIR/disk_usage_$DATE.log
du -sh /home/* /var/* >> $LOG_DIR/disk_usage_$DATE.log

# Capture CPU/Memory snapshot using 'top'
echo "====== Capturing CPU/Memory snapshot... on $DATE ======= "
top -b -n 1 > $LOG_DIR/top_snapshot_$DATE.log

# Capture system stats using nmon
echo "====== Capturing nmon snapshot... on $DATE ======= "
nmon -f -s 60 -c 1 -F $LOG_DIR/nmon_$DATE.nmon

# Top CPU consuming processes
echo "====== Capturing Top CPU Process... on $DATE ======= "
ps aux --sort=-%cpu | head -n 15 > $LOG_DIR/top_cpu_$DATE.log

# Top memory-consuming processes
echo "====== Capturing Top Memory Process... on $DATE ======= "
ps aux --sort=-%mem | head -n 15 > $LOG_DIR/top_mem_$DATE.log

echo "All logs captured and saved under $LOG_DIR at $DATE"

# Delete logs older than 30 days
find /etc/monitoring/logs/ -type d -mtime +30 -exec rm -rf {} \;