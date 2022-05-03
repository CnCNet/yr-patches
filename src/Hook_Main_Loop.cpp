#include "macros/patch.h"
#include "RA.h"
#include "SessionClass.h"

CALL(0x0055DDA5, _MessageListClass__Manage_hack);

int32_t NextAutoSS = 0;
int32_t AutoSSInterval = 4;
int32_t AutoSSGrowth = 4;
int32_t AutoSSIntervalMax = 30;

void __thiscall
MessageListClass__Manage_hack(void *message_list)
{
    if (RunAutoSS && SessionType == 3 && Frame > NextAutoSS)
    {
        DoingAutoSS = 1;
        ScreenCaptureCommandClass_Execute();
        DoingAutoSS = 0;
        NextAutoSS = Frame + AutoSSInterval * 60; //60fps
        if (AutoSSInterval < AutoSSIntervalMax)
            AutoSSInterval += AutoSSGrowth;
    }

    MessageListClass__Manage(message_list);
}
