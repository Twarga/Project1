#!/bin/bash

backup_date=$(date +%Y-%m-%d)
backup_base_dir="/home/backups"

# Create the main backup directory
backup_dir="$backup_base_dir/$backup_date"
mkdir -p "$backup_dir"

# Rocky Linux DB Server (192.168.100.25) Backup
backup_db_dir="$backup_dir/db"
mkdir -p "$backup_db_dir"
mysqldump -u root -ptwarga laravel >"$backup_db_dir/db_backup.sql"

# Ubuntu Web Server (192.168.100.31) Backup
backup_web_dir="$backup_dir/webserver"
mkdir -p "$backup_web_dir"
rsync -avz --delete /var/www/html/ "$backup_web_dir/www/"

# CentOS DNS Server (192.168.100.32) Backup
backup_dns_dir="$backup_dir/dns"
mkdir -p "$backup_dns_dir"
rsync -avz --delete /var/named/ "$backup_dns_dir/named/"

# Ubuntu Nextcloud Server (192.168.100.28) Backup
backup_nextcloud_dir="$backup_dir/nextcloud"
mkdir -p "$backup_nextcloud_dir"
rsync -avz --delete /var/www/html/nextcloud/data/ "$backup_nextcloud_dir/data/"
cp /var/www/html/nextcloud/config/config.php "$backup_nextcloud_dir/config.php"

# Customize the paths and settings as per your actual configurations
