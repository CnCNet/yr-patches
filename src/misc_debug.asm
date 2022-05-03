%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;;  Press f key to enable debug_map mode

cextern Debug_Map
;; @SJMP 0x0055D0FE, 0x0055D117
hack 0x00537A10
        mov     eax,  [0x00A8ECC8]
        cmp     byte [Debug_Map], 1
        je      .unset

        mov     byte [Debug_Map], 1
        jmp     hackend

.unset:
        mov     byte [Debug_Map], 0
        jmp     hackend
