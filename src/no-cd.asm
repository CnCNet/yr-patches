; Info taken from Ares source code
; https://github.com/Ares-Developers/Ares/blob/master/src/Misc/CopyProtection.cpp

%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"

[section .bss]
cglobal NoCD__Disable_CD
NoCD__Disable_CD resb 1
__SECT__

[section .rdata]
StringManagerErrorCDWarning: dw __utf16__("***FATAL*** String Manager failed to initilaized properly!")
db 0x0a,0x00,0x0a,0x00
dw __utf16__("If you enabled no-CD make sure the files 'multimd.mix' and 'mapsmd03.mix' are in the game install folder, they're usually located on the CD."),0
__SECT__

@HACK 0x00734E7A, StringManagerFatalError_Change_String
	mov eax, StringManagerErrorCDWarning
    jmp  0x00734E7F
@ENDHACK

@HACK 0x00530B67, NoCD__Init_Secondary_MixFiles_Continue_When_MAPSMD03_MIX_Missing
		jmp 0x00530B76
@ENDHACK

@HACK 0x00530BF8, NoCD__Init_Secondary_MixFiles_Continue_When_MULTIMD_MIX_Missing
		jmp 0x00530C09
@ENDHACK


@HACK 0x006BE719, NoCD__in_WinMain_fix_crash_when_NoCD_is_enabled
    mov  ecx, dword [0x00884E2C] ; MoviesMix?
    jz   0x006BE72F              ; add NULL pointer check
    jmp  0x006BE71F
@ENDHACK


@HACK 0x00531236, NoCD__Init_Secondary_MixFiles_Continue_When_Movies_Missing
    test bl, bl
    jz   .No_Movies
    push 28h                     ; unsigned int
    jmp  0x0053123C

  .No_Movies:
    mov  dword [0x00884E2C], 1
    jmp  0x00531269
@ENDHACK


@HACK 0x0052C3B3, NoCD__Init_Game_NoCD_Check
    cmp  byte [NoCD__Disable_CD], 1
    jz   0x0052C5BF
    cmp  eax, ebx
    jnz  0x0052C5BF
    jmp  0x0052C3BB
@ENDHACK


@HACK 0x00479110, NoCD__NeverAskForCD
    cmp  byte [NoCD__Disable_CD], 0
    jz   .Normal_Code

  .NoCD:
    mov  al, 1
    jmp  0x004791EA              ; jump to retn instruction

  .Normal_Code:
    push ebx
    push esi
    push edi
    mov  edi, ecx
    jmp  0x00479115
@ENDHACK


@HACK 0x004790E0, NoCD__AlwaysAvailable
    cmp  byte [NoCD__Disable_CD], 0
    jz   .Normal_Code

  .NoCD:
    mov  al, 1
    jmp  0x00479109              ; jump to retn instruction

  .Normal_Code:
    mov  eax, [esp+4]            ; arg_0
    cmp  eax, 0FFFFFFFEh
    jmp  0x004790E7
@ENDHACK


@HACK 0x004A80D0, NoCD__AlwaysFindYR
    cmp  byte [NoCD__Disable_CD], 0
    jz   .Normal_Code

  .NoCD:
    mov  eax, 2
    jmp  0x004A8265              ; jump to retn instruction

  .Normal_Code:
    sub  esp, 120h
    jmp  0x004A80D6
@ENDHACK

