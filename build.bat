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

copy %VANILLA% %ROM% >nul
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

copy %VANILLA% %ROM% >nul
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

copy %VANILLA% %ROM% >nul
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

copy %VANILLA% %ROM% > nul
%BIN%\asar.exe --symbols=wla -DRECALL=1 -DAREA=1 src\main.asm %ROM%
%BIN%\flips.exe --create --bps %VANILLA% %ROM% %PATCH%

set ROOT_NAME=build\interface
set ROM=%ROOT_NAME%.sfc
set JS_SRC=%ROOT_NAME%.js
if exist %JS_SRC% del /Q %JS_SRC%

if exist %ROM% del /Q %ROM%
copy %VANILLA% %ROM% > nul
%BIN%\asar.exe -DRECALL=1 -DAREA=1 -DINTERFACE=1 src\main.asm %ROM% > %JS_SRC%

if exist %ROM% del /Q %ROM%
copy %VANILLA% %ROM% > nul
%BIN%\asar.exe -DINTERFACE=1 src\main.asm %ROM% > build\std.js
FC /B %JS_SRC% build\std.js > nul
if %ERRORLEVEL% GTR 0 (
   echo ERROR! %JS_SRC% and build\std.js do not match
) else (
   del /Q build\std.js
)

if exist %ROM% del /Q %ROM%
copy %VANILLA% %ROM% > nul
%BIN%\asar.exe -DRECALL=1 -DINTERFACE=1 src\main.asm %ROM% > build\recall.js
FC /B %JS_SRC% build\recall.js > nul
if %ERRORLEVEL% GTR 0 (
   echo ERROR! %JS_SRC% and build\recall.js do not match
) else (
   del /Q build\recall.js
)

if exist %ROM% del /Q %ROM%
copy %VANILLA% %ROM% > nul
%BIN%\asar.exe -DAREA=1 -DINTERFACE=1 src\main.asm %ROM% > build\std_area.js
FC /B %JS_SRC% build\std_area.js > nul
if %ERRORLEVEL% GTR 0 (
   echo ERROR! %JS_SRC% and build\std_area.js do not match
) else (
   del /Q build\std_area.js
)

if exist %ROM% del /Q %ROM%

pause
