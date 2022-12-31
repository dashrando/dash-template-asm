#!/usr/bin/bash

rm build/dash_working.sfc build/dash_working.bps
cp build/supermetroid.sfc build/dash_working.sfc
./bin/linux/asar --symbols=wla src/main.asm build/dash_working.sfc
./bin/linux/flips-linux -c --bps build/supermetroid.sfc build/dash_working.sfc build/dash_working.bps
