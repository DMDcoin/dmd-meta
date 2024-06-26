#!/bin/bash

mkdir out-watchdog | true
cd honey-badger-testing
npm run watchdog >> ../out-watchdog/watchdog-out.txt
