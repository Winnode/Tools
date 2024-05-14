# Script Documentation

## Overview
This script automates the process of sending cURL requests through unused proxies and performing financial transactions using a command line tool. It continuously performs these operations every 24 hours.

## Components
1. **used_proxies.txt**: A file that stores the list of proxies that have already been used.
2. **get_unused_proxy()**: A function that fetches an unused proxy from a proxy provider.
3. **send_curl_requests()**: A function that sends POST requests using cURL with an unused proxy.
4. **send_money()**: A function that performs a series of financial transactions.
5. **Main Loop**: Repeats the sending of cURL requests and financial transactions every 24 hours.

## File Descriptions
- **used_proxies.txt**: This file keeps track of proxies that have been used to avoid reuse.
- **wallet.txt**: This file contains a list of addresses to which cURL requests will be sent.

## Script Description
```bash
#!/bin/bash

used_proxies="used_proxies.txt"

get_unused_proxy() {
    local proxy
    while true; do
        proxy=$(curl -s PROXY | shuf -n 1)
        if ! grep -q "$proxy" "$used_proxies"; then
            echo "$proxy" >> "$used_proxies"
            echo "$proxy"
            break
        fi
    done
}

send_curl_requests() {
    while read -r address; do
        proxy=$(get_unused_proxy)
        proxy_address=$(echo $proxy | cut -d ":" -f 1)
        proxy_port=$(echo $proxy | cut -d ":" -f 2)
        curl -s -x $proxy_address:$proxy_port -X POST -H "Content-Type: application/json" -d "{\"address\": \"$address\"}" LinkFaucet &
    done < wallet.txt
    wait
}

send_money() {
    DESTINATION_ADDRESS="adds"
    amount="xxxxxxxxxxxxx"
    options="xxxxxxxxxxxxxx"

    for ((i=1; i<=900; i++))
    do
        output=$(echo "pass" | wardend tx bank send a$i "$DESTINATION_ADDRESS" $amount $options --from a$i) &
    done
    wait
}

while true
do
    send_curl_requests
    send_money
    sleep $((24 * 60 * 60))
done
```
## Run
```
chmod +x script.sh
./script.sh
```
