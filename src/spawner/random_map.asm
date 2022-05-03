%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "macros/string.inc"
%include "INIClass.inc"

gbool RandomMap, 0

StringZ Basic, "Basic"
StringZ RandomMap, "RandomMap"
cextern MapSeed

cextern Scenario
cextern ScenarioName
cextern Seed

;;; Don't create units twice, Not needed in YR?
;@CLEAR 0x00684990, 0x90, 0x00684995

hack 0x006849C9
    call 0x00686730              ; Read_Scenario_INI

    cmp byte[RandomMap], 0
    jz  hackend

    jmp 0x0068496B

hack 0x00686C43
    call 0x005295F0

    cmp  byte[RandomMap], 1
    je   hackend

    mov  bl, al

    call_INIClass__GetBool ebp, str_Basic, str_RandomMap, 0
    mov  byte[RandomMap], al

    mov  al, bl
    xor  ebx, ebx

    cmp  byte[RandomMap], 0
    jz   hackend

    mov  ecx, [Scenario]
    mov  byte[ecx+0x34BD], 1

    xor  al, al
    jmp  0x00687917

;;; Hack Get_Starting_locations, it seems to be broken in random maps.
;;; This can be skipped because the starting location in random maps is stored somewhere else.
hack 0x006885B5
    cmp byte[RandomMap], 0
    jz  .Reg

    add  esp, 0x3C
    jmp  hackend

 .Reg:
    call 0x0056DC20
    jmp  hackend

;;; Hack rmp to read the sceanrio for unit mods and stuff
sstring ScenarioFile, "", 0x68
hack 0x005997A6
    mov  ecx, ScenarioFile
    push ScenarioName
    call 0x004739F0

    lea  ecx, [esp+0x54]
    push 0
    push 1
    push ScenarioFile
    call 0x004741F0

 .Ret:
    add esp, 8
    jmp hackend

;;; Use Seed from spawn.ini rather than from the map.
hack 0x00597B71
    call 0x005276D0             ;INIClass_GetInteger

    mov eax, [Seed]
    jmp hackend
