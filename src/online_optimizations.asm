%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern _imp__Sleep

;;; Throttle wait_for_players to 333 times per second.
hack 0x00649851
    push 3
    call [_imp__Sleep]

    jmp 0x006488B0
