@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin
gmake clean
pause
gmake dll SPAWNER=1 STATS=1
del mo-spawn.dll
ren mo-ares-spawn.dll mo-spawn.dll
pause
