#define _MSVCRT_
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define WINDOWS_LEAN_AND_MEAN
#include <windows.h>

#include "macros/patch.h"

#include "INIClass.h"

extern int PlayersHandicaps[];

void __thiscall Load_Selectable_Handicaps()
{
    PlayersHandicaps[0] = INIClass__GetInt(&INIClass_SPAWN, "HouseHandicaps", "Multi1", -1);
    PlayersHandicaps[1] = INIClass__GetInt(&INIClass_SPAWN, "HouseHandicaps", "Multi2", -1);
    PlayersHandicaps[2] = INIClass__GetInt(&INIClass_SPAWN, "HouseHandicaps", "Multi3", -1);
    PlayersHandicaps[3] = INIClass__GetInt(&INIClass_SPAWN, "HouseHandicaps", "Multi4", -1);
    PlayersHandicaps[4] = INIClass__GetInt(&INIClass_SPAWN, "HouseHandicaps", "Multi5", -1);
    PlayersHandicaps[5] = INIClass__GetInt(&INIClass_SPAWN, "HouseHandicaps", "Multi6", -1);
    PlayersHandicaps[6] = INIClass__GetInt(&INIClass_SPAWN, "HouseHandicaps", "Multi7", -1);
    PlayersHandicaps[7] = INIClass__GetInt(&INIClass_SPAWN, "HouseHandicaps", "Multi8", -1);
}