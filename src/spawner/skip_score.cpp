#include <stdbool.h>
#include <stdint.h>
#include "macros/patch.h"
#include "RA.h"

CALL (0x00685FD5, _ScoreScreen_Present_hack);
CALL (0x0068588B, _ScoreScreen_Present_hack);

/* Don't change video mode at score presentation */
CALL (0x00685E96, _SetVideoMode_hack);
CALL (0x006857E5, _SetVideoMode_hack);

//CLEAR(0x00683DF3, 0x90, 0x00683DF8);

//NOTHING CLEAR(0x0056130C, 0x90, 0x00561311);
//NOTHING CLEAR(0x005611D0, 0x90, 0x005611D5);
//NOTHING CLEAR(0x0068432C, 0x90, 0x00684331);
//NOTHING CLEAR(0x00684368, 0x90, 0x0068436D);

//CLEAR(0x0068641F, 0x90, 0x00686424);
//CLEAR(0x006866EA, 0x90, 0x006866EF);

//CLEAR(0x004A4365, 0x90, 0x004A436C);
//LJMP(0x004A436E, 0x004A4420);

//CLEAR(0x006BDA7B, 0x90, 0x006BDA80);
//CLEAR(0x006BDB90, 0x90, 0x006BDB95);

bool SkipScoreScreen = false;

void
ScoreScreen_Present_hack()
{
    if (!SkipScoreScreen)
        ScoreScreen_Present();
}

void __fastcall
SetVideoMode_hack(int32_t width, int32_t height)
{
    if (!SkipScoreScreen)
        SetVideoMode(width, height);
}
