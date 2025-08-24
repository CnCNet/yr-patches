%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

%include "session.inc"

; Prevent losing/winning in skirmish spectator mode
; And allow skirmish spectators to control gamespeed
; Show observer loading screen for skirmish spectators
; TODO: Allow multiple spectators to watch an AI fight in multiplayer
@HACK 0x004FCBD0, _HouseClass__Flag_To_Lose_Skirmsh_Spectator_Patch
	cmp dword [SessionType], 5
	jnz .Normal_Code

	cmp dword [ObserverMode], 1
	jnz .Normal_Code

	retn 4

.Normal_Code:
	sub esp, 10h
	push ebp
	mov ebp, ecx
	mov dword [esp+10h], 0
	jmp 0x004FCBDE
@ENDHACK

@HACK 0x006439F4, _ProgressScreenClass_643720_Skirmsh_Spectator_Patch
	mov ecx, dword [SessionType]
	test ecx, ecx
	jz  0x00643A18    ; jump if (SessionType == Campaign)
	jmp 0x00643A04
@ENDHACK

@HACK 0x00642B60, _ProgressScreenClass_LoadTextColor3_Skirmsh_Spectator_Patch
	mov eax, dword [SessionType]
	test eax, eax
	jz  0x00642B8B    ; jump if (SessionType == Campaign)
	jmp 0x00642B6F
@ENDHACK

@HACK 0x004FC9E0, _HouseClass__Flag_To_Win_Skirmsh_Spectator_Patch
	cmp dword [SessionType], 5
	jnz .Normal_Code

	cmp dword [ObserverMode], 1
	jnz .Normal_Code

	retn 4

.Normal_Code:
	sub esp, 10h
	push ebx
	mov ebx, ecx
	jmp 0x004FC9E6
@ENDHACK

@HACK 0x005533EA, _Select_Load_Screen_Skirmish_Spectator
	cmp dword [SessionType], 5
	jnz .Normal_Code

	cmp dword [ObserverMode], 1
	jnz .Normal_Code

	jmp 0x005533EF

.Normal_Code:
	mov eax, [SessionType]
	cmp eax, 4
	jnz 0x00553412
	jmp 0x005533EF
@ENDHACK

@HACK 0x005539EE, _Select_Load_Screen_Skirmish_Spectator2
	cmp dword [SessionType], 5
	jnz .Normal_Code

	cmp dword [ObserverMode], 1
	jnz .Normal_Code

	jmp 0x005539F3

.Normal_Code:
	mov eax, [SessionType]
	cmp eax, 4
	jnz 0x00553A05
	jmp 0x005539F3
@ENDHACK

@HACK 0x005536AA, _Select_Load_Screen_Skirmish_Spectator3
	cmp dword [SessionType], 5
	jnz .Normal_Code

	cmp dword [ObserverMode], 1
	jnz .Normal_Code

	jmp 0x005536AF

.Normal_Code:
	mov eax, [SessionType]
	cmp eax, 4
	jnz 0x005536DA
	jmp 0x005536AF
@ENDHACK
