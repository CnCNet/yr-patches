typedef  struct UDPInterfaceClass {
    char v[259532];
} UDPInterfaceClass;

typedef UDPInterfaceClass WinsockInterfaceClass;
typedef void IPXManagerClass;

extern WinsockInterfaceClass *WinsockInterface_this;
extern char IPXManagerClass_this;

UDPInterfaceClass * __thiscall UDPInterfaceClass__UDPInterfaceClass(void *);
void __thiscall WinsockInterfaceClass__Init(WinsockInterfaceClass *this);
void __thiscall UDPInterfaceClass__Open_Socket(UDPInterfaceClass *this, int32_t a);
void __thiscall WinsockInterfaceClass__Discard_In_Buffers(WinsockInterfaceClass *this);
void __thiscall WinsockInterfaceClass__Discard_Out_Buffers(WinsockInterfaceClass *this);
void __thiscall WinsockInterfaceClass__Start_Listening(WinsockInterfaceClass *this);

void __thiscall IPXManagerClass__Set_Timing(IPXManagerClass *this, int32_t NewRetryDelta, int32_t NewMaxRetries, int32_t NewRetryTimeout, bool SetGlobalConnClass);
int32_t __thiscall IPXManagerClass__Response_Time(IPXManagerClass *this);

extern int32_t MaxAhead;
extern int32_t FrameSendRate;
extern int32_t MaxMaxAhead;
extern int32_t LatencyFudge;
extern int32_t RequestedFPS;
extern int32_t ProtocolVersion;
extern bool    UseProtocolZero;
extern int32_t PreCalcMaxAhead;
extern int32_t PreCalcFrameRate;
extern int32_t HumanPlayers;
extern time_t PlanetWestwoodStartTime;
extern int32_t GameStockKeepingUnit;
