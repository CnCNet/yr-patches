#include "macros/patch.h"
#include <winsock2.h>
#include <windows.h>
#include <stdbool.h>
#include <time.h>
#include <stdio.h>
#include "RA.h"
#include "INIClass.h"
#include "FileClass.h"
#include "HouseClass.h"
#include "SessionClass.h"
#include "network.h"
#include "MouseClass.h"
#include "DSurface.h"
#include "NodeNameType.h"
#include "IPAddressClass.h"
#include "Rules.h"

CALL(0x0068745E, _Assign_Houses_Do_Spawner_Stuff);
CALL(0x0068ACFF, _Assign_Houses_Do_Spawner_Stuff);
CALL(0x0052C5EE, _Skip_Intro);
CALL(0x0052CB69, _Skip_Intro);
CALL(0x0048CCCF, _Pre_Init_Game);
CALL(0x0048CDD3, _Select_Game_Init_Spawner);
CALL(0x0048CFAA, _Select_Game_Init_Spawner);
// CALL(0x00684B3E, _Pre_Scenario_Load_Wait);
//hooks MPGameMode_AllyTeams in MPGameMode vtable
SETDWORD(0x007EE20C, _Teams_Alliances_Stuff);
SETDWORD(0x007EE4AC, _Teams_Alliances_Stuff);
SETDWORD(0x007EE594, _Teams_Alliances_Stuff);
SETDWORD(0x007EE67C, _Teams_Alliances_Stuff);
SETDWORD(0x007EE784, _Teams_Alliances_Stuff);
SETDWORD(0x007EE89C, _Teams_Alliances_Stuff);
SETDWORD(0x007EEDE8, _Teams_Alliances_Stuff);
CALL(0x00686AAE, _More_Alliances_Crap);
CALL(0x00686AC1, _More_Alliances_Crap);
CALL(0x006BC08C, _Parse_Spawn_Command_Line);
CALL(0x0052C5F3, _Load_Game_LoadScreen);
CALL(0x007782BF, _Sides_Call_Draw_Main_Menu);
CALL(0x0052FF52, _Sides_Call_Draw_Main_Menu);
CALL(0x0050172A, _HouseClass__Hack_Alliances);
CALL(0x00501731, _HouseClass__Hack_Alliances2);

INIClass INIClass_SPAWN;

bool SpawnINI_Loaded = false;

bool Load_SPAWN_INI()
{
    INIClass ccfile;
    CCFileClass__CCFileClass((CCFileClass *)&ccfile, "SPAWN.INI");

    if ( CCFileClass__Is_Available((CCFileClass *)&ccfile, 0) )
    {
        INIClass__INIClass(&INIClass_SPAWN, &ccfile);
        INIClass__Load(&INIClass_SPAWN, &ccfile, 0);
        return true;
    }
    return false;
}

int SpawnerActive;
extern int PlayersTeams[];
extern int HouseClassArray_Count;
extern int HouseClassArray;
int ObserverMode;
extern int PlayerColor;

void __thiscall Assign_Houses();
void __thiscall Load_Selectable_Countries();
void __thiscall Load_Selectable_Handicaps();
void __thiscall Load_Selectable_Colors();
void __thiscall Load_Predetermined_Alliances();
void __thiscall Load_Selectable_Spawns();
signed int __thiscall Initialize_Spawn();
signed char __thiscall MPGameMode_AllyTeams();

void __thiscall Assign_Houses_Do_Spawner_Stuff()
{
    if ( SpawnerActive )
    {
        Load_Selectable_Countries();
        Load_Selectable_Handicaps();
        Load_Selectable_Colors();
        PlayersTeams[0] = -1;
        PlayersTeams[1] = -1;
        PlayersTeams[2] = -1;
        PlayersTeams[3] = -1;
        PlayersTeams[4] = -1;
        PlayersTeams[5] = -1;
        PlayersTeams[6] = -1;
        PlayersTeams[7] = -1;
        Assign_Houses();
        //this was Assign_Houses_Epilogue_Do_Spawner_Stuff
        //it hooked to the epilogue of Assign_Houses
        Load_Predetermined_Alliances();
        Load_Selectable_Spawns();
    }
}

void __fastcall Skip_Intro(char* a1, int a2, int a3, int a4, int a5, int a6)
{
}

void Init_Main_Menu();

signed int Select_Game_Init_Spawner()
{
    signed int result = Initialize_Spawn();
    if ( result == -1 )
    {
        //if spawn not initialized, go to main menu
        Init_Main_Menu();
    }
    return result;
}

