#ifndef HOUSECLASS_H
#define HOUSECLASS_H

#include <stdint.h>
#include <stdbool.h>
#include "INIClass.h"

void __thiscall HouseClass__Make_Ally_id(void *this, int32_t id, bool announce);
void __thiscall HouseClass__Make_Ally_house(void *this, void *house, bool announce);
void __thiscall HouseClass__Alliance_Broken(void *house, void *other, bool announce);
void __thiscall HouseTypeClass__Read_INI(void *houseType, INIClass *ini);

typedef struct HouseTypeClass_vtable HouseTypeClass_vtable;

typedef struct HouseType {
    HouseTypeClass_vtable *vtable;
} HouseType;

typedef struct HouseTypeClass_vtable {
    char gap[0x64];
    int (__thiscall *Read_INI)(HouseType *houseType, INIClass *ini);
} HouseTypeClass_vtable;

typedef struct HouseClass {
    char gap[0x30];
    int ArrayIndex;
} HouseClass;

extern HouseClass *PlayerPtr;
HouseType **HouseTypeClassArray;
int32_t HouseTypeClassArray_Count;

#endif
