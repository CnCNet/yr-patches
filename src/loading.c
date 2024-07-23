#define _MSVCRT_
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define WINDOWS_LEAN_AND_MEAN
#include <windows.h>

#include "macros/patch.h"

#include "INIClass.h"

CALL(0x006BC0DC, _read_extra_options);


//extern INIClass RA2md_INI asm("_INIClass_RA2md_INI");
extern INIClass INIClass_RA2md_INI;
#define RA2md_INI INIClass_RA2md_INI

char AIMD_INI[256] = "AIMD.INI";

extern bool NoCD__Disable_CD;
extern bool WindowedMode;
extern bool NoWindowFrame;
extern bool Graphics__Enable_Patch;
extern bool Disable_Movie_Playback;
extern bool Disable_Blowfish_DLL;
extern bool ClassicMode;
extern bool MPDEBUG;
extern bool MPDEBUG1;
extern bool MPSYNCDEBUG;
extern bool Debug_Map;
extern bool Win8Compat;
extern bool SingleProcAffinity;

extern bool SkipScoreScreen;
extern bool DisableEdgeScrolling;

bool UsingTSDDRAW = false;
bool UsePNG = true;
bool DisableChat = false;

void SetSingleProcAffinity();

//SETDWORD(0x0052D357+1, _AIMD_INI);

// we mimmic INIClass::GetBool to end with original function call
bool __thiscall
read_extra_options(INIClass *old_INI, const char *section, const char *key, bool def)
{
	// this creates hook in .patch, linker is ignoring .patch from this file however

        NoCD__Disable_CD       	= INIClass__GetBool(&RA2md_INI, "Options", "NoCD", true);
	Graphics__Enable_Patch 	= INIClass__GetBool(&RA2md_INI, "Video", "UseGraphicsPatch", true);
	WindowedMode           	= INIClass__GetBool(&RA2md_INI, "Video", "Video.Windowed", false);
	NoWindowFrame           = INIClass__GetBool(&RA2md_INI, "Video", "NoWindowFrame", false);
	UsePNG                  = INIClass__GetBool(&RA2md_INI, "Video", "UsePNG", true);
	Disable_Movie_Playback	= INIClass__GetBool(&RA2md_INI, "Options", "DisableMoviePlayback", false);
	Disable_Blowfish_DLL	= INIClass__GetBool(&RA2md_INI, "Options", "DisableBlowfishDLL", false);
	INIClass__GetString(&RA2md_INI, "Files", "AIMD.INI", AIMD_INI, AIMD_INI, 256);
	ClassicMode             = INIClass__GetBool(&RA2md_INI, "Options", "ClassicMode", false);
	MPSYNCDEBUG = MPDEBUG1  = MPDEBUG
				= INIClass__GetBool(&RA2md_INI, "Options", "MPDEBUG", false);
        Win8Compat              = INIClass__GetBool(&RA2md_INI, "Options", "Win8Compat", false);

        SingleProcAffinity      = INIClass__GetBool(&RA2md_INI, "Options", "SingleProcAffinity", true);
        DisableChat             = INIClass__GetBool(&RA2md_INI, "Options", "DisableChat", false);
        SetSingleProcAffinity();

        HMODULE hDDraw = LoadLibraryA("ddraw.dll");
        bool *isDDraw = (bool *)GetProcAddress(hDDraw, "TSDDRAW");

        UsingTSDDRAW = isDDraw && *isDDraw;

        LPDWORD TargetFPS = (LPDWORD)GetProcAddress(hDDraw, "TargetFPS");
        if (TargetFPS)
        {
            *TargetFPS = INIClass__GetInt(&RA2md_INI, "Video", "DDrawTargetFPS", *TargetFPS);
        }

        bool *handleClose = (bool *)GetProcAddress(hDDraw, "GameHandlesClose");
        if (handleClose)
            *handleClose = true;


#ifdef SPAWNER
        SkipScoreScreen         = INIClass__GetBool(&RA2md_INI, "Options", "SkipScoreScreen", false);
        DisableEdgeScrolling    = INIClass__GetBool(&RA2md_INI, "Options", "DisableEdgeScrolling", false);
#endif
	// original command
	return INIClass__GetBool(old_INI, section, key, def);
}
