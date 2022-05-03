%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "System.inc"

gbool NoWindowFrame, 1

hack 0x00777CC0
SetNoWindowFrame:
    pusha
    cmp byte [NoWindowFrame], 1
    je  .Frameless

    push 1                      ; Height
    call [_imp__GetSystemMetrics]
    cmp  eax, dword[ScreenHeight]
    jne  .out

    push 0
    call [_imp__GetSystemMetrics]
    cmp  eax, dword[ScreenWidth]
    jne  .out

 .Frameless:
    popa
    push 0x860A0000
    jmp  hackend

 .out:
    popa
    push 0x02CA0000
    jmp  hackend
