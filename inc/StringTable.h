#include <stdint.h>

#pragma pack(push, 1)

typedef struct csfLabelEntry {
    char label[32];
    int32_t numValues;
    int32_t index;
} csfLabelEntry;

typedef struct csfString {
    wchar_t Text[102];
} csfString;

#pragma pack(pop)


extern csfString **CSF_Text_Array;
extern int32_t CSF_Text_Array_Count;

extern csfLabelEntry *CSF_Label_Array;
extern int32_t CSF_Label_Array_Count;
