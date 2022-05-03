%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

cextern MultiEngineer


@HACK 0x0051E5BB, _InfantryClass_GetCursorOverObject_MultiEngineerA
	jmp 0x0051E5D9
@ENDHACK

@HACK 0x0051E5E1, _InfantryClass_GetCursorOverObject_MultiEngineerB
	call Engineer_Damage_Or_Capture
	cmp eax, 0x1C
	jnz .Ret
	
; Set mouse corsor TODO
	push    1
	push    0x33 
	mov     ecx, 0x0087F7E8
	call    0x005BDA80
	mov eax, 0x1c

.Ret:
	pop     ebx
	add     esp, 28h
	retn 8
@ENDHACK


@HACK 0x00519D9C, _InfantryClass_UpdatePosition_MultiEngineer
	mov ecx, edi ; BuildingClass*
	call Engineer_Damage_Or_Capture
	
	cmp eax, 0x1C
	jz .Damage

.Capture:
	jmp 0x00519EAA
	
.Damage:
	jmp 0x00519DD4
@ENDHACK


Engineer_Damage_Or_Capture:
	pushad
	cmp byte [MultiEngineer],0
	jz .Capture

; Check for tech/neutral buildings
	mov     eax, [ecx+14Ch]
	test    eax, eax
	jz      .Check_Building_Health
	mov     eax, [eax+34h]
	test    eax, eax
	jz      .Check_Building_Health
	cmp		byte [eax+1A6h], 1
	jz		.Capture

.Check_Building_Health:	
	call    0x005F5C60 ; Get building health?
	mov     edx, [0x008871E0] ; RulesClass
	fcomp   qword [edx+1708h] ; ConditionRed
	fnstsw  ax
	test    ah, 41h
	jnz .Capture
	
.Damage:
	popad
	mov eax, 0x1C
	retn
	
.Capture:
	popad
	mov eax, 9
	retn
	