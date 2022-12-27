@echo off
REM
REM cnc-patch build Debug dll
REM
call setenv.cmd
gmake clean
pause
gmake -j8 SPAWNER=1 STATS=1 WWDEBUG=1 dll
move cncnet-spawn.dll cncnet5.dll
pause
