typedef struct SessionClass {
    char v[128];
} SessionClass;

extern SessionClass SessionClass_this;

void __thiscall SessionClass__Read_Scenario_Descriptions(SessionClass *this);
void __thiscall SessionClass__Create_Connections(SessionClass *this);

void __fastcall Start_Scenario(char *name, int32_t a1, int32_t a2);

void * __fastcall Set_Game_Mode(int32_t mode);
