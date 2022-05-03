%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

extern _SetWin8CompatData


@HACK 0x0004A3FD8, _Direct_Create_Compatibility_Fix_Win8
	call 0x004068E0
	
	call _SetWin8CompatData
	jmp 0x004A3FDD
@ENDHACK