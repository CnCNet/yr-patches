#include "macros/patch.h"
#include "RA.h"
#include <windows.h>

LJMP(0x006BE06F, _Top_Level_Exception_Filter_hack2);

LONG __fastcall Top_Level_Exception_Filter_hack2(int exception_id, struct _EXCEPTION_POINTERS *ExceptionInfo)
{
    DWORD *eip = &(ExceptionInfo->ContextRecord->Eip);
    switch (*eip)
    {
    case 0x007BC806:
        *eip = 0x007BC80F;
        return EXCEPTION_CONTINUE_EXECUTION;

    case 0x005D6C21:
        // This bug most likely happens when a map Doesn't have Waypoint 90
        *eip = 0x005D6C36;
        return EXCEPTION_CONTINUE_EXECUTION;

    case 0x007BAEA1:
        // A common crash in DSurface::GetPixel
        *eip = 0x007BAEA8;
        ExceptionInfo->ContextRecord->Ebx = 0;
        return EXCEPTION_CONTINUE_EXECUTION;

    case 0x00535DBC:
        // Common crash in keyboard command class
        *eip = 0x00535DCE;
        ExceptionInfo->ContextRecord->Esp += 12;
        return EXCEPTION_CONTINUE_EXECUTION;

    case 0x00000000:
        if (ExceptionInfo->ContextRecord->Esp && *(DWORD *)ExceptionInfo->ContextRecord->Esp == 0x0055E018)
        {
            // A common crash that seems to happen when yuri prime mind controls a building and then dies while the user is pressing hotkeys.
            *eip = 0x0055E018;
            ExceptionInfo->ContextRecord->Esp += 8;
            return  EXCEPTION_CONTINUE_EXECUTION;
        }
        return PrintException(exception_id, ExceptionInfo);
        break;
    default:
        return PrintException(exception_id, ExceptionInfo);
    }
    return 0;
}
