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

    # Opsi tambahan
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