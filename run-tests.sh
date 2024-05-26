#!/bin/sh

echo "Executes End2End test on a initialized setup."
rm -rf /some/dir
mkdir -p out/latest

starttime=$(date +"%Y_%m_%d_%H_%M_%S")

echo $starttime >> out/latest/starttime.txt

git submodule -q foreach 'git remote get-url origin --push && git rev-parse HEAD' > out/latest/versions.txt 

cd honey-badger-testing && npm run testnet-testrun-auto-restake >> out/latest/main.log || true

# cleanup
pkill diamond-node
