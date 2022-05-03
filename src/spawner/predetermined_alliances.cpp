#define _MSVCRT_
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>

#define WINDOWS_LEAN_AND_MEAN
#include <windows.h>

#include "macros/patch.h"

#include "INIClass.h"
#include "HouseClass.h"

extern void** HouseClassArray;

void Check_Alliance_State(char* section, char* key, void* house)
{
    int32_t state = INIClass__GetInt(&INIClass_SPAWN, section, key, -1);
    if ( state != -1 )
    {
        HouseClass__Make_Ally_id(house, state, 0);
    }
}

void Load_Predetermined_Alliances()
{
	//Check Player 1
    Check_Alliance_State("Multi1_Alliances", "HouseAllyOne",   HouseClassArray[0]);
    Check_Alliance_State("Multi1_Alliances", "HouseAllyTwo",   HouseClassArray[0]);
    Check_Alliance_State("Multi1_Alliances", "HouseAllyThree", HouseClassArray[0]);
    Check_Alliance_State("Multi1_Alliances", "HouseAllyFour",  HouseClassArray[0]);
    Check_Alliance_State("Multi1_Alliances", "HouseAllyFive",  HouseClassArray[0]);
    Check_Alliance_State("Multi1_Alliances", "HouseAllySix",   HouseClassArray[0]);
    Check_Alliance_State("Multi1_Alliances", "HouseAllySeven", HouseClassArray[0]);
    Check_Alliance_State("Multi1_Alliances", "HouseAllyEight", HouseClassArray[0]);

	//Check Player 2
    Check_Alliance_State("Multi2_Alliances", "HouseAllyOne",   HouseClassArray[1]);
    Check_Alliance_State("Multi2_Alliances", "HouseAllyTwo",   HouseClassArray[1]);
    Check_Alliance_State("Multi2_Alliances", "HouseAllyThree", HouseClassArray[1]);
    Check_Alliance_State("Multi2_Alliances", "HouseAllyFour",  HouseClassArray[1]);
    Check_Alliance_State("Multi2_Alliances", "HouseAllyFive",  HouseClassArray[1]);
    Check_Alliance_State("Multi2_Alliances", "HouseAllySix",   HouseClassArray[1]);
    Check_Alliance_State("Multi2_Alliances", "HouseAllySeven", HouseClassArray[1]);
    Check_Alliance_State("Multi2_Alliances", "HouseAllyEight", HouseClassArray[1]);

	//Check Player 3
    Check_Alliance_State("Multi3_Alliances", "HouseAllyOne",   HouseClassArray[2]);
    Check_Alliance_State("Multi3_Alliances", "HouseAllyTwo",   HouseClassArray[2]);
    Check_Alliance_State("Multi3_Alliances", "HouseAllyThree", HouseClassArray[2]);
    Check_Alliance_State("Multi3_Alliances", "HouseAllyFour",  HouseClassArray[2]);
    Check_Alliance_State("Multi3_Alliances", "HouseAllyFive",  HouseClassArray[2]);
    Check_Alliance_State("Multi3_Alliances", "HouseAllySix",   HouseClassArray[2]);
    Check_Alliance_State("Multi3_Alliances", "HouseAllySeven", HouseClassArray[2]);
    Check_Alliance_State("Multi3_Alliances", "HouseAllyEight", HouseClassArray[2]);

	//Check Player 4
    Check_Alliance_State("Multi4_Alliances", "HouseAllyOne",   HouseClassArray[3]);
    Check_Alliance_State("Multi4_Alliances", "HouseAllyTwo",   HouseClassArray[3]);
    Check_Alliance_State("Multi4_Alliances", "HouseAllyThree", HouseClassArray[3]);
    Check_Alliance_State("Multi4_Alliances", "HouseAllyFour",  HouseClassArray[3]);
    Check_Alliance_State("Multi4_Alliances", "HouseAllyFive",  HouseClassArray[3]);
    Check_Alliance_State("Multi4_Alliances", "HouseAllySix",   HouseClassArray[3]);
    Check_Alliance_State("Multi4_Alliances", "HouseAllySeven", HouseClassArray[3]);
    Check_Alliance_State("Multi4_Alliances", "HouseAllyEight", HouseClassArray[3]);

	//Check Player 5
    Check_Alliance_State("Multi5_Alliances", "HouseAllyOne",   HouseClassArray[4]);
    Check_Alliance_State("Multi5_Alliances", "HouseAllyTwo",   HouseClassArray[4]);
    Check_Alliance_State("Multi5_Alliances", "HouseAllyThree", HouseClassArray[4]);
    Check_Alliance_State("Multi5_Alliances", "HouseAllyFour",  HouseClassArray[4]);
    Check_Alliance_State("Multi5_Alliances", "HouseAllyFive",  HouseClassArray[4]);
    Check_Alliance_State("Multi5_Alliances", "HouseAllySix",   HouseClassArray[4]);
    Check_Alliance_State("Multi5_Alliances", "HouseAllySeven", HouseClassArray[4]);
    Check_Alliance_State("Multi5_Alliances", "HouseAllyEight", HouseClassArray[4]);

	//Check Player 6
    Check_Alliance_State("Multi6_Alliances", "HouseAllyOne",   HouseClassArray[5]);
    Check_Alliance_State("Multi6_Alliances", "HouseAllyTwo",   HouseClassArray[5]);
    Check_Alliance_State("Multi6_Alliances", "HouseAllyThree", HouseClassArray[5]);
    Check_Alliance_State("Multi6_Alliances", "HouseAllyFour",  HouseClassArray[5]);
    Check_Alliance_State("Multi6_Alliances", "HouseAllyFive",  HouseClassArray[5]);
    Check_Alliance_State("Multi6_Alliances", "HouseAllySix",   HouseClassArray[5]);
    Check_Alliance_State("Multi6_Alliances", "HouseAllySeven", HouseClassArray[5]);
    Check_Alliance_State("Multi6_Alliances", "HouseAllyEight", HouseClassArray[5]);

	//Check Player 7
    Check_Alliance_State("Multi7_Alliances", "HouseAllyOne",   HouseClassArray[6]);
    Check_Alliance_State("Multi7_Alliances", "HouseAllyTwo",   HouseClassArray[6]);
    Check_Alliance_State("Multi7_Alliances", "HouseAllyThree", HouseClassArray[6]);
    Check_Alliance_State("Multi7_Alliances", "HouseAllyFour",  HouseClassArray[6]);
    Check_Alliance_State("Multi7_Alliances", "HouseAllyFive",  HouseClassArray[6]);
    Check_Alliance_State("Multi7_Alliances", "HouseAllySix",   HouseClassArray[6]);
    Check_Alliance_State("Multi7_Alliances", "HouseAllySeven", HouseClassArray[6]);
    Check_Alliance_State("Multi7_Alliances", "HouseAllyEight", HouseClassArray[6]);

	//Check Player 8
    Check_Alliance_State("Multi8_Alliances", "HouseAllyOne",   HouseClassArray[7]);
    Check_Alliance_State("Multi8_Alliances", "HouseAllyTwo",   HouseClassArray[7]);
    Check_Alliance_State("Multi8_Alliances", "HouseAllyThree", HouseClassArray[7]);
    Check_Alliance_State("Multi8_Alliances", "HouseAllyFour",  HouseClassArray[7]);
    Check_Alliance_State("Multi8_Alliances", "HouseAllyFive",  HouseClassArray[7]);
    Check_Alliance_State("Multi8_Alliances", "HouseAllySix",   HouseClassArray[7]);
    Check_Alliance_State("Multi8_Alliances", "HouseAllySeven", HouseClassArray[7]);
    Check_Alliance_State("Multi8_Alliances", "HouseAllyEight", HouseClassArray[7]);
}
