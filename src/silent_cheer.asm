%include "macros/patch.inc"
%include "macros/datatypes.inc"

cextern LANTaunts
cextern WOLTaunts
cextern SessionType
cextern Rules

hack 0x0050C8F4, 0x0050C8F9
 .CheckLan:
 	mov eax, dword[SessionType]
	cmp eax, 3 ; GAME_IPX
	jne .CheckWol
 
	mov al, byte[LANTaunts]
	test al, al
	jnz .DoCheer
	
	jmp .SkipCheer
	
 .CheckWol:
  	mov eax, dword[SessionType]
	cmp eax, 4 ; GAME_INTERNET
	jne .DoCheer
 
	mov al, byte[WOLTaunts]
	test al, al
	jnz .DoCheer
 
	jmp .SkipCheer
	
 .DoCheer:
	mov eax, dword[Rules]
	jmp hackend

 .SkipCheer:
	jmp 0x0050C910
