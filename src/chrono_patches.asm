%include "macros/patch.inc"
%include "macros/datatypes.inc"



hack 0x0071A978
    add esp, 8
    jmp hackend

;@CLEAR 0x0043FD12, 0x90, 0x0043FD1A
;@CLEAR 0x0043FD24, 0x90, 0x0043FD2C
