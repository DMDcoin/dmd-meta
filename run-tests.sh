#!/bin/sh

echo "Executes End2End test on a initialized setup."
rm -rf /some/dir
mkdir -p out/latest

echo "memorizing End2End test setup data."
starttime=$(date +"%Y_%m_%d_%H_%M_%S")

echo $starttime >> out/latest/starttime.txt
echo "starttime: "$starttime

git submodule -q foreach 'git remote get-url origin --push && git rev-parse HEAD' > out/latest/versions.txt 

echo "version:"
cat out/latest/versions.txt 
echo "starting test, read /out/latest/main.log for more information..."
cd honey-badger-testing && npm run testnet-testrun-auto-restake >> ../out/latest/main.log || true
cd ..
mkdir -p out/latest/node_logs/
mv honey-badger-testing/testnet/nodes-local-test-auto-restake/node*/diamond-node.log out/latest/node_logs/
# cleanup
pkill diamond-node
echo "cleanup end"
