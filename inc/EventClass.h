#pragma once
#include <stdint.h>
#include "EventTypes.h"

#pragma pack(push, 1)
typedef struct EventClass {
    char Type;
    bool IsExecuted;
    char HouseIndex;
    uint32_t Frame;
    union Data {
        struct SpaceGap {
            char Data[104];
        } SpaceGap;

        struct ResponseTime2 {
            int32_t PlayerID;
            int8_t MaxAhead;
            uint8_t LatencyLevel;
            // int8_t FrameSendRate;
        } ResponseTime2;
    } Data;
} EventClass;

typedef struct EventList128 {
    int Count;
    int Head;
    int Tail;
    EventClass List[128];
    int Timings[128];
} EventList128;
#pragma pack(pop)

extern EventList128 OutList;

void __thiscall
EventClass__Add(EventClass *this);

void __stdcall
Extended_Events(EventClass *event);

void __thiscall
Handle_Timing_Change(EventClass *event);
