#define _MSVCRT_
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define WINDOWS_LEAN_AND_MEAN
#include <windows.h>

#include "macros/patch.h"

#include "INIClass.h"

extern int PlayersColors[];

void __thiscall Load_Selectable_Colors()
{
    PlayersColors[0] = INIClass__GetInt(&INIClass_SPAWN, "HouseColors", "Multi1", -1);
    PlayersColors[1] = INIClass__GetInt(&INIClass_SPAWN, "HouseColors", "Multi2", -1);
    PlayersColors[2] = INIClass__GetInt(&INIClass_SPAWN, "HouseColors", "Multi3", -1);
    PlayersColors[3] = INIClass__GetInt(&INIClass_SPAWN, "HouseColors", "Multi4", -1);
    PlayersColors[4] = INIClass__GetInt(&INIClass_SPAWN, "HouseColors", "Multi5", -1);
    PlayersColors[5] = INIClass__GetInt(&INIClass_SPAWN, "HouseColors", "Multi6", -1);
    PlayersColors[6] = INIClass__GetInt(&INIClass_SPAWN, "HouseColors", "Multi7", -1);
    PlayersColors[7] = INIClass__GetInt(&INIClass_SPAWN, "HouseColors", "Multi8", -1);
}