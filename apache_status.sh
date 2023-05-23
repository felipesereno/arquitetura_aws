#!/bin/bash

online_file="/home/ec2-user/nfs/online.log"
offline_file="/home/ec2-user/nfs/offline.log"

current_date=$(TZ=America/Sao_Paulo date +"%d-%m-%Y %H:%M:%S")

if systemctl is-active --quiet httpd; then
    echo "Serviço do Apache está ativo."
    if [ ! -f "$online_file" ]; thenvim
        echo "Criando arquivo $online_file..."
        echo "[$current_date] + APACHE + ONLINE + SERVIDOR WEB ATIVO." > "$online_file"
    else
        echo "Adicionando mensagem de log a $online_file..."
        echo "[$current_date] + APACHE + ONLINE + SERVIDOR WEB ATIVO." >> "$online_file"
    fi
else
    echo "Serviço do Apache está inativo."
    if [ ! -f "$offline_file" ]; then
        echo "Criando arquivo $offline_file..."
        echo "[$current_date] + APACHE + OFFLINE + SERVIDOR WEB INATIVO." > "$offline_file"
    else
        echo "Adicionando mensagem de log a $offline_file..."
        echo "[$current_date] + APACHE + OFFLINE + SERVIDOR WEB INATIVO." >> "$offline_file"
    fi
fi
