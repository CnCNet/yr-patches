#define _MSVCRT_
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define WINDOWS_LEAN_AND_MEAN
#include <windows.h>

#include "macros/patch.h"

#include "INIClass.h"

extern int PlayersCountries[];

void __thiscall Load_Selectable_Countries()
{
    PlayersCountries[0] = INIClass__GetInt(&INIClass_SPAWN, "HouseCountries", "Multi1", -1);
    PlayersCountries[1] = INIClass__GetInt(&INIClass_SPAWN, "HouseCountries", "Multi2", -1);
    PlayersCountries[2] = INIClass__GetInt(&INIClass_SPAWN, "HouseCountries", "Multi3", -1);
    PlayersCountries[3] = INIClass__GetInt(&INIClass_SPAWN, "HouseCountries", "Multi4", -1);
    PlayersCountries[4] = INIClass__GetInt(&INIClass_SPAWN, "HouseCountries", "Multi5", -1);
    PlayersCountries[5] = INIClass__GetInt(&INIClass_SPAWN, "HouseCountries", "Multi6", -1);
    PlayersCountries[6] = INIClass__GetInt(&INIClass_SPAWN, "HouseCountries", "Multi7", -1);
    PlayersCountries[7] = INIClass__GetInt(&INIClass_SPAWN, "HouseCountries", "Multi8", -1);
}