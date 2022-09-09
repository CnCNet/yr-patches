%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "macros/string.inc"

cextern Ra2Mode

;;; Allow buildings to be selected with the type command/key in RA2 mode.
hack 0x00732C57, 0x00732C5D
   cmp byte[Ra2Mode], 0
   jz  .Reg

   call [edx+0x138]
   jmp  hackend

 .Reg:
   call [edx+0x13C]
   jmp  hackend

;;; Allow units to be selected when they are inside/on a building
hack 0x006FC073
   cmp byte[Ra2Mode], 0
   jz  .Reg

   mov eax, 0
   jmp hackend

 .Reg:
   call 0x0047C520
   jmp hackend


%if 0
;;; List of locations of mix and ini files
;; * means it's patched
*0000:00816280 0000000C C AUDIOMD.MIX
*0000:0081C24C 0000000C C THEMEMD.MIX
*0000:0081C284 0000000C C MULTIMD.MIX
*0000:0081C210 0000000E C MOVMD%02d.MIX
*0000:0081C2EC 0000000F C MAPSMD%02d.MIX
*0000:00826644 0000000C C LOCALMD.MIX
*0000:0082665C 0000000C C CACHEMD.MIX
*0000:0082667C 0000000A C RA2MD.MIX
*0000:0082668C 00000011 C EXPANDMD%02d.MIX
*0000:008267C0 0000000D C  CAMEOMD.MIX
*0000:00826804 0000000D C ISOGENMD.MIX
*0000:00826820 0000000C C GENERMD.MIX
*0000:00826838 0000000B C CONQMD.MIX
*0000:00827D58 00000009 C %sMD.MIX
*0000:00827DA0 0000000B C NTRLMD.MIX
*0000:00827E0C 00000010 C SIDEC%02dMD.MIX
*0000:008298C4 0000000B C LOADMD.MIX
*0000:00840D5C 0000000B C LANGMD.MIX
*0000:00825D94 0000000C C THEMEMD.INI
*0000:00825DF0 0000000A C EVAMD.INI
*0000:00825E50 0000000C C SOUNDMD.INI
*0000:00826198 0000000D C BATTLEMD.INI
*0000:0082621C 00000009 C AIMD.INI
*0000:00826254 0000000A C ARTMD.INI
**0000:00826260 0000000C C RULESMD.INI  //Crashes because MoveFlash=RING is not found
*0000:0082626C 0000000C C RULEMD*.INI
#0000:00826444 0000000A C RA2MD.INI
#0000:00827B88 0000000F C KEYBOARDMD.INI
*0000:00827DC8 00000009 C UIMD.INI
*0000:008295E8 00000009 C %sMD.INI
*0000:0082BDCC 0000000A C RMGMD.INI
*0000:00830370 0000000D C MAPSELMD.INI
*0000:00830A18 0000000E C MPModesMD.ini
*0000:00839724 0000000E C MISSIONMD.INI
*0000:00848BE4 0000000D C WDTMapMD.ini
*0000:00848E18 0000000D C WDTMAPMD.INIg
#0000:00849F8C 0000000E C wolinfoMD.ini
*0000:0084D864 00000010 C WDTChoiceMD.ini
%endif

;;; 0000:00816280 0000000C C AUDIOMD.MIX
hack 0x00406C93
    call 0x007C8E17

    cmp byte[Ra2Mode], 0
    jz  hackend

    jmp 0x00406CBC


;;; 0000:0081C24C 0000000C C THEMEMD.MIX
hack 0x00530C12
    cmp byte[Ra2Mode], 0
    jz  .Reg

    pop eax
    jmp 0x00530C77

 .Reg:
    call 0x004739F0
    jmp  hackend


;;; 0000:0081C24C 0000000C C THEMEMD.MIX
hack 0x00479526
    cmp byte[Ra2Mode], 0
    jz  .Reg

    pop eax
    jmp 0x0047959C

 .Reg:
    call 0x004739F0
    jmp  hackend



;;; 0000:0081C284 0000000C C MULTIMD.MIX
hack 0x0047949D
    cmp byte[Ra2Mode], 0
    jz  .Reg

    jmp 0x004794D3

 .Reg:
    call 0x007C8E17
    jmp  hackend


