#!/bin/bash

verificare_ip_dns() {
    local nume_host=$1
    local ip_hosts=$2
    local server_dns=$3

    real_ip=$(nslookup "$nume_host" "$server_dns" 2>/dev/null | awk '/^Address: / { print $2 }' | tail -n 1)

    if [[ -n "$real_ip" && "$real_ip" != "$ip_hosts" ]]; then
        echo "Bogus IP for $nume_host in /etc/hosts! (DNS $server_dns zice $real_ip)"
    fi
}

cat /etc/hosts | while read -r ip name rest
do
    [[ -z "$ip" || "$ip" =~ ^# ]] && continue
    [[ -z "$name" ]] && continue
    
    verificare_ip_dns "$name" "$ip" "8.8.8.8"
done

echo " HAHA ti-am schimbat codu" 
