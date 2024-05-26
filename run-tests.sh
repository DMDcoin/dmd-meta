#!/bin/sh

echo "Executes End2End test on a initialized setup."

cd honey-badger-testing && npm run testnet-testrun-auto-restake
