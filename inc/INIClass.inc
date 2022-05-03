%include "macros/extern.inc"

; INIClass
cextern INIClass__INIClass
cextern INIClass__Load
;extern ?GetBool@INIClass@@QAE_NPBD0_N@Z
;%define INIClass__GetBool ?GetBool@INIClass@@QAE_NPBD0_N@Z
cextern INIClass__GetBool
cextern INIClass__GetInt
cextern INIClass__GetString
cextern INIClass__GetFixed
cextern Load_SPAWN_INI

; args: <INIClass this>, <INI section string>, <INI key string>, <default value if missing>
%macro call_INIClass__GetInt 4
    push %4
    push %3
    push %2
    mov ecx, %1
    call INIClass__GetInt
%endmacro

; args: <INIClass this>, <INI section string>, <INI key string>, <default value if missing>
%macro call_INIClass__GetBool 4
    push %4
    push %3
    push %2
    mov ecx, %1
    call INIClass__GetBool
%endmacro

%macro call_INIClass__GetString 6
    push %6
    push %5
    push %4
    push %3
    push %2
    mov ecx, %1
    call INIClass__GetString
%endmacro

%macro call_INIClass__GetFixed 5
    push %5
    push %4
    push %3
    push %2
    mov ecx, %1
    call INIClass__GetFixed
%endmacro
