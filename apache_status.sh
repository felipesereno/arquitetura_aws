#!/bin/bash

online_file="/home/ec2-user/nfs/online.txt"
offline_file="/home/ec2-user/nfs/offline.txt"

current_date=$(TZ=America/Sao_Paulo date +"%d-%m-%Y %H:%M:%S")

# Check if Apache service is running
if systemctl is-active --quiet httpd; then
    echo "Apache server is running."
    if [ ! -f "$online_file" ]; then
        echo "Creating $online_file..."
        echo "[$current_date] + APACHE + ONLINE + SERVIDOR WEB ATIVO." > "$online_file"
    else
        echo "Appending message to $online_file..."
        echo "[$current_date] + APACHE + ONLINE + SERVIDOR WEB ATIVO." >> "$online_file"
    fi
else
    echo "Apache server is not running."
    if [ ! -f "$offline_file" ]; then
        echo "Creating $offline_file..."
        echo "[$current_date] + APACHE + OFFLINE + SERVIDOR WEB INATIVO." > "$offline_file"
    else
        echo "Appending message to $offline_file..."
        echo "[$current_date] + APACHE + OFFLINE + SERVIDOR WEB INATIVO." >> "$offline_file"
    fi
fi