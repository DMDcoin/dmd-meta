#!/bin/bash

mkdir out-watchdog | true
cd honey-badger-testing

while [ 1 ]; do
 echo "starting watchdog..."
 ./diamond-node -c=validator_node.toml
 npm run watchdog >> ../out-watchdog/watchdog-out.txt
 sleep 1s
done