#ifndef NODENAMETYPE_H
#define NODENAMETYPE_H

#include <windows.h>
#include <winsock2.h>

#pragma pack(push, 1)

typedef struct NodeNameType {
    wchar_t Handle[20];
    struct sockaddr_in Address;
    char field_38[19];
    int32_t Country;
    int32_t IntialCountry;
    int32_t Color;
    int32_t InitialColor;
    int32_t StartPoint;
    int32_t InitialStartPoint;
    int32_t Team;
    int32_t InitialTeam;
    int32_t Spectator;
    int32_t HouseIndex;
    uint32_t Time;
    uint32_t unknown_77;
    int32_t Clan;
    uint32_t unknown_7F;
    char unknown_83;
    char unknown_84;
} NodeNameType;

typedef struct NodeNameTypeVector NodeNameTypeVector;

extern NodeNameTypeVector NameNodeVector;

void __thiscall NameNodeVector_Add(NodeNameTypeVector *vector, NodeNameType **NodeNameType);

void __thiscall Add_Player_Node(int NodeId, char *section);

#pragma pack(pop)

#endif //NODENAMETYPE_H
