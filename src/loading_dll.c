#define _MSVCRT_
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define WINDOWS_LEAN_AND_MEAN
#include <windows.h>

#include "macros/patch.h"

#include "INIClass.h"

//FIX ME PLZ, WINDOWED tag doesn't work

//extern INIClass RA2md_INI asm("_INIClass_RA2md_INI");
extern INIClass INIClass_RA2md_INI;
#define RA2md_INI INIClass_RA2md_INI

extern bool WindowedMode;
extern bool NoWindowFrame;
bool UsingTSDDRAW = false;
extern bool SingleProcAffinity;
extern bool SkipScoreScreen;
extern bool DisableEdgeScrolling;

void SetSingleProcAffinity();

CALL(0x006BC0DC, _read_extra_options);

// we mimmic INIClass::GetBool to end with original function call
bool __thiscall
read_extra_options(INIClass *old_INI, const char *section, const char *key, bool def)
{
	// this creates hook in .patch, linker is ignoring .patch from this file however

	WindowedMode           	= INIClass__GetBool(&RA2md_INI, "Video", "Video.Windowed", false);
	NoWindowFrame           = INIClass__GetBool(&RA2md_INI, "Video", "NoWindowFrame", false);
        SingleProcAffinity      = INIClass__GetBool(&RA2md_INI, "Options", "SingleProcAffinity", true);
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
            *handleClose = !INIClass__GetBool(&RA2md_INI, "Options", "DDrawHandlesClose", false);

        SkipScoreScreen         = INIClass__GetBool(&RA2md_INI, "Options", "SkipScoreScreen", false);
        DisableEdgeScrolling    = INIClass__GetBool(&RA2md_INI, "Options", "DisableEdgeScrolling", false);

	// original command
	return INIClass__GetBool(old_INI, section, key, def);
}
