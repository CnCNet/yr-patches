%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

cextern ObserverMode
cextern SessionType

; Prevent losing/winning in skirmish spectator mode
; And allow skirmish spectators to control gamespeed
; Show observer loading screen for skirmish spectators

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

@HACK 0x004E20BA, _Dlg_Stuff_Show_Gamespeed_Slider_Skirmish_Spectator
	cmp dword [SessionType], 5
	jnz .Normal_Code
	
	cmp dword [ObserverMode], 1
	jnz .Normal_Code
	
	jmp 0x004E211A
	
.Normal_Code:
	mov eax, dword [0x00A8B538]
	jmp 0x004E20BF
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