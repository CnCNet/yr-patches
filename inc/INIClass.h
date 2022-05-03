#ifndef INICLASS_H
#define INICLASS_H

#include <stdbool.h>
#include <stdint.h>

typedef struct INIClass_S {
    char v[256];
} INIClass;



void __thiscall INIClass__INIClass(INIClass *this, INIClass *that);
void __thiscall INIClass__Load(INIClass *this, INIClass *that, int32_t dunno);

bool __thiscall INIClass__GetBool(INIClass *this, const char *section, const char *key, bool def);
int  __thiscall INIClass__GetInt(INIClass *this, char *section, char *key, int defaultValue);
bool __thiscall INIClass__GetString(INIClass *this, const char *section, const char *key, char *def, char *out, int size);
int __thiscall INIClass__EntryCount(INIClass *this, const char *section);
char *__thiscall INIClass__GetEntry(INIClass *this, const char *section, int index);
extern INIClass INIClass_SPAWN;

#endif //INICLASS_H
