%include "macros/patch.inc"
%include "macros/datatypes.inc"


; what is this?
hack 0x0071A978
    add esp, 8
    jmp hackend

;@CLEAR 0x0043FD12, 0x90, 0x0043FD1A
;@CLEAR 0x0043FD24, 0x90, 0x0043FD2C


; Fixes a bug where Chrono Legionnaires, whose infantry targets are Chronoshifted away,
; start instantly erasing all of their targets afterwards.
; With this patch, infantry targeted by Chrono Legionnaires are now simply skipped
; when processing the Chronosphere SW.
; -------------------
; Author: Rampastring
hack 0x006CC878
    ; Stolen bytes / code
    mov  cl, [eax+0CD4h] ; TechnoTypeClass.Teleporter
    test cl, cl
    jnz  0x006CC8D1      ; continue to teleporting infantry

    mov  al, [esi+270h]  ; TechnoClass.BeingWarpedOut
    test al, al
    jnz  0x006CCCCA      ; Skip this object

    mov  eax, [esi+278h] ; TechnoClass.TemporalEffectSource
    test eax, eax
    jnz  0x006CCCCA      ; Skip this object

    ; Continue processing this infantry
    jmp  0x006CC882


