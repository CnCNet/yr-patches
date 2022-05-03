%include "macros/patch.inc"
%include "macros/datatypes.inc"

;"Tiberian Sun requires a mouse to play" error - remove the GetSystemMetrics check
@CLEAR 0x006BD8A4, 0x90, 0x006BD8C2
