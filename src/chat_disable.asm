%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern DisableChat

; Don't send message to others.
hack 0x0055EF38, 0x0055EF3E
    cmp byte[DisableChat], 0
    jz  .Reg
    jmp 0x0055F056

.Reg:
    cmp edi, ebx
    mov dword[esp + 0x14], ebx
    jmp hackend

; After receiving message, don't play sound if AddMessage returns NULL.
hack 0x0048D97E
    cmp eax, 0
    je 0x0048D99A

.Reg:
    mov eax, [0x008871E0]
    jmp hackend