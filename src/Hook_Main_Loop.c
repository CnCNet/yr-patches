#include "macros/patch.h"
#include "RA.h"
#include "SessionClass.h"
#include "network.h"
#include "EventClass.h"

CALL(0x0055DDA5, _MainLoop_AfterRender);

extern int SpawnerActive;

int32_t NextAutoSS = 0;
int32_t AutoSSInterval = 4;
int32_t AutoSSGrowth = 4;
int32_t AutoSSIntervalMax = 30;

int32_t ResponseTimeFrame = 0;
int32_t ResponseTimeInterval = 4;

void __thiscall
MainLoop_AfterRender(void *message_list)
{
    MessageListClass__Manage(message_list);

    if (SpawnerActive && SessionType == 3 /* GAME_IPX */)
    {
        /*
        if (RunAutoSS && Frame > NextAutoSS)
        {
            DoingAutoSS = 1;
            ScreenCaptureCommandClass_Execute();
            DoingAutoSS = 0;
            NextAutoSS = Frame + AutoSSInterval * 60; //60fps
            if (AutoSSInterval < AutoSSIntervalMax)
                AutoSSInterval += AutoSSGrowth;
        }
        */

        if (UseProtocolZero && Frame >= ResponseTimeFrame)
        {
            ResponseTimeFrame = Frame + ResponseTimeInterval;
            Send_Response_Time();
        }
    }

}