StringZ MultiMix, "MULTI.MIX"

;;; 0000:0081C284 0000000C C MULTIMD.MIX
hack 0x00530B7F
    cmp byte[Ra2Mode], 0
    jz  .Reg

    pop eax
    push 0x00886980
    push str_MultiMix
    jmp 0x00530BD2

 .Reg:
    call 0x004739F0
    jmp  hackend



;;; 0000:0081C210 0000000E C MOVMD%02d.MIX
hack 0x004795CD
    call 0x007207F0

    cmp byte[Ra2Mode], 0
    jz  hackend

    jmp 0x0047967F

;;; 0000:0081C210 0000000E C MOVMD%02d.MIX
hack 0x0053119A
    cmp byte[Ra2Mode], 0
    jz  .Reg

    pop eax
    jmp 0x005311E3

 .Reg:
    call 0x004739F0
    jmp  hackend



;;; 0000:0081C2EC 0000000F C MAPSMD%02d.MIX
hack 0x004793E7
    call 0x007C8EF4

    cmp byte[Ra2Mode], 0
    jz  hackend

    add esp, 20
    jmp 0x00479427

;;; 0000:0081C2EC 0000000F C MAPSMD%02d.MIX
hack 0x00530A50
    cmp byte[Ra2Mode], 0
    jz  .Reg

    pop eax
    jmp 0x00530AAE

 .Reg:
    call 0x004739F0
    jmp  hackend



;;; 0000:00826644 0000000C C LOCALMD.MIX
hack 0x005303CD
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push 0x00826638
    jmp  hackend

.Reg:
    push 0x00826644
    jmp  hackend

hack 0x005303F9
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push 0x00826644
    jmp  hackend

.Reg:
    push 0x00826638
    jmp  hackend

;;; Crashes 0x006A5A5B
;;; 0000:0082665C 0000000C C CACHEMD.MIX
hack 0x0053031F
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push 0x00826650
    jmp  hackend

 .Reg:
    push 0x0082665C
    jmp  hackend

hack 0x00530361
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push 0x0082665C
    jmp  hackend

 .Reg:
    push 0x00826650
    jmp  hackend

;;; 0000:0082667C 0000000A C RA2MD.MIX
hack 0x005302A3
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push 0x00826674
    jmp  hackend

 .Reg:
    push 0x0082667C
    jmp  hackend

hack 0x005302CB
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push 0x0082667C
    jmp  hackend

 .Reg:
    push 0x00826674
    jmp  hackend

;;; 0000:0082668C 00000011 C EXPANDMD%02d.MIX
hack 0x005301BA
    cmp byte[Ra2Mode], 0
    jz  .Reg

    jmp 0x00530290

 .Reg:
    mov edi, 97
    jmp hackend


;;; 0000:008267C0 0000000D C  CAMEOMD.MIX
hack 0x00530689
    cmp byte[Ra2Mode], 0
    jz  .Reg

    pop eax
    jmp 0x00530709

 .Reg:
    call 0x004739F0
    jmp  hackend


hack 0x005316C9, 0x005316CF
    cmp byte[Ra2Mode], 0
    jz  .Reg
    jmp hackend

 .Reg:
    cmp ecx, ebx
    jz  0x005318A7
    jmp hackend



;;; 0000:00826804 0000000D C ISOGENMD.MIX
hack 0x00530591
    call 0x007C8E17

    cmp byte[Ra2Mode], 0
    jz  hackend

    jmp 0x005305D2



;;; 0000:00826820 0000000C C GENERMD.MIX
hack 0x00530511
    call 0x007C8E17

    cmp byte[Ra2Mode], 0
    jz  hackend

    jmp 0x00530556


;;; 000:0082682C 0000000C C  CONQMD.MIX
hack 0x00530473
    cmp byte[Ra2Mode], 0
    jz  .Reg

    xor ebp, ebp
    pop eax
    jmp 0x005304FF

 .Reg:
    call 0x004739F0
    jmp  hackend

hack 0x00531691, 0x00531697
    cmp byte[Ra2Mode], 0
    jz  .Reg

    jmp 0x005316A5

 .Reg:
    cmp ecx, ebx
    jz  0x005318A7
    jmp hackend



