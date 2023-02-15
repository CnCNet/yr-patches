%include "macros/patch.inc"
%include "macros/hack.inc"

%include "House.inc"
%include "session.inc"

; Allow observers to always see cloaked objects
; Skip IsCampaign check (confirmed being useless from Mental Omega mappers)
; Ported from Phobos
; https://github.com/Phobos-developers/Phobos/blob/525d8bba72b66fc43e2509b3fa3fa9064731409d/src/Ext/Techno/Hooks.cpp#L617
; Also making them visible to detached allies
@HACK 0x00703A09, _TechnoClass_VisualCharacter_CloakVisibility
	mov edx, [PlayerPtr]
	cmp [PlayerPtr2_Observer], edx
	jz  0x00703A5A           ; UseShadowyVisual
	jmp 0x00703A16           ; CheckMutualAlliance ( Really detached allies )
@ENDHACK
@LJMP 0x00703A32, 0x00703A46 ; Replace check mutual allies by detached

@HACK 0x0045455B, _BuildingClass_VisualCharacter_CloakVisibility
	mov edx, [PlayerPtr]
	cmp [PlayerPtr2_Observer], edx
	jz  0x0045452D           ; UseShadowyVisual
	jmp 0x00454564           ; CheckMutualAlliance ( Really detached allies )
@ENDHACK
@LJMP 0x00454578, 0x00454588 ; Replace check mutual allies by detached

; Allow observers and detached allies coordthing cloaked Technos
@HACK 0x00692540, _ScrollClass_Coordthing_TechnoClass_Cloak
	mov edx, [PlayerPtr]
	cmp [PlayerPtr2_Observer], edx
	jz  .AllowCoordthing

	mov  eax, [edx+0x30]     ; PlayerPtr->ID
	push eax
	mov  ecx, [esi+21Ch]     ; pTechno->House
	call 0x004F9A10          ; bool __thiscall HouseClass::Is_Ally(HouseClass *this, int HouseID)
	test eax, eax
	jnz  .AllowCoordthing

.Check_SensedByHouses:
	mov eax, [PlayerPtr]
	jmp 0x00692545

.AllowCoordthing:
	jmp 0x0069256B
@ENDHACK

; Allow observers and detached allies coordthing cloaked Buildings
@HACK 0x006925AA, _ScrollClass_Coordthing_BuildingClass_Cloak
	mov edx, [PlayerPtr]
	cmp [PlayerPtr2_Observer], edx
	jz  .AllowCoordthing

	mov  eax, [edx+0x30]     ; PlayerPtr->ID
	push eax
	mov  ecx, [esi+21Ch]     ; pTechno->House
	call 0x004F9A10          ; bool __thiscall HouseClass::Is_Ally(HouseClass *this, int HouseID)
	test eax, eax
	jnz  .AllowCoordthing

.Check_SensedByHouses:
	mov ecx, [PlayerPtr]
	jmp 0x006925B0

.AllowCoordthing:
	jmp 0x006925F0
@ENDHACK

@HACK 0x006DA412, _Tactical_Select_At
	push eax
	mov eax, [PlayerPtr]
	cmp [PlayerPtr2_Observer], eax
	jz  .CanSelect

	mov  ecx, [eax+0x30]     ; PlayerPtr->ID
	push ecx
	mov  ecx, [eax+21Ch]     ; pTechno->House
	call 0x004F9A10          ; bool __thiscall HouseClass::Is_Ally(HouseClass *this, int HouseID)
	test eax, eax
	jnz  .CanSelect

.Check_SensedByHouses:
	pop eax
	mov ecx, [PlayerPtr]
	jmp 0x006DA418

.CanSelect:
    pop eax
	jmp 0x006DA43E
@ENDHACK

; Allow observers and detached allies selected cloaked Technos
@HACK 0x006F4F10, _TechnoClass_6F4EB0_Cloak
	; vanilla check
	mov  eax, [PlayerPtr]
	test eax, eax
	jz   .Dont_Unselect

	; vanilla check
	mov  ecx, [esi+21Ch]     ; pTechno->House
	cmp  ecx, eax
	jz   .Dont_Unselect

	cmp  [PlayerPtr2_Observer], eax
	jz   .Dont_Unselect

	mov  eax, [eax+0x30]     ; PlayerPtr->ID
	push eax
	call 0x004F9A10          ; bool __thiscall HouseClass::Is_Ally(HouseClass *this, int HouseID)
	test eax, eax
	jnz  .Dont_Unselect

.Check_SensedByHouses:
	mov  eax, [PlayerPtr]
	jmp 0x006F4F21

.Dont_Unselect:
	jmp 0x006F4F3A
@ENDHACK

