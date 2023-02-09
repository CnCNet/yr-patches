%include "macros/patch.inc"
%include "macros/hack.inc"

%include "House.inc"
%include "session.inc"

@LJMP 0x0068811C, Assign_Houses_Multi_Spectators_Hack
;@LJMP 0x004FCBD0, HouseClass__Flag_To_Lose_RETN_Patch

HouseClass__Flag_To_Lose_RETN_Patch:
	jmp 0x004FCDBC ; jmp to 'RETN 4' instruction

Assign_Houses_Multi_Spectators_Hack:
	mov edx, [PlayerPtr]
	cmp [PlayerPtr2_Observer], edx
	jz .Ret
	mov [PlayerPtr2_Observer], ebp

.Ret:
	jmp 0x00688122