typedef  struct UDPInterfaceClass {
    char v[259532];
} UDPInterfaceClass;

typedef UDPInterfaceClass WinsockInterfaceClass;

extern WinsockInterfaceClass *WinsockInterface_this;
extern char IPXManagerClass_this;

UDPInterfaceClass * __thiscall UDPInterfaceClass__UDPInterfaceClass(void *);
void __thiscall WinsockInterfaceClass__Init(WinsockInterfaceClass *this);
void __thiscall UDPInterfaceClass__Open_Socket(UDPInterfaceClass *this, int32_t a);
void __thiscall WinsockInterfaceClass__Discard_In_Buffers(WinsockInterfaceClass *this);
void __thiscall WinsockInterfaceClass__Discard_Out_Buffers(WinsockInterfaceClass *this);
void __thiscall WinsockInterfaceClass__Start_Listening(WinsockInterfaceClass *this);

void __thiscall IPXManagerClass__Set_Timing(void *this, int32_t a1, int32_t a2, int32_t a3, int32_t a4);

extern int32_t MaxAhead;
extern int32_t FrameSendRate;
extern int32_t MaxMaxAhead;
extern int32_t LatencyFudge;
extern int32_t RequestedFPS;
extern int32_t ProtocolVersion;
extern int32_t HumanPlayers;
extern time_t PlanetWestwoodStartTime;
extern int32_t GameStockKeepingUnit;