; Allow observers and detached allies selected cloaked Buildings
@HACK 0x004ABE3C, _DisplayClass_Mouse_Left_Release_Cloak
	mov  eax, [PlayerPtr]
	cmp  [PlayerPtr2_Observer], eax
	jz   .Select

	mov  eax, [eax+0x30]     ; PlayerPtr->ID
	push eax
	mov  ecx, [esi+21Ch]     ; pTechno->House
	call 0x004F9A10          ; bool __thiscall HouseClass::Is_Ally(HouseClass *this, int HouseID)
	test eax, eax
	jnz  .Select

.Check_SensedByHouses:
	mov  eax, [esi]
	mov  ecx, esi
	call [eax+328h]          ; TechnoClass::Player_Sensed_on_cell on 0x70D420
	jmp 0x004ABE46

.Select:
	jmp 0x004ABE4A
@ENDHACK

; Show cloaked Technos on radar for observers and detached allies
@HACK 0x0070D386, _TechnoClass_Radar_Cloak
	mov  eax, [PlayerPtr]
	cmp  [PlayerPtr2_Observer], eax
	jz   .Show

	mov  eax, [eax+0x30]     ; PlayerPtr->ID
	push eax
	mov  ecx, [esi+21Ch]     ; pTechno->House
	call 0x004F9A10          ; bool __thiscall HouseClass::Is_Ally(HouseClass *this, int HouseID)
	test eax, eax
	jnz  .Show

.Check_SensedByHouses:
	mov  edx, [esi]
	mov  ecx, esi
	call [edx+328h]          ; TechnoClass::Player_Sensed_on_cell on 0x70D420
	jmp 0x0070D390

.Show:
	jmp 0x0070D3CD
@ENDHACK

; Show cloaked Buildings on radar for observers and detached allies
@HACK 0x00457188, _BuildingClass_Radar_Cloak
	mov  eax, [PlayerPtr]
	cmp  [PlayerPtr2_Observer], eax
	jz   .Show

	mov  eax, [eax+0x30]     ; PlayerPtr->ID
	push eax
	mov  ecx, [edi+21Ch]     ; pTechno->House
	call 0x004F9A10          ; bool __thiscall HouseClass::Is_Ally(HouseClass *this, int HouseID)
	test eax, eax
	jnz  .Show

.Check_SensedByHouses:
	mov  eax, [edi]
	mov  ecx, edi
	call [eax+328h]          ; TechnoClass::Player_Sensed_on_cell on 0x70D420
	jmp 0x00457192

.Show:
	jmp 0x004571C4
@ENDHACK

; Show tooltips for observers and detached allies
@HACK 0x004AE62B, _DisplayClass_HelpText_Cloak
	mov edx, ecx

	mov  eax, [PlayerPtr]
	cmp  [PlayerPtr2_Observer], eax
	jz   .Check_IsInvisible

	mov  eax, [eax+0x30]     ; PlayerPtr->ID
	push eax
	mov  ecx, [ecx+21Ch]     ; pTechno->House
	call 0x004F9A10          ; bool __thiscall HouseClass::Is_Ally(HouseClass *this, int HouseID)
	test eax, eax
	jnz  .Check_IsInvisible

.Normal_Code:
	mov ecx, edx
	mov  eax, [PlayerPtr]
	jmp 0x004AE630

.Check_IsInvisible:
	jmp 0x004AE654
@ENDHACK

; ====
; Show disguised units (Spy and Mirage) for observer
; ====

; Show Spy for observer
@HACK 0x004DEDC3, _FootClass_Get_Image_Data_Desguise
	mov  ecx, [PlayerPtr]
	cmp  [PlayerPtr2_Observer], ecx
	jz   .Check_DisguiseBeenSeen

.Normal_Code:
	jmp 0x004DEDC9

.Check_DisguiseBeenSeen:
	jmp 0x004DEE15
@ENDHACK

; Show name of Spy for observer
@HACK 0x0051F2F3, _InfantryClass_FullName
	mov  ecx, [PlayerPtr]
	cmp  [PlayerPtr2_Observer], ecx
	jz  .Return_FullName

.Normal_Code:
	jmp  0x0051F2F9

.Return_FullName:
	jmp  0x0051F31A
@ENDHACK

; Allow observers selected mirage
@HACK 0x007467CA, _UnitClass_Cant_Target_Desguise
	mov  ecx, [PlayerPtr]
	cmp  [PlayerPtr2_Observer], ecx
	jz  0x007467FE

.Normal_Code:
	mov  eax, [edi+30h]
	mov  ecx, ebx
	jmp 0x007467CF
@ENDHACK

; Flash disguise for Observer
@HACK 0x0070EE6A, _TechnoClass_Disguise_Been_Seen
	mov  ecx, [PlayerPtr]
	cmp  [PlayerPtr2_Observer], ecx
	jz  0x0070EE79

.Normal_Code:
	mov ecx, [esi+21Ch]
	jmp 0x0070EE70
@ENDHACK
