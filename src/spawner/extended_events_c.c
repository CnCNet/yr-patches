#include "macros/patch.h"
#include "RA.h"
#include "EventClass.h"
#include <stdlib.h>

SETDWORD(0x004C65EF+3, _EventNames);
SETDWORD(0x004C665F+3, _EventNames);
SETDWORD(0x004C66CF+3, _EventNames);
SETDWORD(0x004C672F+3, _EventNames);
SETDWORD(0x004C678F+3, _EventNames);

SETDWORD(0x004C697F+3, _EventNames);
SETDWORD(0x004C69EF+3, _EventNames);
SETDWORD(0x004C6A6F+3, _EventNames);
SETDWORD(0x004C6AEF+3, _EventNames);
SETDWORD(0x004C6B6F+3, _EventNames);

SETDWORD(0x004C6BEF+3, _EventNames);
SETDWORD(0x0064C5C7+3, _EventNames);
SETDWORD(0x0065208B+3, _EventNames);

SETDWORD(0x0064B706+2, _EventLengths);
SETDWORD(0x0064BE85+2, _EventLengths);
SETDWORD(0x0064C316+2, _EventLengths);


volatile
char *EventNames[] = {
    "EMPTY",
    "POWERON",
    "POWEROFF",
    "ALLY",
    "MEGAMISSION",
    "MEGAMISSION_F",
    "IDLE",
    "SCATTER",
    "DESTRUCT",
    "DEPLOY",
    "DETONATE",
    "PLACE",
    "OPTIONS",
    "GAMESPEED",
    "PRODUCE",
    "SUSPEND",
    "ABANDON",
    "PRIMARY",
    "SPECIAL_PLACE",
    "EXIT",
    "ANIMATION",
    "REPAIR",
    "SELL",
    "SELLCELL",
    "SPECIAL",
    "FRAMESYNC",
    "MESSAGE",
    "RESPONSE_TIME",
    "FRAMEINFO",
    "SAVEGAME",
    "ARCHIVE",
    "ADDPLAYER",
    "TIMING",
    "PROCESS_TIME",
    "PAGEUSER",
    "REMOVEPLAYER",
    "LATENCYFUDGE",
    "MEGAFRAMEINFO",
    "PACKETTIMING",
    "ABOUTTOEXIT",
    "FALLBACKHOST",
    "ADDRESSCHANGE",
    "PLANCONNECT",
    "PLANCOMMIT",
    "PLANNODEDELETE",
    "ALLCHEER",
    "ABANDON_ALL",

    "RESPONSE_TIME2",

    "LAST_EVENT",
};

volatile
uint8_t EventLengths[] = {
    0,    // EMPTY
    5,    // POWERON
    5,    // POWEROFF
    4,    // ALLY
    23,   // MEGAMISSION
    24,   // MEGAMISSION_F
    5,    // IDLE
    5,    // SCATTER
    0,    // DESTRUCT
    5,    // DEPLOY
    5,    // DETONATE
    16,   // PLACE
    0,    // OPTIONS
    4,    // GAMESPEED
    12,   // PRODUCE
    12,   // SUSPEND
    12,   // ABANDON
    5,    // PRIMARY
    8,    // SPECIAL_PLACE
    0,    // EXIT
    16,   // ANIMATION
    5,    // REPAIR
    5,    // SELL
    4,    // SELLCELL
    4,    // SPECIAL
    0,    // FRAMESYNC
    0,    // MESSAGE
    1,    // RESPONSE_TIME
    7,    // FRAMEINFO
    0,    // SAVEGAME
    10,   // ARCHIVE
    4,    // ADDPLAYER
    5,    // TIMING
    2,    // PROCESS_TIME
    0,    // PAGEUSER
    4,    // REMOVEPLAYER
    4,    // LATENCYFUNDGE
    104,  // MEGAFRAMEINFO
    64,   // PACKETTIMING
    0,    // ABOUTTOEXIT
    4,    // FALLBACKHOST
    5,    // ADDRESSCHANGE
    10,   // PLANCONNECT
    0,    // PLANCOMMIT
    5,    // PLANNODEDELETE
    4,    // ALLCHEER
    12,   // ABANDON_ALL

    2,    // RESPONSE_TIME2

    0,    // LAST_EVENT
};

void __stdcall
Extended_Events(EventClass *event)
{
    switch(event->Type) {
        case EVENTTYPE_EMPTY:
            break;
        case EVENTTYPE_RESPONSE_TIME2:
            Handle_Timing_Change(event);
            break;
        default:
            WWDebug_Printf("Extended event not found %d\n", event->Type);
    }
}

void __thiscall EventClass__Add(EventClass *this)
{
    if (OutList.Count < 128)
    {
        memcpy(&OutList.List[OutList.Tail], this, sizeof(EventClass));
        OutList.Timings[OutList.Tail] = timeGetTime();
        OutList.Tail = (LOBYTE(OutList.Tail) + 1) & 127;
        OutList.Count++;
    }
}
