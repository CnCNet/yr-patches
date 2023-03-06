Red Alert 2 - Yuri's Revenge
================================================================================
Random enhancements and bug fixes for Command and Conquer: Red Alert 2 - Yuri's Revenge


Instructions
--------------------------------------------------------------------------------

 - Download the following file and extract it somewhere: https://downloads.cncnet.org/win-builds-for-patching.zip
 - Start win-install.bat


Building
--------------------------------------------------------------------------------

### Prerequisites

 - GNU Make
 - MinGW-W64
 - NASM
 - PETool (itself requiring GCC, make, etc)

On Unix, everything but PETool is installable via your package manager.

On Windows, please install MSYS 2 (a separate project from the original MSYS).
MSYS 2 provides a minimal *nix environment, including a port of `pacman`, the
Arch Linux package manager. Once MSYS 2 is installed, installing everything but
PETool will be just as easy as on Linux, just do `pacman -S <package>`.

PETool is a utility made by us to do the patching itself and tie some loose
ends. Please `git clone` its repo too, and run `make`. PETool is written in C
and should be compiled with the native toolchain (Mingw-w64 on windows). Then
copy the resulting `petool` or `petool.exe` to the directory where you `git
clone`d yr-patches. Finally edit `config.mk` so it contains the definition:

```make
PETOOL = ./petool
```

The makefile is designed to accommodate windows users who are not familiar with
the command line. Therefore the names of various executables are defined by
default to be their makefile names. Unix uses should edit `config.mk` with
`linux.config.mk` as a guide. This applies only to Engine 2 proper, not PETool.

### Instructions

Once everything is installed, just copy your YR executable to this repo under
the name `ra2/bin.dat`, run `make`, and copy the patched executables back to
your game installations. (Make sure to backup your original executables!)

Or if you rather just copy and paste some commands, do:

```sh
$ cd /path/to/yuris-revenge/installation
$ cp gamemd.exe gamemd-backup.exe
$ cd /path/to/yr-patches
$ cp /path/to/yr/installation/gamemd.exe ./ra2/bin.dat
$ make
$ cp ra2.exe /path/to/yr/installation/
```

From the shell (MinGW shell on Windows).

Credits
--------------------------------------------------------------------------------

 - Hifi
 - Iran
 - CCHyper
 - tomsons26
 - dkeeton
 - Sonarpulse
