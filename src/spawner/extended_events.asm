%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/extern.inc"

cextern Extended_Events

@HACK 0x004C6CC8, _Networking_RespondToEvent
	PUSHAD

	mov  al, [esi]
	cmp  eax, 46
	ja  .Extended

.Normal_Code:
	POPAD
	mov  al, [esi]
	mov  edi, [ecx+ebx*4]
	jmp  0x004C6CCD

.Extended:
	push esi
	call Extended_Events
	jmp  .Normal_Code
@ENDHACK
