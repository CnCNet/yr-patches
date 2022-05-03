@echo off
REM
REM cnc-patch normal build
REM
call setenv.cmd
gmake clean
pause
gmake SPAWNER=1 default
pause
