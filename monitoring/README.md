
# 📊 System Monitoring Log Capture Script

## ✅ Overview
This script automates the capture of key system health metrics for monitoring and troubleshooting purposes.  
It logs disk usage, CPU and memory snapshots, top resource-consuming processes, and generates `nmon` reports — all organized neatly into date-based folders.

---

## ✅ Features
- Logs captured every hour (when scheduled via `cron`)
- Grouped logs by daily folders
- Captures:
  - Disk usage (`df` & `du`)
  - CPU & memory usage snapshot (`top`)
  - System metrics snapshot (`nmon`)
  - Top CPU-intensive processes
  - Top memory-intensive processes
- Automatic cleanup of logs older than 30 days

---

## ✅ Folder Structure Example
```
/etc/monitoring/logs/
└── 2025-03-22/
    ├── disk_usage_2025-03-22_14-00.log
    ├── top_snapshot_2025-03-22_14-00.log
    ├── nmon_2025-03-22_14-00.nmon
    ├── top_cpu_2025-03-22_14-00.log
    └── top_mem_2025-03-22_14-00.log
```

---

## ✅ Installation & Setup

### 1. Save the script
```bash
sudo mkdir -p /etc/monitoring
sudo nano /etc/monitoring/disk-usage.sh
```
> Paste the script and save.

### 2. Make it executable
```bash
sudo chmod +x /etc/monitoring/disk-usage.sh
```

### 3. Schedule to run every hour
```bash
crontab -e
```
Add this line:
```
0 * * * * /etc/monitoring/disk-usage.sh
```

---

## ✅ Dependencies
- `nmon` (Install with: `sudo apt install nmon`)
- `cron` service running
- Sufficient disk space for log storage

---

## ✅ Manual Execution
You can run the script manually any time with:
```bash
sudo /etc/monitoring/disk-usage.sh
```

---

## ✅ Automatic Log Retention
The script automatically deletes logs older than **30 days** to save disk space.  
This behavior can be adjusted by modifying:
```bash
find /etc/monitoring/logs/ -type d -mtime +30 -exec rm -rf {} \;
```

---

## ✅ Future Suggestions
- Set up email alerts based on threshold conditions
- Integrate with a simple web dashboard to view logs in real time
