#!/bin/bash

echo "🚀 Starting system monitoring setup..."

# Step 1: Install monitoring tools
echo "📦 Installing htop and nmon..."
sudo apt update
sudo apt install -y htop nmon

# Step 2: Setup directories
MONITOR_DIR=~/monitoring
LOG_DIR=$MONITOR_DIR/logs
mkdir -p $LOG_DIR

# Step 3: Create disk usage monitoring script
echo "📝 Creating disk usage monitoring script..."
cat > $MONITOR_DIR/disk_usage.sh << 'EOF'
#!/bin/bash
LOG_DIR=~/monitoring/logs
mkdir -p $LOG_DIR
DATE=$(date +"%Y-%m-%d_%H-%M")
df -h > $LOG_DIR/disk_usage_$DATE.log
du -sh /home/* /var/* >> $LOG_DIR/disk_usage_$DATE.log
EOF
chmod +x $MONITOR_DIR/disk_usage.sh

# Step 4: Create top processes monitoring script
echo "📝 Creating top process monitoring script..."
cat > $MONITOR_DIR/top_processes.sh << 'EOF'
#!/bin/bash
LOG_DIR=~/monitoring/logs
mkdir -p $LOG_DIR
DATE=$(date +"%Y-%m-%d_%H-%M")
ps aux --sort=-%cpu | head -n 15 > $LOG_DIR/top_cpu_$DATE.log
ps aux --sort=-%mem | head -n 15 > $LOG_DIR/top_mem_$DATE.log
EOF
chmod +x $MONITOR_DIR/top_processes.sh

# Step 5: Add cron jobs if not already present
echo "⏲️ Adding cron jobs..."

# Check and add disk usage cron
(crontab -l | grep -q "$MONITOR_DIR/disk_usage.sh") || \
  (crontab -l; echo "0 */6 * * * $MONITOR_DIR/disk_usage.sh") | crontab -

# Check and add top processes cron
(crontab -l | grep -q "$MONITOR_DIR/top_processes.sh") || \
  (crontab -l; echo "0 * * * * $MONITOR_DIR/top_processes.sh") | crontab -

echo "✅ System monitoring setup completed successfully!"
echo "📂 Logs will be available in: $LOG_DIR"
