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

int SpawnerActive;
extern int PlayersTeams[];
extern int HouseClassArray_Count;
extern int HouseClassArray;
int ObserverMode;
extern int PlayerColor;
extern int32_t PortHack;
extern uint16_t ListenPort;


void __thiscall Add_Player_Node(int NodeId, char *section)
{
    NodeNameType *currentNode = calloc(1, sizeof(NodeNameType));

    IPXAddressClass__IPXAddressClass(&currentNode->Address);

    char TempBuf[128];

    INIClass__GetString(&INIClass_SPAWN, section, "Name", "", TempBuf, 0x28);

    /* if no name present for this section, this is the last */
    if (TempBuf[0] == '\0')
        return;

    mbstowcs(currentNode->Handle, TempBuf, 15);

    currentNode->Country  = INIClass__GetInt(&INIClass_SPAWN, section, "Side", -1);
    if (currentNode->Country == -1)
        return;

    currentNode->Color = INIClass__GetInt(&INIClass_SPAWN, section, "Color", -1);
    if (currentNode->Color == -1)
        return;

    if (NodeId == 0)
        PlayerColor = currentNode->Color;

    bool spectator = INIClass__GetBool(&INIClass_SPAWN, section, "IsSpectator", 0);

    if (spectator)
    {
        currentNode->Spectator = -1;
        if (NodeId == 0)
            ObserverMode = 1;
    }

    if (NodeId != 0)
    {
        /* HACK: SessonType set to WOL, will be set to LAN later */
        SessionType = 4;

        currentNode->Address.sin_family = 0;
        currentNode->Address.sin_port = 0;
        currentNode->Address.sin_addr.s_addr = NodeId;
        memset(currentNode->Address.sin_zero, 0, 8);

        INIClass__GetString(&INIClass_SPAWN, section, "Ip", "", TempBuf, 32);

        AddressList[NodeId - 1].ip = inet_addr_(TempBuf);

        uint16_t port = (uint16_t)INIClass__GetInt(&INIClass_SPAWN, section, "Port", -1);

        if (port != ListenPort)
        {
            PortHack = 0;
        }
        AddressList[NodeId - 1].port = htons(port);
    }

    currentNode->Time = -1;
    /* currentNode->field_1F = 1; Is this needed? */

    NameNodeVector_Add(&NameNodeVector, &currentNode);
}
