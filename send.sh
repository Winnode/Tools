#!/bin/bash


DESTINATION_ADDRESS="Address"

amount="xxxx"

options="xxxxx"

KEYRING_PASSPHRASE="pass"

while true
do

    for ((i=1; i<=1000; i++))
    do

        output=$([chain] tx bank send a$i "$DESTINATION_ADDRESS" $amount $options <<EOF
$KEYRING_PASSPHRASE
EOF
)

        if [[ $output == *"failed"* ]]; then
            echo "Transaksi dari a$i gagal. Melanjutkan ke wallet berikutnya..."
        else
            echo "Transaksi dari a$i berhasil."
        fi
		sleep 5
    done

    echo "Menunggu selama 24 jam sebelum mengirim lagi..."
    sleep 86400
done