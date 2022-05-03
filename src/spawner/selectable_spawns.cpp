#define _MSVCRT_
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define WINDOWS_LEAN_AND_MEAN
#include <windows.h>

#include "macros/patch.h"

#include "INIClass.h"

extern void** HouseClassArray;
extern int HouseClassArray_Count;

void Load_Selectable_Spawns()
{
    void **houses = HouseClassArray;

    for (int i = 0; i + 2 < HouseClassArray_Count; i++, houses++)
    {
        char multiX[8];
        sprintf(multiX, "Multi%d", i + 1);

        int *start = (int *)(*houses + 0x16058);

        *start = INIClass__GetInt(&INIClass_SPAWN, "SpawnLocations", multiX, -2);
    }
}
