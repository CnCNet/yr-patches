#include <search.h>
#include <windows.h>
#include "macros/patch.h"
#include "RA.h"
#include "INIClass.h"
#include "StringTable.h"


CALL(0x0073482A, _StringTable_LoadFile_hack2);
CALL(0x0073486A, _StringTable_LoadFile_hack);
CALL(0x0073489A, _StringTable_LoadFile_hack);
CALL(0x00686C43, _read_tut_from_map);

void *
StringTable_LoadFile_hack(uint32_t sz) {
    // Add 100 empty entires in the CSF Tables for use later
    sz += 4 * 100;
    new(sz);
}

void *
StringTable_LoadFile_hack2(uint32_t sz) {
    // Add 100 empty entires in the CSF Tables for use later
    sz += sizeof(csfLabelEntry) * 100;
    new(sz);
}


void __thiscall
read_tut_from_map(INIClass *scenario, char *section, char *entry, int fallback) {
    char buf[0x200] = {0};
    wchar_t wbuf[0x400] = {0};

    char *entryName;
    csfLabelEntry *labelEntry;
    csfString *csf;
    int len;
    int wlen;

    int i = INIClass__EntryCount(scenario, "Tutorial");
    if (i > 100)
        i = 100;

    WWDebug_Printf("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& In read_tut_from_map entry count = %d\n", i);
    while (i-->0)
    {
        entryName = INIClass__GetEntry(scenario, "Tutorial", i);

        labelEntry = &CSF_Label_Array[CSF_Label_Array_Count];
        CSF_Label_Array_Count++;

        memcpy(labelEntry->label, entryName, 31);


        csf = new(sizeof(csfString));
        len = INIClass__GetString(scenario, "Tutorial", entryName, 0, buf, 0x200);
        if (len > 0)
            wlen = MultiByteToWideChar(CP_UTF8, MB_PRECOMPOSED, buf, -1, csf->Text, 0x400);

        CSF_Text_Array[CSF_Text_Array_Count] = csf;

        labelEntry->numValues = 1;
        labelEntry->index = CSF_Text_Array_Count;

        CSF_Text_Array_Count++;

        WWDebug_Printf("*****************Found entry '%s' = %s\n", labelEntry->label, buf);
    }
    qsort(CSF_Label_Array, CSF_Label_Array_Count, sizeof(csfLabelEntry),
          (int (__attribute__((__cdecl__)) *)(const void *, const void *))strcmpi);

    INIClass__GetBool(scenario, section, entry, fallback);
}