;;; 0000:00827D58 00000009 C %sMD.MIX
%if 0                           ; Changing this breaks theaters
hack 0x00534A27
     cmp byte[Ra2Mode], 0
     jz  .Reg

     push 0x00827D64            ;%.MIX
     jmp  hackend
 .Reg:
     push 0x00827D58
     jmp  hackend

hack 0x00534A34
     cmp byte[Ra2Mode], 0
     jz  .Reg

     push 0x00827D64            ;%.MIX
     jmp  hackend
 .Reg:
     push 0x00827D58
     jmp  hackend
%endif


%if 0                          ; Soviet Score screen doesn't work right
;;; 0000:00827DA0 0000000B C NTRLMD.MIX
hack 0x00534F15
    call 0x007C8E17

    cmp byte[Ra2Mode], 0
    jz  hackend

    push dword[esp]
    jmp 0x00534F5A
%endif


;;; 0000:00827E0C 00000010 C SIDEC%02dMD.MIX
hack 0x005350E1
    call 0x007C8EF4

    cmp byte[Ra2Mode], 0
    jz  hackend

    add esp, 12
    jmp 0x00535179



;;; 0000:008298C4 0000000B C LOADMD.MIX
hack 0x00552CD6
    call 0x007C8E17

    cmp byte[Ra2Mode], 0
    jz  hackend

    add esp, 4
    jmp 0x00552D0C



;;; 0000:00840D5C 0000000B C LANGMD.MIX
hack 0x006BD7D7
    call 0x007C8E17

    cmp byte[Ra2Mode], 0
    jz  hackend

    jmp 0x006BD80C


StringZ Theme_INI, "THEME.INI"
;;; 0000:00825D94 0000000C C THEMEMD.INI
hack 0x0052C8B9
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_Theme_INI
    jmp  hackend

 .Reg:
    push 0x00825D94
    jmp  hackend



StringZ EVA_INI, "EVA.INI"
;;; 0000:00825DF0 0000000A C EVAMD.INI
hack 0x0052C7AF
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_EVA_INI
    jmp  hackend

 .Reg:
    push 0x00825DF0
    jmp  hackend



StringZ SOUND_INI, "SOUND.INI"
;;; 0000:00825E50 0000000C C SOUNDMD.INI
hack 0x0052C6DF
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_SOUND_INI
    jmp  hackend

 .Reg:
    push 0x00825E50
    jmp  hackend



StringZ BATTLE_INI, "BATTLE.INI"
;;; 0000:00826198 0000000D C BATTLEMD.INI
hack 0x0052CCCD
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_BATTLE_INI
    jmp  hackend

 .Reg:
    push 0x00826198
    jmp  hackend



StringZ ART_INI, "ART.INI"
;;; 0000:00826254 0000000A C ARTMD.INI
hack 0x0052D033
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_ART_INI
    jmp  hackend

 .Reg:
    push 0x00826254
    jmp  hackend

hack 0x00679EE0
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_ART_INI
    jmp  hackend

 .Reg:
    push 0x00826254
    jmp  hackend



StringZ AI_INI, "AI.INI"
;;; 0000:0082621C 00000009 C AIMD.INI
hack 0x0052D357
cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_AI_INI
    jmp  hackend

 .Reg:
    push 0x0082621C
    jmp  hackend


StringZ RULES_INI, "SPAWNER2.XDP"
;;; 0000:00826260 0000000C C RULESMD.INI
hack 0x0052CF41
    cmp byte[Ra2Mode], 0
    jz  .Reg

    pop eax
    push str_RULES_INI

 .Reg:
    call 0x004739F0
    jmp  hackend


StringZ RULE_INI, "RULE*.INI"
;;; 0000:0082626C 0000000C C RULEMD*.INI
hack 0x0052CD97
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_RULE_INI
    jmp hackend

 .Reg:
    push 0x0082626C
    jmp  hackend



StringZ UI_INI, "UI.INI"
;;; 0000:00827DC8 00000009 C UIMD.INI
hack 0x005352F8
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_UI_INI
    jmp  hackend

 .Reg:
    push 0x00827DC8
    jmp  hackend



StringZ MPMODES_INI, "MPMODES.INI"
;;; 0000:00830A18 0000000E C MPModesMD.ini
hack 0x005D759E
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_MPMODES_INI
    jmp  hackend

 .Reg:
    push 0x00830A18
    jmp  hackend



