#!/usr/bin/env bash

bin=./bin/macos
arc="$(uname -m)"
flips=""
if [ "$arc" == "arm64" ]; then
    flips=flips-m1
else
    flips=flips-intel
fi
debug=""

echo "Building for $arc"
echo "Using $flips"

while getopts ":d" opt; do
    case $opt in
        d)     
            debug="-DDEBUG=1"
        ;;
    esac
done

root=build/dash_standard
rm -f $root.sfc $root.bps
cp build/supermetroid.sfc $root.sfc

$bin/asar --symbols=wla $debug src/main.asm $root.sfc
$bin/$flips -c --bps build/supermetroid.sfc $root.sfc $root.bps

root=build/dash_standard_area
rm -f $root.sfc $root.bps
cp build/supermetroid.sfc $root.sfc

$bin/asar --symbols=wla -DAREA=1 $debug src/main.asm $root.sfc
$bin/$flips -c --bps build/supermetroid.sfc $root.sfc $root.bps

root=build/dash_recall
rm -f $root.sfc $root.bps
cp build/supermetroid.sfc $root.sfc

$bin/asar --symbols=wla -DRECALL=1 $debug src/main.asm $root.sfc
$bin/$flips -c --bps build/supermetroid.sfc $root.sfc $root.bps

root=build/dash_recall_area
rm -f $root.sfc $root.bps
cp build/supermetroid.sfc $root.sfc

$bin/asar --symbols=wla -DRECALL=1 -DAREA=1 $debug src/main.asm $root.sfc
$bin/$flips -c --bps build/supermetroid.sfc $root.sfc $root.bps
