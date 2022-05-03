%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"


;;; Cap the sidebar height to 1376 pixels.
hack 0x006A518E
    mov dword[0x00886F9C], eax

    cmp eax, 1376
    jl  hackend

    mov dword[0x00886F9C], 1376
    jmp hackend
