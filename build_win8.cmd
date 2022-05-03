@echo off
REM
REM cnc-patch environment config
REM
set PATH=C:\win-builds-patch-32\bin
gmake clean
pause
gmake SPAWNER=1 WIN8=1
pause