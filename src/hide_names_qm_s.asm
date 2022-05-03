%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "macros/string.inc"

cextern QuickMatch

String16 Player, 'PLAYER'
gint ptr_Player, str16_Player

hack 0x0064B168, 0x0064B16E
    cmp byte[QuickMatch], 0
    jz  .Reg

    mov dword[esp+12], str16_Player

 .Reg:
    call dword[0x007E14A4]
    jmp hackend

hack 0x00648ED3
    cmp byte[QuickMatch], 0
    jz  .Reg

    mov dword[esp+8], str16_Player

 .Reg:
    call 0x007CA564
    jmp hackend
