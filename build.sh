#!/usr/bin/bash

rm build/dash_working.sfc
cp build/supermetroid.sfc build/dash_working.sfc
./bin/linux/asar --symbols=wla src/main.asm build/dash_working.sfc

# TODO: flips stuff, windows script
