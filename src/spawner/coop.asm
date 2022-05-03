%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

@LJMP 0x00553321, 0x005533C5 ; skip some stuff detecting coop map for loading screen stuff (loading screen text?)

hack 0x0055D0E2, 0x0055D0E8
_Coop_Endgame_Crash_Fix:
	add esp,4 ; skip original function call
	jmp hackend
