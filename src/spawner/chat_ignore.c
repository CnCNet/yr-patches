#include <wchar.h>

#include "HouseClass.h"
#include "RA.h"
#include "macros/patch.h"

CALL(0x48d979, _fake_MessageListClass__Add_Message);
CALL(0x55f0f5, _fake_MessageListClass__Add_Message);

void *__thiscall fake_MessageListClass__Add_Message(MessageListClass *this,
                                                    const wchar_t *Name,
                                                    int ID,
                                                    const wchar_t *message,
                                                    int color,
                                                    int32_t PrintType,
                                                    int32_t duration,
                                                    bool SinglePlayer)
{
    if (!DisableChat || Name == NULL)
    {
        return MessageListClass__Add_Message(this, Name, ID, message, color, PrintType, duration, SinglePlayer);
    }

    if (wcsicmp(Name, PlayerPtr->UIName) == 0)
    {
        return MessageListClass__Add_Message(this, 0, 0, L"Chat is disabled. Message not sent.", 4, 0x4096, 270, 1);
    }

    /* Base case. Don't display incoming player messages. */
    return NULL;
}
