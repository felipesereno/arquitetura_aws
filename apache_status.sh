#!/bin/bash

online_file="/home/ec2-user/nfs/online.log"
offline_file="/home/ec2-user/nfs/offline.log"

current_date=$(TZ=America/Sao_Paulo date +"%d-%m-%Y %H:%M:%S")

if systemctl is-active --quiet httpd; then
    if [ ! -f "$online_file" ]; then
        echo "[$current_date] + APACHE + ONLINE + SERVIDOR WEB ATIVO." > "$online_file"
    else
        echo "[$current_date] + APACHE + ONLINE + SERVIDOR WEB ATIVO." >> "$online_file"
    fi
else
    if [ ! -f "$offline_file" ]; then
        echo "[$current_date] + APACHE + OFFLINE + SERVIDOR WEB INATIVO." > "$offline_file"
    else
        echo "[$current_date] + APACHE + OFFLINE + SERVIDOR WEB INATIVO." >> "$offline_file"
    fi
fi
