%include "macros/patch.inc"
%include "macros/extern.inc"

cextern Extended_Events

_EventClass__Execute_Extended:
    push esi
    call Extended_Events

    jmp 0x004C8109

hack 0x004C6CD1, 0x004C6CD7
    ja  _EventClass__Execute_Extended
    jmp hackend
