#!/bin/bash

echo "getting defined submodules"
git submodule update -r

echo "warning: NPM Version requirements are not checked in this script"
echo "local instal of node dependencies"
cd diamond-contracts-core && npm i && cd ..
cd diamond-contracts-dao && npm i && cd ..
cd diamond-contracts-claiming && npm i && cd ..
cd honey-badger-testing && nvm use && npm i && cd ..