#pragma once
#include <stdint.h>
#include "EventTypes.h"

#define LOSS_MODE_BEST 1
#define LOSS_MODE_MEDIUM 2
#define LOSS_MODE_WORST 3

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
            int8_t FrameSendRate;
            int8_t HighLossMode;
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
