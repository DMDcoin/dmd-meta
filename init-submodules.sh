#!/bin/bash

echo "getting defined submodules"
# git submodule update -r
git submodule update --init --recursive

echo "warning: NPM Version requirements are not checked in this script"
echo "local instal of node dependencies"
cd diamond-contracts-core && npm i && cd ..
cd diamond-contracts-dao && npm i && cd ..
cd diamond-contracts-claiming && npm i && cd ..
cd diamond-contracts-views && npm i && cd ..

cd diamond-dev-tools && npm i && npm run localnet-create-mnemonic && cd ..

rustup default 1.85
cd diamond-node && export RUSTFLAGS='-C target-cpu=native' && cargo build --release