%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

[section .bss]
cglobal Disable_Blowfish_DLL
Disable_Blowfish_DLL resb 0
__SECT__


@HACK 0x006BC382, _Blowfish_DLL_Disable_Dont_Load1
	cmp byte [Disable_Blowfish_DLL], 1
	jz .Ret
	push eax  ; lpLibFileName
	call ebx ; LoadLibraryA
	mov edi, eax
	jmp 0x006BC387
	
.Ret:
	jmp 0x006BC39D
@ENDHACK

@HACK 0x006BC3BA, _Blowfish_DLL_Disable_Dont_Load2
	cmp byte [Disable_Blowfish_DLL], 1
	jz .Ret
	push edi ; hLibModule
	call [0x007E1224]   ; ds:FreeLibrary
	jmp 0x006BC3C1
	
.Ret:
	jmp 0x006BC3CA
@ENDHACK

@HACK 0x006BD6D0, _Blowfish_DLL_Disable_Dont_Load3
	cmp byte [Disable_Blowfish_DLL], 1
	jz .Ret
	test al, al
	jz 0x006BD71D
	push 30h ; uType
	jmp 0x006BD6D6
.Ret:
	jmp 0x006BD71D
@ENDHACK