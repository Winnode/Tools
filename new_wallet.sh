#!/bin/bash

mapfile -t MNEMONICS < seed.txt

PASSPHRASE="pass"

sleep 5

for ((i=1; i<=100; i++))
do

  MNEMONIC="${MNEMONICS[i-1]}"


  [chain] keys add a$i --recover --interactive <<EOF
$MNEMONIC

$PASSPHRASE
EOF


  sleep 5
done