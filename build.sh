#!/usr/bin/bash

debug=""

while getopts ":d" opt; do
    case $opt in
        d)     
            debug="-DDEBUG=1"
        ;;
    esac
done

rm build/dash_working.sfc build/dash_working.bps
cp build/supermetroid.sfc build/dash_working.sfc
./bin/linux/asar --symbols=wla $debug src/main.asm build/dash_working.sfc
./bin/linux/flips-linux -c --bps build/supermetroid.sfc build/dash_working.sfc build/dash_working.bps