char __thiscall Teams_Alliances_Stuff()
{
    if (!SpawnerActive)
    {
	return MPGameMode_AllyTeams();
    }
}

void __thiscall More_Alliances_Crap(void* house, void *other, bool maybe)
{
    if (!SpawnerActive)
    {
	HouseClass__Make_Ally_house(house, other, maybe);
    }
}

void Init_Random();
void Init_Network();
void InitCommonDialogStuff();
void InitUIColorShifts();
void Game_LoadPCXFiles();
void Load_Sides_Stuff();
void __fastcall GScreenClass__Do_Blit(char a1, void *surface, int32_t a3);
void __thiscall GScreenClass_6D04F0(void *this, int32_t a1);
void __thiscall GScreenClass__Flag_To_Redraw(void *this, int32_t a1);
bool __fastcall Parse_Command_Line(int, char **);
bool __thiscall Load_Game(char*);
void __thiscall HouseClass__Hack_Alliances(void *house, void *other, bool announce);


extern int32_t PortHack;
int32_t IsSpawnArgPresent;
int32_t SpawnerCheck;
extern bool    GameActive;
extern int32_t UnitCount;
extern int32_t TechLevel;
extern int32_t AIPlayers;
extern int32_t AIDifficulty;
extern bool    BuildOffAlly;
extern bool    SuperWeapons;
extern bool    HarvesterTruce;
extern bool    BridgeDestroy;
extern bool    FogOfWar;
extern bool    Crates;
extern bool    ShortGame;
extern bool    Bases;
extern bool    MCVRedeploy;
extern int32_t Credits;
extern int32_t GameSpeed;
extern bool    MultiEngineer;
extern bool    AlliesAllowed;
char    MapHash[256];
char    UIMapName[256];
extern IN_ADDR TunnelIp;
extern uint16_t TunnelPort;
extern uint32_t TunnelId;
extern uint16_t ListenPort;
extern char     ScenarioName;
extern uint32_t Seed;
extern void *   GameMode;
extern int32_t  NameNodes_CurrentSize;
extern bool     SkipScoreScreen;
extern bool     InScenario1;
extern bool     InScenario2;
extern int32_t  Tournament;
int32_t ConnTimeout;
int32_t ReconnectTimeout;
bool QuickMatch = false;
bool Ra2Mode = false;
bool     RunAutoSS;


int __fastcall Init_Game(int argc, char **argv);

int __fastcall Pre_Init_Game(int argc, char **argv)
{

    if ( Load_SPAWN_INI() )
    {
        SpawnINI_Loaded = true;
        Ra2Mode =        INIClass__GetBool(&INIClass_SPAWN, "Settings", "Ra2Mode", false);
    }

    return InitGame(argc, argv);
}

/*
bool __fastcall Scenario_Load_Wait();

bool __fastcall Pre_Scenario_Load_Wait()
{
    ConnTimeout = INIClass__GetInt(&INIClass_SPAWN, "Settings", "ConnTimeout", 3600);
    return Scenario_Load_Wait();
}
*/

