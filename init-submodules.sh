#!/bin/bash

echo "getting defined submodules"
# git submodule update -r
git submodule update --init --recursive

echo "warning: NPM Version requirements are not checked in this script"
echo "local instal of node dependencies"
cd diamond-contracts-core && npm i && cd ..
cd diamond-contracts-dao && npm i && cd ..
cd diamond-contracts-claiming && npm i && cd ..
# note: honey-badger-testing has postinstall scripts that use the other projects.
cd honey-badger-testing && npm i && cd ..