@echo off
REM
REM cnc-patch build dll
REM
call setenv.cmd
gmake clean
pause
gmake -j8 SPAWNER=1 STATS=1 dll
move cncnet-spawn.dll cncnet5.dll
pause
