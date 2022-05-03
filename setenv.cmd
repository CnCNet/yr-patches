REM
REM cnc-patch environment config
REM
set PATH=%PATH%;C:\win-builds-patch-32\bin;C:\win-builds-patch-32\i686-w64-mingw32\bin
git --version
ld --version
as --version
ld --version
strip --version
echo CC = i686-w64-mingw32-gcc > config.mk
echo AS = as >> config.mk 
echo LD = ld >> config.mk 
echo STRIP = strip >> config.mk