@echo off
REM
REM cnc-patch normal build
REM
call setenv.cmd
gmake clean
pause
gmake -j8 SPAWNER=1 STATS=1 default
move gamemd-output.exe gamemd-spawn.exe
pause
