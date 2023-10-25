#!/usr/bin/bash

case "$(uname -s)" in
    Linux*)
        asar=./bin/linux/asar
        flips=./bin/linux/flips-linux
    ;;
    #Darwin*)    machine=Mac;;
    MSYS_NT*) ;&
    MINGW*) ;&
    CYGWIN*)
        asar=./bin/windows/asar.exe
        flips=./bin/windows/flips.exe
    ;;
    *)
        echo "Unknown OS"
        exit 1
    ;;
esac

debug=""
vanilla=./build/SuperMetroid.sfc

while getopts ":d" opt; do
    case $opt in
        d)     
            debug="-DDEBUG=1"
        ;;
    esac
done

function build {
    root=build/$1
    opts=$2

    rm -f $root.cpu.sym $root.smp.sym $root.sym $root.srm
    rm -f $root.sfc $root.bps
    cp $vanilla $root.sfc

    $asar --symbols=wla $opts $debug src/main.asm $root.sfc
    $flips -c --bps $vanilla $root.sfc $root.bps

    # Generate the JS interface file
    root=build/interface_$1
    rm -f $root.sfc $root.js
    cp $vanilla $root.sfc
    $asar -DINTERFACE=1 $opts src/main.asm $root.sfc > $root.js
    rm -f $root.sfc

    # Verify all configurations build the same interface file
    if [ -f build/interface.js ]; then
        diff -q ${root}.js build/interface.js > /dev/null
        if [ $? -ne 0 ]; then
            echo "ERROR! interface.js and ${root}.js do not match"
            exit 1
        else
            rm -f $root.js
        fi
    else
        mv $root.js build/interface.js
    fi
}

rm -f build/interface.js build/interface.ts

build dash_standard
build dash_standard_area "-DAREA=1"
build dash_recall "-DRECALL=1"
build dash_recall_area "-DRECALL=1 -DAREA=1"

cp build/interface.js build/interface.ts
