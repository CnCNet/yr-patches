@echo off
REM
REM cnc-patch Debug build
REM
call setenv.cmd
gmake clean
pause
gmake -j8 SPAWNER=1 STATS=1 CNCNET=1 WWDEBUG=1 default
move gamemd-output.exe gamemd-spawn.exe
pause