StringZ INI_FORMAT, "%s.INI"
;;; 0000:008295E8 00000009 C %sMD.INI
%if 0                           ; Changing this breaks theaters
hack 0x005454FE
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_INI_FORMAT
    jmp  hackend

 .Reg:
    push 0x008295E8
    jmp  hackend
%endif


StringZ RMG_INI, "RMG.INI"
;;; 0000:0082BDCC 0000000A C RMGMD.INI
hack 0x005981FC
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_RMG_INI
    jmp  hackend

 .Reg:
    push 0x0082BDCC
    jmp  hackend



StringZ MAPSEL_INI, "MAPSEL.INI"
;;; 0000:00830370 0000000D C MAPSELMD.INI
hack 0x005CEF62
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_MAPSEL_INI
    jmp  hackend

 .Reg:
    push 0x00830370
    jmp  hackend



StringZ MISSION_INI, "MISSION.INI"
;;; 0000:00839724 0000000E C MISSIONMD.INI
hack 0x00686D46
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_MISSION_INI
    jmp  hackend

 .Reg:
    push 0x00839724
    jmp  hackend



;;; gamemd.exe expects there to be 3 baseunits
hack 0x004F8EEE, 0x004F8EF4
    cmp byte[Ra2Mode], 0
    jz  .Reg

    jmp 0x004F8EFE

 .Reg:
    mov edx, [ecx+0xDF8]
    jmp hackend

;;; another place gamemd.exe expects there to be 3 baseunits
hack 0x004F8CEC, 0x004F8CF2
    cmp byte[Ra2Mode], 0
    jz  .Reg

    jmp 0x004F8DB1

 .Reg:
    mov ecx, [eax+0xDF8]
    jmp hackend


StringZ WDTMAP_INI, "WDTMap.ini"
;;; 0000:00848BE4 0000000D C WDTMapMD.ini
hack 0x00769575
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_WDTMAP_INI
    jmp  hackend

 .Reg:
    push 0x00848BE4
    jmp  hackend

hack 0x00769B2F
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_WDTMAP_INI
    jmp  hackend

 .Reg:
    push 0x00848BE4
    jmp  hackend



;;; 0000:00848E18 0000000D C WDTMAPMD.INI
hack 0x0076C45B
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_WDTMAP_INI
    jmp  hackend

 .Reg:
    push 0x00848E18
    jmp  hackend

hack 0x0078825F
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_WDTMAP_INI
    jmp  hackend

 .Reg:
    push 0x00848E18
    jmp  hackend



StringZ WDTCHOICE_INI, "WDTChoice.ini"
;;; 0000:0084D864 00000010 C WDTChoiceMD.ini
hack 0x007AFB03
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push str_WDTCHOICE_INI
    jmp  hackend

 .Reg:
    push 0x00848E18
    jmp  hackend





StringZ BUILDINGZ_SHP, "BUILDNGZ.SHP"
;;; BuildingZ.shp
hack 0x0045E8FF
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov  ecx, str_BUILDINGZ_SHP
    jmp  hackend

 .Reg:
    mov  ecx, 0x008193F4
    jmp  hackend

StringZ MOUSE_SHP, "MOUSE.SHP"
;;; Mouse.sha mouse.shp
hack 0x0052C34C
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov  ecx, str_MOUSE_SHP
    jmp  hackend

 .Reg:
    mov  ecx, 0x0082604C
    jmp  hackend

hack 0x00560D76
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov  ecx, str_MOUSE_SHP
    jmp  hackend

 .Reg:
    mov  ecx, 0x0082604C
    jmp  hackend

hack 0x0056108E
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov  ecx, str_MOUSE_SHP
    jmp  hackend

 .Reg:
    mov  ecx, 0x0082604C
    jmp  hackend

hack 0x005BDF3A
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov  ecx, str_MOUSE_SHP
    jmp  hackend

 .Reg:
    mov  ecx, 0x0082604C
    jmp  hackend

hack 0x006DAE02
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov  ecx, str_MOUSE_SHP
    jmp  hackend

 .Reg:
    mov  ecx, 0x0082604C
    jmp  hackend



