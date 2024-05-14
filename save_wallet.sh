#!/bin/bash

KEYRING_PASSPHRASE="pass"

KEY_LIST=$(wardend keys list <<EOF
$KEYRING_PASSPHRASE
EOF
)


echo "$KEY_LIST" | grep -oP '(?<=address: ).*' > wallet.txt


echo "Addresses saved to wallet.txt:"
cat wallet.txt