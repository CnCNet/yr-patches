# Red Alert 2 - Yuri's Revenge

> [!WARNING]
> This project is outdated. Use [**yrpp-spawner**](https://github.com/CnCNet/yrpp-spawner) instead.

Random enhancements and bug fixes for Command and Conquer: Red Alert 2 - Yuri's Revenge

## Instructions

- Download the following file and extract it somewhere: https://downloads.cncnet.org/win-builds-for-patching.zip
- Start win-install.bat

## Building

### Prerequisites

- GNU Make
- MinGW-W64
- NASM
- PETool (itself requiring GCC, make, etc)

On Unix, everything but PETool is installable via your package manager.

On Windows, please install MSYS 2 (a separate project from the original MSYS).
MSYS 2 provides a minimal \*nix environment, including a port of `pacman`, the
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

# Credits

This project builds on work from [ts-patches](https://github.com/CnCNet/ts-patches).
Contributors appear in the order of their first documented contribution to this family of patches.

- **[Iran](https://github.com/mvdhout1992)**:
  - Initial support for launching matches and configuring them through `spawn.ini`
  - Player color, country, handicap, start position and alliance selection
  - Spectator seats and radar view
  - Initial match statistics output
  - No-CD startup and handling of missing CD media files
  - Original copy-protection bypass
  - Fixes for cooperative scenario loading and endgame crashes
  - Skirmish spectators with loading screens and game-speed control
  - Fixes for the vanilla self-spy and invisible MCV exploits, and for the Prism Support Modifier calculation
  - Windows 8 compatibility and multi-engineer behavior enhancements
  - Options to disable Blowfish DLL loading and movie playback
  - Configurable use of AlexB's graphics patch
  - Contributions to the private anti-cheat component

- **[hifi (Toni Spets)](https://github.com/hifi)**:
  - Peer-to-peer networking and CnCNet tunneling
  - Original frameless window mode in `ts-patches`
  - Syringe DLL build support for Ares
  - Contributions to the private anti-cheat component

- **[AlexB](https://forums.cncnz.com/profile/7254-alexb/)**:
  - Original graphics patch for improved rendering performance ([author's release post](https://ppmforums.com/topic-32580/ddrawdll-alternative-request-for-testing/))

- **[CCHyper](https://github.com/CCHyper)**:
  - Initial statistics dump hooks
  - Contributions to the private anti-cheat component

- **[Sonarpulse (John Ericson)](https://github.com/Ericson2314)**:
  - Ported peer-to-peer networking and CnCNet tunneling from assembly to shared C code
  - Shared build infrastructure and DLL patch loading
  - Contributions to the private anti-cheat component

- **[FunkyFr3sh](https://github.com/FunkyFr3sh)**:
  - Random listen port for tunnel games
  - Original `spawn.ini` controls for `FrameSendRate` and `MaxAhead` in `ts-patches`
  - Added the Windows 8/10 compatibility patch to standard executable builds
  - Early work and continued improvements to the private anti-cheat component

- **[dkeeton (Daniel Keeton Jr)](https://github.com/dkeetonx)**:
  - Rewrote the `spawn.ini` loader in C
  - Automatic frameless window mode in `ts-patches` when game and desktop resolutions match
  - Original `Saved Games` subdirectory handling in `ts-patches`
  - Original Protocol Zero implementation in `ts-patches`
  - Map, scenario and alliance fields in match statistics
  - Random map support
  - Configurable reconnection timeout
  - Quick Match player-name hiding and tournament settings
  - Optional score-screen skip
  - Ported configurable frame send rate and network lookahead to Yuri's Revenge
  - Completed statistics dump and added map hash, alliances, captured buildings and duration
  - Red Alert 2 mode support for asset loading, type selection and allied service depot repairs
  - Single-core affinity and `DDrawTargetFPS` option
  - High-resolution sidebar fix and configurable `Win8Compat` option
  - Edge-scrolling toggle, first implemented in `ts-patches`
  - Multiplayer surrender and exit on window close
  - Reduced CPU usage while waiting for players and fixed vanilla game crashes
  - Vanilla Chrono veterancy bug fix
  - Contributions to the private anti-cheat component

- **[tomsons26](https://github.com/tomsons26)**:
  - Ported start position selection and predetermined alliances to C
  - Savegame loading in the original spawner
  - Yuri's Revenge port of `Saved Games` subdirectory handling from `ts-patches`
  - Yuri's Revenge port of the frameless window option from `ts-patches`
  - Rewrote the copy-protection bypass in C for spawner launches
  - Workaround for the mouse detection error on Windows 8 and later
  - Contributions to the private anti-cheat component

- **[Rampastring](https://github.com/Rampastring)**:
  - Contributions to the private anti-cheat component
  - Fix for Chrono Legionnaires instantly erasing targets after a Chronosphere shift

- **[E1Elite](https://github.com/E1Elite)**:
  - Large-map `IsoMapPack5` decoding limit extension

- **[Kerbiter](https://github.com/Metadorius)**:
  - Configurable connection timeout

- **[Belonit](https://github.com/Belonit)**:
  - Port of Protocol Zero from `ts-patches` to Yuri's Revenge
  - Created the spawner dialog initialization fix later integrated in [#2](https://github.com/CnCNet/yr-patches/pull/2)
  - Enabled the multi-observer patch in DLL builds
  - Ported Starkku's Phobos observer visibility patch for cloaked and disguised objects to Yuri's Revenge, adding selection and allied player support
  - Spawn waypoint, AI player and latency mode fields in match statistics
  - `DDrawHandlesClose` option for DLL builds

- **[Starkku](https://github.com/Starkku)**:
  - Enabled crates for single-player missions regardless of the match setting
  - Original observer visibility of cloaked and disguised objects in Phobos ([#15](https://github.com/CnCNet/yr-patches/issues/15))

- **[Burg (alexp8)](https://github.com/alexp8)**:
  - Fixed a spectator-mode bug in Red Alert 2 mode by removing the observer palette hooks

- **[secsome](https://github.com/secsome)**:
  - Integrated the spawner dialog initialization fix in [#2](https://github.com/CnCNet/yr-patches/pull/2)

- **[shmocz](https://github.com/shmocz)**:
  - Added a per-match `DisableChat` option for the CnCNet YR build that blocks incoming and outgoing player messages

- **[ZivDero](https://github.com/ZivDero)**:
  - Linked unit cheering to the taunt setting, so disabling taunts also stops cheering

- **[RAZER](https://github.com/CnCRAZER)**:
  - Added a per-match `DisableGameSpeed` option that disables the game-speed slider

## Sponsored by

<a href="https://www.digitalocean.com/?refcode=337544e2ec7b&utm_campaign=Referral_Invite&utm_medium=opensource&utm_source=CnCNet" title="Powered by Digital Ocean" target="_blank">
    <img src="https://opensource.nyc3.cdn.digitaloceanspaces.com/attribution/assets/PoweredByDO/DO_Powered_by_Badge_blue.svg" width="201px" alt="Powered By Digital Ocean" />
</a>
