#include "macros/patch.h"
#include "RA.h"
#include "EventClass.h"
#include "HouseClass.h"
#include "network.h"
#include "SessionClass.h"

uint8_t HighLossMode = 0;
int32_t WorstMaxAhead = 24;
bool UseProtocolZero = false;

int32_t __thiscall
Hack_Response_Time(IPXManagerClass *this)
{
    return WorstMaxAhead;
}

void __thiscall
Hack_Set_Timing(IPXManagerClass *this, int NewRetryDelta, int NewMaxRetries, int NewRetryTimeout, bool SetGlobalConnClass)
{

    IPXManagerClass__Set_Timing(this, NewRetryDelta, NewMaxRetries, NewRetryTimeout, SetGlobalConnClass);
    WWDebug_Printf("NewRetryDelta = %d,  NewRetryTimeout = %d, FrameSendRate = %d, HighLossMode = %d\n",
                   NewRetryDelta, NewRetryTimeout, FrameSendRate, HighLossMode);
}

int SendResponseTimeFrame = 240;
int SendResponseTimeInterval = 30;

void __thiscall
EventClass__Add(EventClass *this)
{
    if (OutList.Count < 128)
    {
        memcpy(&OutList.List[OutList.Tail], this, sizeof(EventClass));
        OutList.Timings[OutList.Tail] = timeGetTime();
        OutList.Tail = (LOBYTE(OutList.Tail) + 1) & 127;
        OutList.Count++;
    }
}

void Send_Response_Time()
{
    if (UseProtocolZero)
    {
        int32_t rspTime = IPXManagerClass__Response_Time(&IPXManagerClass_this);
        uint8_t setHighLossMode = LOSS_MODE_WORST;

        if (rspTime <= 9)
            setHighLossMode = LOSS_MODE_BEST;
        else if (rspTime <= 15)
            setHighLossMode = LOSS_MODE_MEDIUM;

        if (rspTime > -1 && (Frame > SendResponseTimeFrame))
        {
            SendResponseTimeFrame = Frame + SendResponseTimeInterval;

            EventClass event;
            event.Type = EVENTTYPE_RESPONSE_TIME2;
            event.Data.ResponseTime2.PlayerID = PlayerPtr->ArrayIndex;
            event.Frame = Frame + MaxAhead;
            event.Data.ResponseTime2.MaxAhead = (int8_t)rspTime + 1;
            event.Data.ResponseTime2.HighLossMode = setHighLossMode;
            EventClass__Add(&event);
            WWDebug_Printf("Player %d sending response time of %d, HighLossMode = %d\n",
                           PlayerPtr->ArrayIndex, event.Data.ResponseTime2.MaxAhead, event.Data.ResponseTime2.HighLossMode);
        }
    }
}

int NextDecreaseFrame = 90;
int DecreaseInterval = 450;
int TrackHighLossMode = 0;

int32_t PlayerMaxAheads[8] = {0};
uint8_t PlayerHighLossMode[8] = {0};
int32_t PlayerLastTimingFrame[8] = {0};
int TimingTimeout = 120;

extern uint8_t NewFrameSendRate;
extern bool MPDEBUG;
typedef void MessageListClass;
extern MessageListClass *MessageListClass_this;

void __thiscall
MessageListClass__Add_Message(MessageListClass *this, const wchar_t *Name, int ID,
                                              const wchar_t *message, int color, int32_t PrintType, int32_t duration, bool SinglePlayer);

void __thiscall
Handle_Timing_Change(EventClass *event)
{
    if (event->Data.ResponseTime2.MaxAhead == 0)
    {
        WWDebug_Printf("Returning because event->MaxAhead == 0\n");
        return;
    }

    int32_t id = event->Data.ResponseTime2.PlayerID;
    PlayerLastTimingFrame[id] = event->Frame;
    PlayerMaxAheads[id] = (int32_t)event->Data.ResponseTime2.MaxAhead;
    PlayerHighLossMode[id] = event->Data.ResponseTime2.HighLossMode;

    uint8_t setHighLossMode = 0;
    int max = 0;
    for (int i = 0; i < 8; ++i)
    {
        if (PlayerLastTimingFrame[i] + TimingTimeout < Frame)
        {
            PlayerMaxAheads[i] = 0;
            PlayerHighLossMode[i] = 0;
        }
        else
        {
            max = PlayerMaxAheads[i] > max ? PlayerMaxAheads[i] : max;
            if (PlayerHighLossMode[i] > setHighLossMode)
                setHighLossMode = PlayerHighLossMode[i];
        }
    }
    WorstMaxAhead = max;

    WWDebug_Printf("Player %d, Loss mode (%d, %d)\n", PlayerPtr->ArrayIndex, setHighLossMode, HighLossMode);
    if (setHighLossMode > HighLossMode && (SessionType == 3 || SessionType == 4))
    {
        HighLossMode = setHighLossMode;
        wchar_t *message;

        switch (HighLossMode)
        {
        case LOSS_MODE_BEST:
            message = L"CnCNet: Latency mode set to BEST!";
            NewFrameSendRate = 2;
            PreCalcMaxAhead = 6;
            break;
        case LOSS_MODE_MEDIUM:
            message = L"CnCNet: Latency mode set to MEDIUM!";
            NewFrameSendRate = 3;
            PreCalcMaxAhead = 12;
            break;
        default:
            message = L"CnCNet: Latency mode set to WORST!";
            NewFrameSendRate = 4;
            PreCalcMaxAhead = 16;
        }

        PreCalcFrameRate = 60;
        MessageListClass__Add_Message(&MessageListClass_this, 0, 0, message, 4, 0x4096, 270, 1);
    }
}