signed int Initialize_Spawn()
{
    int32_t result;

    if ( !IsSpawnArgPresent )
    {
        return -1;
    }
    if ( SpawnerActive == 1 )
    {
        return 0;
    }

    SpawnerActive = 1;
    PortHack = 1;

    result = -1;

    if (SpawnINI_Loaded)
    {
        HMODULE wsock = LoadLibraryA("wsock32.dll");

        inet_addr_ = (inet_addr_function)GetProcAddress(wsock, "inet_addr");

        GameActive = 1;
        SessionType = 5;

        WOLGameID =      INIClass__GetInt(&INIClass_SPAWN, "Settings", "GameID", 0xDEADBEEF);
        UnitCount =      INIClass__GetInt(&INIClass_SPAWN, "Settings", "UnitCount", 0);
        TechLevel =      INIClass__GetInt(&INIClass_SPAWN, "Settings", "TechLevel", 10);
        AIPlayers =      INIClass__GetInt(&INIClass_SPAWN, "Settings", "AIPlayers", 0);
        AIDifficulty =   INIClass__GetInt(&INIClass_SPAWN, "Settings", "AIDifficulty", 1);
        BuildOffAlly =   INIClass__GetBool(&INIClass_SPAWN, "Settings", "BuildOffAlly", 0);
        SuperWeapons =   INIClass__GetBool(&INIClass_SPAWN, "Settings", "Superweapons", 1);
        HarvesterTruce = INIClass__GetBool(&INIClass_SPAWN, "Settings", "HarvesterTruce", 0);
        BridgeDestroy =  INIClass__GetBool(&INIClass_SPAWN, "Settings", "BridgeDestroy", 1);
        FogOfWar =       INIClass__GetBool(&INIClass_SPAWN, "Settings", "FogOfWar", 0);
        Crates =         INIClass__GetBool(&INIClass_SPAWN, "Settings", "Crates", 0);
        ShortGame =      INIClass__GetBool(&INIClass_SPAWN, "Settings", "ShortGame", 0);
        Bases =          INIClass__GetBool(&INIClass_SPAWN, "Settings", "Bases", 1);
        MCVRedeploy =    INIClass__GetBool(&INIClass_SPAWN, "Settings", "MCVRedeploy", 1);
        Credits =        INIClass__GetInt(&INIClass_SPAWN, "Settings", "Credits", 10000);
        GameSpeed =      INIClass__GetInt(&INIClass_SPAWN, "Settings", "GameSpeed", 0);
        MultiEngineer =  INIClass__GetBool(&INIClass_SPAWN, "Settings", "MultiEngineer", 0);
        AlliesAllowed =  INIClass__GetBool(&INIClass_SPAWN, "Settings", "AlliesAllowed", 0);
        SkipScoreScreen =INIClass__GetBool(&INIClass_SPAWN, "Settings", "SkipScoreScreen", SkipScoreScreen);
        Tournament =     INIClass__GetInt(&INIClass_SPAWN, "Settings", "Tournament", 0);
        QuickMatch =     INIClass__GetBool(&INIClass_SPAWN, "Settings", "QuickMatch", false);
        RunAutoSS  =     INIClass__GetBool(&INIClass_SPAWN, "Settings", "RunAutoSS", false);
        ConnTimeout =    INIClass__GetInt(&INIClass_SPAWN, "Settings", "ConnTimeout", 3600);
        ReconnectTimeout=INIClass__GetInt(&INIClass_SPAWN, "Settings", "ReconnectTimeout", 2400);

        INIClass__GetString(&INIClass_SPAWN, "Settings", "MapHash", "", MapHash, 255);
        INIClass__GetString(&INIClass_SPAWN, "Settings", "UIMapName", "", UIMapName, 255);

        char ip_string[32];
        INIClass__GetString(&INIClass_SPAWN, "Tunnel", "Ip", "0.0.0.0", ip_string, sizeof(ip_string));

        TunnelIp = inet_addr_(ip_string);

        int32_t p = INIClass__GetInt(&INIClass_SPAWN, "Tunnel", "Port", 0);
        TunnelPort = htons(p);

        p = INIClass__GetInt(&INIClass_SPAWN, "Settings", "Port", 0);
        TunnelId = htons((uint16_t)p);

        if ( TunnelPort )
            p = 0;
        else
            p = INIClass__GetInt(&INIClass_SPAWN, "Settings", "Port", 1234);

        ListenPort = (uint16_t)p;

        SessionClass__Read_Scenario_Descriptions(&SessionClass_this);// correct

        Add_Player_Node(0, "Settings");
        Add_Player_Node(1, "Other1");
        Add_Player_Node(2, "Other2");
        Add_Player_Node(3, "Other3");
        Add_Player_Node(4, "Other4");
        Add_Player_Node(5, "Other5");
        Add_Player_Node(6, "Other6");
        Add_Player_Node(7, "Other7");


        INIClass__GetString(&INIClass_SPAWN, "Settings", "Scenario", "", &ScenarioName, 32);
        if ( INIClass__GetBool(&INIClass_SPAWN, "Settings", "IsSinglePlayer", 0) )
        {
			Crates = true;
            SessionType = 0;
        }

        Seed = INIClass__GetInt(&INIClass_SPAWN, "Settings", "Seed", 0);
        Init_Random();                          // has to be void

        WinsockInterface_this = UDPInterfaceClass__UDPInterfaceClass(new(259532));
        WinsockInterfaceClass__Init(WinsockInterface_this);
        UDPInterfaceClass__Open_Socket(WinsockInterface_this, 0);
        WinsockInterfaceClass__Start_Listening(WinsockInterface_this);
        WinsockInterfaceClass__Discard_In_Buffers(WinsockInterface_this);
        WinsockInterfaceClass__Discard_Out_Buffers(WinsockInterface_this);
        IPXManagerClass__Set_Timing(&IPXManagerClass_this, 60, -1, 600, 1);

        FrameSendRate = INIClass__GetInt(&INIClass_SPAWN, "Settings", "FrameSendRate", 4);
        MaxAhead = INIClass__GetInt(&INIClass_SPAWN, "Settings", "MaxAhead", FrameSendRate * 6);
        MaxMaxAhead = 0;
        LatencyFudge = 0;
        RequestedFPS = 60;
        ProtocolVersion = INIClass__GetInt(&INIClass_SPAWN, "Settings", "Protocol", 2);
        //Init_Network(1, v14, v15, v16, v17);    // might be void
        Init_Network();

        HumanPlayers = NameNodes_CurrentSize;
        PlanetWestwoodStartTime = time(NULL);
        GameStockKeepingUnit = 10497;

        Load_Sides_Stuff();

        InitCommonDialogStuff();
        InitUIColorShifts();
        Game_LoadPCXFiles();

        GameMode = Set_Game_Mode(INIClass__GetInt(&INIClass_SPAWN, "Settings", "GameMode", 1));          // correct
        if (!GameMode)
        {
            GameMode = Set_Game_Mode(1);
        }

        if ( INIClass__GetBool(&INIClass_SPAWN, "Settings", "LoadSaveGame", 0) )
        {
            char SaveGameNameBuf[60];
            INIClass__GetString(&INIClass_SPAWN, "Settings", "SaveGameName", "", SaveGameNameBuf, sizeof(SaveGameNameBuf));
            InScenario1 = 0;
            InScenario2 = 0;
            //Start_Scenario(&ScenarioName, 0, -1); not actaully needed seems, doesn't work anyway
            Load_Game(SaveGameNameBuf);
        }
        else
        {
            if ( SessionType )
            {
                Start_Scenario(&ScenarioName, 0, -1);// correct
            }
            else
            {
                Start_Scenario(&ScenarioName, 1, 0);
            }
        }
        if ( SessionType == 4 )
        {
            SessionType = 3;
        }

        if (SessionType != 3)
            RunAutoSS = false;

        SessionClass__Create_Connections(&SessionClass_this);
        IPXManagerClass__Set_Timing(&IPXManagerClass_this, 60, -1, 600, 1);

        WWMouseClass_Mouse->vtable->Hide_Mouse(WWMouseClass_Mouse);

        DSurface_Hidden->vtable->Fill(DSurface_Hidden, 0);
        GScreenClass__Do_Blit(1, DSurface_Hidden, 0);

        WWMouseClass_Mouse->vtable->Show_Mouse(WWMouseClass_Mouse);

        DSurface_Temp = DSurface_Hidden;

        MouseClass__Override_Mouse_Shape(&MouseClass_Map, 19, 0);
        MouseClass__Revert_Mouse_Shape(&MouseClass_Map);

        GScreenClass_6D04F0(&MouseClass_Map, 1);
        GScreenClass__Flag_To_Redraw(&MouseClass_Map, 0);

        result = 1;
    }

    return result;
}

