#!/usr/bin/bash

debug=""

while getopts ":d" opt; do
    case $opt in
        d)     
            debug="-DDEBUG=1"
        ;;
    esac
done

dd bs=256 count=1 skip=1155 if=build/supermetroid.sfc of=build/tiles1.bin status=none
./bin/linux/flips-linux -a --exact data/heatshield.bps build/tiles1.bin data/heatshield.bin
rm build/tiles1.bin

dd bs=256 count=1 skip=1158 if=build/supermetroid.sfc of=build/tiles2.bin status=none
./bin/linux/flips-linux -a --exact data/doublejump.bps build/tiles2.bin data/doublejump.bin
rm build/tiles2.bin

rm -f build/dash_working.sfc build/dash_working.bps
cp build/supermetroid.sfc build/dash_working.sfc

./bin/linux/asar --symbols=wla $debug src/main.asm build/dash_working.sfc
./bin/linux/flips-linux -c --bps build/supermetroid.sfc build/dash_working.sfc build/dash_working.bps

rm -f build/dash_std.sfc build/dash_std.bps
cp build/supermetroid.sfc build/dash_std.sfc

./bin/linux/asar --symbols=wla -DSTD=1 $debug src/main.asm build/dash_std.sfc
./bin/linux/flips-linux -c --bps build/supermetroid.sfc build/dash_std.sfc build/dash_std.bps

rm data/heatshield.bin
rm data/doublejump.bin
