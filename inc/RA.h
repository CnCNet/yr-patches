#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <windows.h>
#include "FileClass.h"
#include "DSurface.h"

#ifndef WWDEBUG
#define WWDebug_Printf(format, ...)
#else
void WWDebug_Printf(char *fmt, ...);
#endif

unsigned long Crc32_ComputeBuf( unsigned long inCrc32, const void *buf, size_t bufLen );
void __thiscall Keyboard_Process(void *this);
void DoCrcFile();
extern uint32_t Frame;
extern uint32_t WOLGameID;
extern uint32_t SessionType;
extern bool OutOfSync;
extern bool QuickMatch;
extern bool RunAutoSS;
extern bool DoingAutoSS;
extern bool UsePNG;


void *new(int32_t size);
void __thiscall ScenarioClass_ReadLightingAndBasic(void *this, void *ini);

void ScoreScreen_Present();
void __fastcall SetVideoMode(int32_t width, int32_t height);

void __thiscall CRC_DWORD(void *this, uint32_t dw);

LONG PrintException(int exception_id, struct _EXCEPTION_POINTERS *ExceptionInfo);

void __thiscall ProgressScreenClass_PrintPlayer(void *this, int32_t x, int32_t y, wchar_t *name, void *color, void *arg);
void __thiscall Draw_Confined_PCX(void *pcx, void *a2, void *surface, void *a4, void *a5);

void __fastcall Write_PCX_File(CCFileClass *ccfile, DSurface *surface, void *palette);

void __thiscall ScreenCaptureCommandClass_Execute();
void __thiscall MessageListClass__Manage(void *message_list);