//This overwrites the call to the Parse_Command_Line in WinMain
//the bool it returns is the decider for the game whether to to continue or not
bool __fastcall Parse_Spawn_Command_Line(int a1, char** args)
{
	//If the spawn string exists set the spawner bools and call the real Parse_Command_Line.
#ifdef ALWAYS_SPAWN
    if (1) {
#else
    if (strstr(GetCommandLineA(), "-SPAWN") != NULL)    {
#endif
        IsSpawnArgPresent = 1;
        SpawnerCheck = 1;
        //Calls the real command line checking function
        return Parse_Command_Line(a1, args);
    }
    else
    {
    	//If spawner CMD isnt there then show this message and tell the game to bail
        char* message = "This version of Yuri\'s Revenge only supports online play using CnCNet 5 (www.cncnet.org)\n";
        MessageBox(NULL, message, "Yuri's Revenge", MB_OK | MB_ICONEXCLAMATION);
        return 0;
    }
}

//skips the loadscreen
void Load_Game_LoadScreen()
{
}

//Disables drawing the menu bg which pops up on loading
int __fastcall Sides_Call_Draw_Main_Menu(int a1, int a2, char a3)
{
}

void __thiscall HouseClass__Hack_Alliances(void *house, void *other, bool announce)
{
    if (!SpawnerActive)
        HouseClass__Alliance_Broken(house, other, announce);
}

void __thiscall HouseClass__Hack_Alliances2(void *house, void *other, bool announce)
{
    if (!SpawnerActive)
        HouseClass__Make_Ally_house(house, other, announce);
}

void Load_Sides_Stuff()
{
    RulesClass__Countries(&Rules, RulesINI);
    RulesClass__Sides(&Rules, RulesINI);

    for (int i = 0; i < HouseTypeClassArray_Count; i++)
    {
        HouseTypeClassArray[i]->vtable->Read_INI(HouseTypeClassArray[i], RulesINI);
    }
}
