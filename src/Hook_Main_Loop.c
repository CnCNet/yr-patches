#include "macros/patch.h"
#include "macros/helpers.h"
#include "RA.h"
#include "SessionClass.h"
#include "network.h"
#include "EventClass.h"

CALL(0x0055DDA5, _MainLoop_AfterRender);

extern int SpawnerActive;
void Send_Response_Time();

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

        /* Disable "ENTER" chat for all users. Grey out the "Chat" checkbox in alliances menu.
           TODO: This is redundant because patches in chat_disable.asm already prevent sending all message types.
           This exists mainly for cosmetic purposes. A better solution would be to patch the function responsible for
           toggling the chat checkbox. */
        if (DisableChat)
        {
            for (int i = 0; i < countof(SessionClass_ChatEnabled); i++)
            {
                SessionClass_ChatEnabled[i] = false;
            }
        }
    }
}
