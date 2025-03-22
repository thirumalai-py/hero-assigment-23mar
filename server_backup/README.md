# Backup Scripts for Apache and Nginx Servers

## Overview
This repository contains two automated backup scripts designed for regular backups of web server configurations and document root directories.

### Scripts Included:
- **Apache Backup Script** — for backing up Apache server configuration and document root.
- **Nginx Backup Script** — for backing up Nginx server configuration and document root.

## Backup Scope
- **Apache**:
  - Configuration directory: `/etc/httpd/` (or `/etc/apache2/` depending on the OS)
  - Document root: `/var/www/html/`
  - Backup destination: `/backup/apache/`

- **Nginx**:
  - Configuration directory: `/etc/nginx/`
  - Document root: `/usr/share/nginx/html/`
  - Backup destination: `/backup/nginx/`

## Features
- Automated backup creation with timestamped compressed files.
- Integrity verification by listing backup archive contents after each run.
- Organized backup files for easy identification and access.

## Setup Instructions
1. Copy the backup scripts to a safe location, such as `/usr/local/bin/`.
2. Make the scripts executable:
   - `sudo chmod +x /usr/local/bin/apache_backup.sh`
   - `sudo chmod +x /usr/local/bin/nginx_backup.sh`
3. Create backup directories if they do not exist:
   - `sudo mkdir -p /backup/apache /backup/nginx`
4. Set permissions to secure the backup directories.

## Automating Backups
Add the following cron jobs to schedule backups every Tuesday at 12:00 AM:
```
0 0 * * 2 /usr/local/bin/apache_backup.sh
0 0 * * 2 /usr/local/bin/nginx_backup.sh
```

## Verification
After each backup run, a verification log is generated showing the contents of the backup archive, ensuring backup integrity.

## Restore Guidance
To restore or test the backup, extract the archive using:
```
tar -xzf <backup-file> -C <destination-directory>
```

## Recommendations
- Regularly check backup logs for integrity.
- Customize retention policies to clean old backups.
- Update cron schedules based on organizational needs.
