#define _MSVCRT_
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define WINDOWS_LEAN_AND_MEAN
#include <windows.h>

#include "macros/patch.h"

#include "INIClass.hpp"

extern INIClass RA2md_INI asm("_INIClass_RA2md_INI");

extern "C" {
    extern char *str_Options;
    extern char *str_Video;

    extern bool IsNoCD;
    extern bool UseGraphicsPatch;
    extern bool WindowedMode;

    bool __thiscall read_extra_options (INIClass*, const char*, const char*, bool);
}

LJMP(0x006BC0DC, &read_extra_options);

// we mimmic INIClass::GetBool to end with original function call
bool __thiscall
read_extra_options(INIClass *old_INI, const char *section, const char *key, bool def)
{
    // this creates hook in .patch, linker is ignoring .patch from this file however


    IsNoCD           = RA2md_INI.GetBool("Options", "NoCD", false);
    UseGraphicsPatch = RA2md_INI.GetBool("Video", "UseGraphicsPatch", true);
    WindowedMode     = RA2md_INI.GetBool("Video", "Windowed", false);

    // original command
    return old_INI->GetBool(section, key, def);
}
