#include "macros/patch.h"
#include "RA.h"

CALL(0x00643ACC, _ProgressScreenClass_PrintPlayer_hide);
CALL(0x00643AA0, _Draw_Confined_PCX_hide);
CALL(0x00658386, _Diplomacy_Draw_Names_hide);

void __thiscall
ProgressScreenClass_PrintPlayer_hide(void *this, int32_t x, int32_t y, wchar_t *name, void *color, void *arg)
{
    if (!QuickMatch)
        ProgressScreenClass_PrintPlayer(this, x, y, name, color, arg);
}

void __thiscall
Draw_Confined_PCX_hide(void *pcx, void *a2, void *surface, void *a4, void *a5)
{
    if (!QuickMatch)
        Draw_Confined_PCX(pcx, a2, surface, a4, a5);
}

#define UNICODE 1
wchar_t *
Diplomacy_Draw_Names_hide(wchar_t *strDestination, const wchar_t *strSource)
{
    wchar_t *player = L"Player";

    if (QuickMatch)
    {
        return wcscpy(strDestination, player);
    }
    else {
        return wcscpy(strDestination, strSource);
    }
}
