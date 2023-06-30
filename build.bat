@echo off

set BIN=bin\windows
set VANILLA=build\SuperMetroid.sfc

if not exist %VANILLA% (
   echo Missing vanilla rom: %VANILLA%
   pause
   exit 1
)

set ROOT_NAME=build\dash_standard
set ROM=%ROOT_NAME%.sfc
set PATCH=%ROOT_NAME%.bps

if exist %ROM% del /Q %ROM%
if exist %PATCH% del /Q %PATCH%
if exist %ROOT_NAME%.cpu.sym del /Q %ROOT_NAME%.cpu.sym
if exist %ROOT_NAME%.smp.sym del /Q %ROOT_NAME%.smp.sym
if exist %ROOT_NAME%.sym del /Q %ROOT_NAME%.sym
if exist %ROOT_NAME%.srm del /Q %ROOT_NAME%.srm

copy %VANILLA% %ROM%
%BIN%\asar.exe --symbols=wla src\main.asm %ROM%
%BIN%\flips.exe --create --bps %VANILLA% %ROM% %PATCH%

set ROOT_NAME=build\dash_standard_area
set ROM=%ROOT_NAME%.sfc
set PATCH=%ROOT_NAME%.bps

if exist %ROM% del /Q %ROM%
if exist %PATCH% del /Q %PATCH%
if exist %ROOT_NAME%.cpu.sym del /Q %ROOT_NAME%.cpu.sym
if exist %ROOT_NAME%.smp.sym del /Q %ROOT_NAME%.smp.sym
if exist %ROOT_NAME%.sym del /Q %ROOT_NAME%.sym
if exist %ROOT_NAME%.srm del /Q %ROOT_NAME%.srm

copy %VANILLA% %ROM%
%BIN%\asar.exe --symbols=wla -DAREA=1 src\main.asm %ROM%
%BIN%\flips.exe --create --bps %VANILLA% %ROM% %PATCH%

set ROOT_NAME=build\dash_recall
set ROM=%ROOT_NAME%.sfc
set PATCH=%ROOT_NAME%.bps

if exist %ROM% del /Q %ROM%
if exist %PATCH% del /Q %PATCH%
if exist %ROOT_NAME%.cpu.sym del /Q %ROOT_NAME%.cpu.sym
if exist %ROOT_NAME%.smp.sym del /Q %ROOT_NAME%.smp.sym
if exist %ROOT_NAME%.sym del /Q %ROOT_NAME%.sym
if exist %ROOT_NAME%.srm del /Q %ROOT_NAME%.srm

copy %VANILLA% %ROM%
%BIN%\asar.exe --symbols=wla -DRECALL=1 src\main.asm %ROM%
%BIN%\flips.exe --create --bps %VANILLA% %ROM% %PATCH%

set ROOT_NAME=build\dash_recall_area
set ROM=%ROOT_NAME%.sfc
set PATCH=%ROOT_NAME%.bps

if exist %ROM% del /Q %ROM%
if exist %PATCH% del /Q %PATCH%
if exist %ROOT_NAME%.cpu.sym del /Q %ROOT_NAME%.cpu.sym
if exist %ROOT_NAME%.smp.sym del /Q %ROOT_NAME%.smp.sym
if exist %ROOT_NAME%.sym del /Q %ROOT_NAME%.sym
if exist %ROOT_NAME%.srm del /Q %ROOT_NAME%.srm

copy %VANILLA% %ROM%
%BIN%\asar.exe --symbols=wla -DRECALL=1 -DAREA=1 src\main.asm %ROM%
%BIN%\flips.exe --create --bps %VANILLA% %ROM% %PATCH%

pause
