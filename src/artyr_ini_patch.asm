%include "macros/patch.inc"

; Rename ARTMD.INI -> ARTYR.INI at address 0x00826254
; Based on original constant at that address (length 10 incl. NUL)
SETSTRING 0x00826254, "ARTYR.INI"
