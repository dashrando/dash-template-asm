#!/usr/bin/env bash

SCRIPT_PATH=$(realpath $0)
SCRIPT_DIR=$(dirname $SCRIPT_PATH)

BIP=../../bin/windows/bip.exe
ASAR=../../bin/windows/asar.exe
FLIPS=../../bin/windows/flips.exe
ROM=SuperMetroid.sfc
VANILLA=../../build/$ROM

pushd $SCRIPT_DIR > /dev/null

cp $VANILLA ./$ROM
$BIP -n $VANILLA fast_reload.ips ./$ROM
$BIP -n $VANILLA fast_saves.ips ./$ROM
$BIP -n $VANILLA fast_pause_menu.ips ./$ROM
$FLIPS -c --ips $VANILLA ./$ROM qol.ips
echo

$BIP -n $VANILLA fast_doors.ips ./$ROM
$BIP -n $VANILLA fast_mother_brain_cutscene.ips ./$ROM
$BIP -n $VANILLA fast_big_boy_cutscene.ips ./$ROM
$BIP -n $VANILLA elevators_speed.ips ./$ROM
$FLIPS -c --ips $VANILLA ./$ROM fast_mode.ips
rm ./$ROM

popd > /dev/null
