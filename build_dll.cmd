@echo off
REM
REM cnc-patch build dll
REM
call setenv.cmd
gmake clean
pause
gmake dll SPAWNER=1 STATS=1
pause
