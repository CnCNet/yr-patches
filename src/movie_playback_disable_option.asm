%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

[section .bss]
cglobal Disable_Movie_Playback
Disable_Movie_Playback resb 0
__SECT__


@HACK 0x005BED40, _Play_Movie_Optional_Movie_Playback
	cmp byte [Disable_Movie_Playback], 1
	jz .Ret
	sub esp, 140h
	jmp 0x005BED46
	
.Ret:
	jmp 0x005BF178
@ENDHACK