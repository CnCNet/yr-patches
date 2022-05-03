; AlexB's graphics patch
; Source: http://www.stuffhost.de/files/cnc/

%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

section .bss
cglobal Graphics__Enable_Patch
Graphics__Enable_Patch resb 1

section .text

@HACK 0x004BA61F, Graphics_Patch
    cmp byte [Graphics__Enable_Patch], 1
    jz  .Ret

    cmp al, 1
    jnz 0x004BA62D

  .Ret:
    mov edx, [esi+20h]
    jmp 0x004BA626
@ENDHACK