;;; Unit health boxes are affected by pips.shp differences
;;; Fix = subtract 1 from the frame idx of pips.shp
hack 0x006F69F3, 0x006F69F9
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov eax, dword[esp+0x14]
    dec eax
    mov dword[esp+0x14], eax

 .Reg:
    mov eax, [esp+0x50]
    xor ebx, ebx
    jmp hackend

;;; Unit veterancy is affected by pips.shp differences
;;; ra2mode needs to subtract 1 from the frame in pips.shp
hack 0x0070A9E2
    cmp ebx, -1
    jz  0x0070AA54

    cmp byte[Ra2Mode], 0
    jz  hackend

    dec ebx
    jmp hackend

;;; Fix Ammo pips
hack 0x0070A3F0
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov dword[esp+4], 12        ; Use Frame Index 12 instead of 13

 .Reg:
    call 0x004AED70             ; CC_Draw_Shape
    jmp  hackend

;;; unloading pips2 crashes the game
@CLEAR 0x005F777B, 0x90, 0x005F777B

;;; Load screen palette loading
;;; use mpls.pal for everything
hack 0x0072B694, 0x0072B69A
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov ecx, [0x00844BC0]
    jmp hackend

 .Reg:
    mov ecx, dword[0x00844C0C]
    jmp hackend

hack 0x0072B6BB, 0x0072B6C1
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov ecx, [0x00844BC0]
    jmp hackend

 .Reg:
    mov ecx, dword[0x00844C1C]
    jmp hackend

hack 0x0072B6DE, 0x0072B6E4
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov ecx, [0x00844BC0]
    jmp hackend

 .Reg:
    mov ecx, dword[0x00844C10]
    jmp hackend

hack 0x0072B705, 0x0072B70B
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov ecx, [0x00844BC0]
    jmp hackend

 .Reg:
    mov ecx, dword[0x00844C14]
    jmp hackend

hack 0x0072B72C, 0x0072B732
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov ecx, [0x00844BC0]
    jmp hackend

 .Reg:
    mov ecx, dword[0x00844C28]
    jmp hackend

hack 0x0072B753, 0x0072B759
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov ecx, [0x00844BC0]
    jmp hackend

 .Reg:
    mov ecx, dword[0x00844C20]
    jmp hackend

hack 0x0072B77A, 0x0072B780
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov ecx, [0x00844BC0]
    jmp hackend

 .Reg:
    mov ecx, dword[0x00844C18]
    jmp hackend

hack 0x0072B7A1, 0x0072B7A7
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov ecx, [0x00844BC0]
    jmp hackend

 .Reg:
    mov ecx, dword[0x00844C2C]
    jmp hackend

hack 0x0072B7C8, 0x0072B7CE
    cmp byte[Ra2Mode], 0
    jz  .Reg

    mov ecx, [0x00844BC0]
    jmp hackend

 .Reg:
    mov ecx, dword[0x00844C24]
    jmp hackend



;;; Don't show minimap on load
hack 0x00553687
    cmp  byte[Ra2Mode], 0
    jz   .Reg

    add esp, 4
    jmp hackend

 .Reg:
    call 0x00640A40
    jmp  hackend


;;; Allow allies to repair on service depot
hack 0x00700594
    mov ebx, eax
    call [edx+0x38]             ;HouseClass::Get_ID
    cmp ebx, eax
    je  0x0070059D

    cmp byte[Ra2Mode], 0
    jz  0x007005E6

    mov  edx, [edi]
    mov  ecx, edi
    call [edx+0x2C]

    cmp  eax, 6                 ;BuildingClass
    jne  0x007005E6

    mov  ecx, [edi+0x21C]
    test ecx, ecx
    jz   0x007005E6

    mov eax, [esi+0x21C]
    push eax
    call 0x004F9A50

    test al, al
    jnz  0x0070059D

    jmp 0x007005E6


;;; Patch for bug at 0x004430EE
hack 0x004430DD
    call 0x00517A50

    cmp  eax, 0
    jz   0x0044328E

    jmp  hackend

hack 0x004430B6, 0x004430BC
    call [edx+0x30C]            ;Get_Crew

    test eax, eax
    jz   0x0044328E

    jmp  hackend
