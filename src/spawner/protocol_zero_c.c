#include "macros/patch.h"
#include "RA.h"
#include "EventClass.h"
#include "HouseClass.h"
#include "network.h"
#include "SessionClass.h"

enum LatencyLevels
{
    LATENCY_LEVEL_INITIAL = 0,

    LATENCY_LEVEL_1 = 1,
    LATENCY_LEVEL_2 = 2,
    LATENCY_LEVEL_3 = 3,
    LATENCY_LEVEL_4 = 4,
    LATENCY_LEVEL_5 = 5,
    LATENCY_LEVEL_6 = 6,
    LATENCY_LEVEL_7 = 7,
    LATENCY_LEVEL_8 = 8,
    LATENCY_LEVEL_9 = 9,

    LATENCY_LEVEL_MAX = LATENCY_LEVEL_9,
    LATENCY_SIZE = 1 + LATENCY_LEVEL_MAX
};

const int32_t LatencyLevels_MaxAhead[LATENCY_SIZE] = {
    /* 0 */ 1,

    /* 1 */ 4,
    /* 2 */ 6,
    /* 3 */ 12,
    /* 4 */ 16,
    /* 5 */ 20,
    /* 6 */ 24,
    /* 7 */ 28,
    /* 8 */ 32,
    /* 9 */ 36};

const wchar_t *LatencyLevels_Message[LATENCY_SIZE] = {
    /* 0 */ L"CnCNet: Latency mode set to: 0 - Initial", // Players should never see this, if it doesn't then it's a bug

    /* 1 */ L"CnCNet: Latency mode set to: 1 - Best",
    /* 2 */ L"CnCNet: Latency mode set to: 2 - Super",
    /* 3 */ L"CnCNet: Latency mode set to: 3 - Excellent",
    /* 4 */ L"CnCNet: Latency mode set to: 4 - Very Good",
    /* 5 */ L"CnCNet: Latency mode set to: 5 - Good",
    /* 6 */ L"CnCNet: Latency mode set to: 6 - Good",
    /* 7 */ L"CnCNet: Latency mode set to: 7 - Default",
    /* 8 */ L"CnCNet: Latency mode set to: 8 - Default",
    /* 9 */ L"CnCNet: Latency mode set to: 9 - Default",
};

bool UseProtocolZero = false;
uint8_t MaxLatencyLevel = LATENCY_LEVEL_MAX;
uint8_t LatencyMode = LATENCY_LEVEL_INITIAL;
extern uint8_t NewFrameSendRate = 3;
extern int32_t WorstMaxAhead = 24;

int SendResponseTimeInterval = 30;
int TimingTimeout = 4 * 30;
int SendResponseTimeFrame = 8 * 30;

uint8_t LatencyMode_from_ResponseTime(uint8_t rspTime)
{
    for (uint8_t i = 1; i < LATENCY_LEVEL_MAX; i++)
    {
        if (rspTime <= LatencyLevels_MaxAhead[i])
            return i;
    }

    return LATENCY_LEVEL_MAX;
}

void LatencyMode_Apply(uint8_t setLatencyMode)
{
    if (setLatencyMode > LATENCY_LEVEL_MAX)
        setLatencyMode = LATENCY_LEVEL_MAX;

    if (setLatencyMode > MaxLatencyLevel)
        setLatencyMode = MaxLatencyLevel;

    if (setLatencyMode <= LatencyMode)
        return;

    WWDebug_Printf("Player %d, Loss mode (%d, %d)\n", PlayerPtr->ArrayIndex, setLatencyMode, LatencyMode);

    PreCalcFrameRate = 60;
    LatencyMode = setLatencyMode;
    NewFrameSendRate = setLatencyMode;
    PreCalcMaxAhead = LatencyLevels_MaxAhead[setLatencyMode];

    wchar_t* message = LatencyLevels_Message[setLatencyMode];
    MessageListClass__Add_Message(&MessageListClass_this, 0, 0, message, 4, 0x4096, 270, 1);
}

void Send_Response_Time()
{
    if (UseProtocolZero)
    {
        int32_t rspTime = IPXManagerClass__Response_Time(&IPXManagerClass_this);
        if (rspTime > -1 && (Frame > SendResponseTimeFrame))
        {
            SendResponseTimeFrame = Frame + SendResponseTimeInterval;

            EventClass event;
            event.Type = EVENTTYPE_RESPONSE_TIME2;
            event.Frame = Frame + MaxAhead;
            event.Data.ResponseTime2.PlayerID = PlayerPtr->ArrayIndex;
            event.Data.ResponseTime2.MaxAhead = (int8_t)rspTime + 1;
            event.Data.ResponseTime2.LatencyLevel = LatencyMode_from_ResponseTime(rspTime);
            EventClass__Add(&event);
            WWDebug_Printf("Player %d sending response time of %d, LatencyMode = %d\n",
                           PlayerPtr->ArrayIndex, event.Data.ResponseTime2.MaxAhead, event.Data.ResponseTime2.LatencyLevel);
        }
    }
}

int32_t PlayerMaxAheads[8] = {0, 0, 0, 0, 0, 0, 0, 0};
uint8_t PlayerLatencyMode[8] = {0, 0, 0, 0, 0, 0, 0, 0};
int32_t PlayerLastTimingFrame[8] = {0, 0, 0, 0, 0, 0, 0, 0};

void __thiscall Handle_Timing_Change(EventClass *event)
{
    if (UseProtocolZero == false || (SessionType != 3 && SessionType != 4))
        return;

    if (event->Data.ResponseTime2.MaxAhead == 0)
    {
        WWDebug_Printf("Returning because event->MaxAhead == 0\n");
        return;
    }

    int32_t id = event->Data.ResponseTime2.PlayerID;
    PlayerLastTimingFrame[id] = event->Frame;
    PlayerMaxAheads[id] = (int32_t)event->Data.ResponseTime2.MaxAhead;
    PlayerLatencyMode[id] = event->Data.ResponseTime2.LatencyLevel;

    uint8_t setLatencyMode = 0;
    int max = 0;
    for (int i = 0; i < 8; ++i)
    {
        if (PlayerLastTimingFrame[i] + TimingTimeout < Frame)
        {
            PlayerMaxAheads[i] = 0;
            PlayerLatencyMode[i] = 0;
        }
        else
        {
            max = PlayerMaxAheads[i] > max ? PlayerMaxAheads[i] : max;
            if (PlayerLatencyMode[i] > setLatencyMode)
                setLatencyMode = PlayerLatencyMode[i];
        }
    }
    WorstMaxAhead = max;
    LatencyMode_Apply(setLatencyMode);
}

int32_t __thiscall Hack_Response_Time(IPXManagerClass *this)
{
    return WorstMaxAhead;
}

void __thiscall Hack_Set_Timing(IPXManagerClass *this, int NewRetryDelta, int NewMaxRetries, int NewRetryTimeout, bool SetGlobalConnClass)
{

    IPXManagerClass__Set_Timing(this, NewRetryDelta, NewMaxRetries, NewRetryTimeout, SetGlobalConnClass);
    WWDebug_Printf("NewRetryDelta = %d,  NewRetryTimeout = %d, FrameSendRate = %d, LatencyMode = %d\n",
                   NewRetryDelta, NewRetryTimeout, FrameSendRate, LatencyMode);
}