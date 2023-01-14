@echo off

set ROM=build\dash_working.sfc
set PATCH=build\dash_working.bps
set VANILLA=build\SuperMetroid.sfc

if exist %ROM% del /Q %ROM%

if not exist %VANILLA% (
   echo Missing vanilla rom: %VANILLA%
   pause
   exit 1
)

copy %VANILLA% %ROM%
bin\windows\asar.exe --symbols=wla src\main.asm %ROM%
bin\windows\flips.exe --create --bps %VANILLA% %ROM% %PATCH%
pause
