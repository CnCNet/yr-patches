%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "c.inc"
%include "event.inc"
cextern PlayerPtr

gbyte RAGING, 0

hack 0x00777865, 0x0077786B
Handle_Rage_Quit:
        jnz  0x007779B9

        mov byte[RAGING], 1
        jmp 0x0048CBAE          ; Jump into surrender dialog
RAGED:  jmp hackend

;;; Surrender_Dialog
;;; This Section handles surrendering with Event 8
hack 0x0048CC1E
        call Queue_Exit

        cmp byte[RAGING], 0
        jnz  RAGED              ; Jump out of surrender dialog

        jmp  hackend
