@echo off

set ROOT_NAME=build\dash_working
set ROM=%ROOT_NAME%.sfc
set PATCH=%ROOT_NAME%.bps

set STD_NAME=build\dash_std
set STD_ROM=%STD_NAME%.sfc
set STD_PATCH=%STD_NAME%.bps

set VANILLA=build\SuperMetroid.sfc

if not exist %VANILLA% (
   echo Missing vanilla rom: %VANILLA%
   pause
   exit 1
)

if exist %ROM% del /Q %ROM%
if exist %ROOT_NAME%.cpu.sym del /Q %ROOT_NAME%.cpu.sym
if exist %ROOT_NAME%.smp.sym del /Q %ROOT_NAME%.smp.sym
if exist %ROOT_NAME%.sym del /Q %ROOT_NAME%.sym
if exist %ROOT_NAME%.srm del /Q %ROOT_NAME%.srm

bin\windows\asar.exe -Dpos=1155 build\dd.asm build/tiles1.bin
bin\windows\flips.exe -a --exact data/heatshield.bps build/tiles1.bin data/heatshield.bin
rm build/tiles1.bin

bin\windows\asar.exe -Dpos=1158 build\dd.asm build/tiles2.bin
bin\windows\flips.exe -a --exact data/doublejump.bps build/tiles2.bin data/doublejump.bin
rm build/tiles2.bin

copy %VANILLA% %ROM%
bin\windows\asar.exe --symbols=wla src\main.asm %ROM%
bin\windows\flips.exe --create --bps %VANILLA% %ROM% %PATCH%

copy %VANILLA% %STD_ROM%
bin\windows\asar.exe --symbols=wla -DSTD=1 src\main.asm %STD_ROM%
bin\windows\flips.exe --create --bps %VANILLA% %STD_ROM% %STD_PATCH%

del /Q data\heatshield.bin
del /Q data\doublejump.bin
pause
