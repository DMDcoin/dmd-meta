#!/bin/sh

# cleanup from old tests

if [ -d "out/latest" ]; then
    lateststarttime=$(cat out/latest/starttime.txt)
    echo "backup of latest test results from $lateststarttime" 
    mkdir -p out/old
    mv out/latest out/old/$lateststarttime
fi

echo "Executes End2End test on a initialized setup."
rm -rf /some/dir
mkdir -p out/latest

echo "memorizing End2End test setup data."
starttime=$(date +"%Y_%m_%d_%H_%M_%S")

echo $starttime >> out/latest/starttime.txt
echo "starttime: "$starttime
lscpu >> out/latest/lscpu.txt

git submodule -q foreach 'git remote get-url origin --push && git rev-parse HEAD' > out/latest/versions.txt 

echo "version:"
cat out/latest/versions.txt 
echo "starting test, read /out/latest/main.log for more information..."
# todo: decide on building...
# &&  
cd honey-badger-testing 
npm run build-open-ethereum
npm run testnet-testrun-auto-restake 2>&1 | tee ../out/latest/main.log || true
cd ..
mkdir -p out/latest/node_logs/
rsync --recursive  --include="*/diamond-node.log" --filter="-! */"   --prune-empty-dirs  honey-badger-testing/testnet  out/latest/node_logs/

# cleanup
pkill diamond-node
echo "cleanup end"
