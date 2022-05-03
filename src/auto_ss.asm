%include "session.inc"
%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "c.inc"

cextern SpawnerActive
cextern RunAutoSS
gint DoingAutoSS, 0

sstring str_AutoSSDir, "AutoSS"
sstring str_AutoSSFileNameFormat, "AutoSS/AutoSS-%d-%d_%d.PCX"
sstring str_AutoSSFileNamePng,    "AutoSS/AutoSS-%d-%d_%d.png"
sstring str_AutoSSFileNameJpg,    "AutoSS/AutoSS-%d-%d_%d.jpg"
sstring str_SCRN_png,             "SCRN%04d.png"

hack 0x00537D02
_ScreenCaptureCommandClass__Process_File_Name:
    lea ecx, [esp+0x124]

    cmp byte[RunAutoSS], 1
    jnz .Normal_Code

 .AutoSS_File_Name:

    push 0
    push str_AutoSSDir
    call [0x007E1108]

    lea ecx, [esp+0x124]

    push esi
    push dword[Frame]
    push dword[WOLGameID]

    cmp  byte[RunAutoSS], 1     ; Allows users to take AutoSSes in ladder games
    je   .jpg

    cmp  byte[UsePNG], 1
    jne  .pcx

 .png:
    push str_AutoSSFileNamePng
    jmp  .past_pcx

 .jpg:
    push str_AutoSSFileNameJpg
    jmp  .past_pcx

 .pcx:
    push str_AutoSSFileNameFormat

 .past_pcx:
    push ecx
    call _sprintf
    add esp, 0x14
    jmp 0x00537D18

 .Normal_Code:
    cmp byte[UsePNG], 1
    jne .Reg_pcx

    push esi
    push str_SCRN_png
    jmp  0x00537D0F

 .Reg_pcx:
    jmp  0x00537D09
