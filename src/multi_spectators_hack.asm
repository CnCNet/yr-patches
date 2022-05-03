%include "macros/patch.inc"
%include "macros/hack.inc"
%include "session.inc"

@LJMP 0x0068811C, Assign_Houses_Multi_Spectators_Hack
;@LJMP 0x004FCBD0, HouseClass__Flag_To_Lose_RETN_Patch

cextern PlayerPtr

HouseClass__Flag_To_Lose_RETN_Patch:
	jmp 0x004FCDBC ; jmp to 'RETN 4' instruction

Assign_Houses_Multi_Spectators_Hack:
	mov edx, [PlayerPtr]
	cmp [0x00AC1198], edx
	jz .Ret
	mov [0x00AC1198], ebp

.Ret:
	jmp 0x00688122