%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "Statistics.inc"
%include "session.inc"
%include "Message.inc"
%include "c.inc"

;///////////////////////////////////////////////////////////////////////////////
;// External Dependencys
;///////////////////////////////////////////////////////////////////////////////
cextern SpawnerActive
cextern CCFileClass__CCFileClass
cextern CCFileClass__Write
cextern CCFileClass__Close
cextern CCFileClass__Open
cextern RawFileClass__Delete
cextern NetKey
cextern StartNetKey

;///////////////////////////////////////////////////////////////////////////////
;//
;///////////////////////////////////////////////////////////////////////////////
section .rdata
str_MyIdField db "MYID",0
str_AccountNameField db "ACCN",0
str_stats_dmp: db "stats.dmp",0
str_HASH db "HASH",0
str_NKEY db "NKEY",0
str_SKEY db "SKEY",0

section .data
str_ALY db "ALYx",0
alyID equ str_ALY+3

str_BSP db "BSPx",0
bspID equ str_BSP+3

cextern MapHash
cextern UIMapName

section .text

; Save the GSKU
@SET 0x006C7053, { mov esi, dword[GameStockKeepingUnit] }

;///////////////////////////////////////////////////////////////////////////////
;// Send_Statistics_Packet()
;//
;//  CCHyper 24/01/2016 - COMPLETE.
;///////////////////////////////////////////////////////////////////////////////
@LJMP 0x006C856C, _Send_Statistics_Packet_Write_Statistics_Dump
_Send_Statistics_Packet_Write_Statistics_Dump:
	cmp dword [SpawnerActive], 0
	jz .Normal_Code

	cmp dword [SessionType], 4	;INTERNET
	jz .Normal_Code

        push DWORD [0x00B0BD90]         ;Length of stats packet
        push esi
	call Write_Stats_File

	mov dword [StatisticsPacketSent], 1
	jmp 0x006C87B8

.Normal_Code:        ;//////////////////////////////////////////////////////////
	mov eax, 0x00AC1170
	jmp 0x006C8571


;///////////////////////////////////////////////////////////////////////////////
;// ()
;//  void __stdcall Write_Stats_file(char *buf, int32_t len)
;//  CCHyper 24/01/2016 - COMPLETE.
;///////////////////////////////////////////////////////////////////////////////
Write_Stats_File:
	push ebp
	mov ebp, esp

%define stats_buf     EBP+4+4
%define stats_length  EBP+4+4+4
%define stats_file    EBP-256
	sub esp,256

        ;lea ecx, [stats_file]
        ;call RawFileClass__Delete

	lea ecx, [stats_file]
	push str_stats_dmp
	call CCFileClass__CCFileClass

	push 2
	lea ecx, [stats_file]
	call CCFileClass__Open
	test eax, eax
	je .exit

	mov ebx, [stats_length]
	push ebx
	mov edx,[stats_buf]
	push edx

	lea ecx, [stats_file]
	call CCFileClass__Write

	lea ecx, [stats_file]
	call CCFileClass__Close

.exit:               ;//////////////////////////////////////////////////////////
	mov eax, 1

	mov esp,ebp
	pop ebp
	retn 8

;///////////////////////////////////////////////////////////////////////////////
;// New fields MYID, NKEY, SKEY
;//
;///////////////////////////////////////////////////////////////////////////////
@LJMP 0x006C7927, AddMyIdField
AddMyIdField:
        pop eax

	mov eax, dword[PlayerPtr]
	cmp eax, esi
	jnz .out

	push 0x10
	call new ; OperatorNew
	add esp, 4
	test eax, eax
	jz .fail

	xor ecx, ecx
	mov cl, bl
	sub cl, '0'
	push ecx
	push str_MyIdField
	mov ecx, eax
	call 0x004CB700 ; FieldClass::FieldClass
	jmp .noFail

.fail:
	xor eax, eax

.noFail:
	push eax
	lea ecx, [esp+0x14]
	call 0x00625AE0 ;PacketClass__Add_Field

.nkey:
        mov edi, [NetKey]
        push 0x10
        call new

        add  esp, 4
        test eax, eax
        jz  .fail_nkey

        push edi
        push str_NKEY
        mov  ecx, eax
        call 0x004CB760             ;FieldClass::FieldClass(char *, DWORD)

        jmp  .noFail_nkey

.fail_nkey:
        xor eax, eax

.noFail_nkey:
        push eax
        lea  ecx, [esp+0x14]
        call 0x00625AE0

.skey:
        mov edi, [StartNetKey]
        push 0x10
        call new

        add  esp, 4
        test eax, eax
        jz  .fail_skey

        push edi
        push str_SKEY
        mov  ecx, eax
        call 0x004CB760             ;FieldClass::FieldClass(char *, DWORD)

        jmp  .noFail_skey

.fail_skey:
        xor eax, eax

.noFail_skey:
        push eax
        lea  ecx, [esp+0x14]
        call 0x00625AE0

.out:
	push 0x10
        call new
	jmp 0x0006C792C

;///////////////////////////////////////////////////////////////////////////////
;// Adds ALY field
;// Adds BSP field
;//
;///////////////////////////////////////////////////////////////////////////////
hack 0x006C7984
        call 0x00625AE0             ;PacketClass::Add_Field

        mov  cl, byte[0x00841F43]
        mov  byte[alyID], cl
        mov  byte[bspID], cl

        push 0x10
        call new
        add  esp,4
        test eax, eax
        jz   hackend

        mov  edi, [esi+0x5788]      ;HouseClass::AllyBitfield
        push edi
        push str_ALY
        mov  ecx, eax
        call 0x004CB760             ;FieldClass::FieldClass(char *, DWORD)

        push eax
        lea  ecx, [esp+0x14]        ;pPacket
        call 0x00625AE0             ;PacketClass::Add_Field

        push 0x10
        call new
        add  esp,4
        test eax, eax
        jz   hackend

        mov  edi, [esi+0x5490]      ;HouseClass::BaseSpawnCell
        push edi
        push str_BSP
        mov  ecx, eax
        call 0x004CB760             ;FieldClass::FieldClass(char *, DWORD)

        push eax
        lea  ecx, [esp+0x14]        ;pPacket
        call 0x00625AE0             ;PacketClass::Add_Field

        jmp  hackend


;///////////////////////////////////////////////////////////////////////////////
;// ()
;//  This doesn't work but it also isn't even needed in YR
;///////////////////////////////////////////////////////////////////////////////
;@LJMP 0x006097FD, AddACCNField
AddACCNField:
	call 0x00625AE0

	push 0x10
	call 0x007C8E17 ; OperatorNew
	add esp, 4
	cmp eax, edi
	je .fail
	mov ecx, dword[PlayerPtr]
	lea ecx, [ecx+0x10DE4] ; 0x10DE4 = HouseClass.PlayerName
	push ecx
	push str_AccountNameField
	mov ecx, eax
	call 0x004CB7C0 ; FieldClass__FieldClass_String
	jmp .noFail

.fail:
	xor eax, eax

.noFail:
	push eax
	lea ecx, [esp+0x18]
	call 0x00625AE0 ;PacketClass__Add_Field
	jmp 0x006C7350



;///////////////////////////////////////////////////////////////////////////////
;// ()
;//
;///////////////////////////////////////////////////////////////////////////////
UseUIMapNameInsteadFilename:
@SET 0x006C735E, { push UIMapName }

hack 0x006C7378
IncludeMapHash:
        call 0x00625AE0

        push 0x10
        call 0x007C8E17 ; OperatorNew
	add  esp, 4
        cmp  eax, ebp
        je  .fail

        push MapHash
        push str_HASH
        mov  ecx, eax
        call 0x004CB7C0 ; FieldClass__FieldClass_String
        jmp .noFail

 .fail:
        xor  eax, eax

 .noFail:
        push eax
        lea  ecx, [esp+0x14]
        call 0x00625AE0 ;PacketClass__Add_Field

	jmp  hackend

;///////////////////////////////////////////////////////////////////////////////
;// Execute_DoList()
;//
;///////////////////////////////////////////////////////////////////////////////
@LJMP 0x0064C81E, _Execute_DoList_Send_Statistics_Game_Leave2
_Execute_DoList_Send_Statistics_Game_Leave2:
	mov edx, [SessionType]

	cmp dword [SpawnerActive], 0
	jz .Normal_Code

	cmp dword [SessionType], 0	;CAMPAIGN
	jz .Normal_Code

	jmp .Send

.Send:
	jmp 0x0064C826

.Dont_Send:
	jmp 0x0064C862

.Normal_Code:
	mov edx, [SessionType]
	cmp edx, 4	;INTERNET
	jnz .Dont_Send

	jmp .Send


;///////////////////////////////////////////////////////////////////////////////
;// Execute_DoList()
;//
;///////////////////////////////////////////////////////////////////////////////
@LJMP 0x0064C7FA, _Execute_DoList_Send_Statistics_Game_Leave
_Execute_DoList_Send_Statistics_Game_Leave:
	mov edx, [SessionType]

	cmp dword [SpawnerActive], 0
	jz .Normal_Code

	cmp dword [SessionType], 0	;CAMPAIGN
	jz .Normal_Code

	jmp 0x0064C802

.Dont_Send:
	jmp 0x0064C862

.Normal_Code:
	mov edx, [SessionType]
	cmp edx, 4	;INTERNET
	jnz .Dont_Send
	jmp 0x0064C802


;///////////////////////////////////////////////////////////////////////////////
;// Main_Loop()
;//
;///////////////////////////////////////////////////////////////////////////////
@LJMP 0x0055D189, _Main_Loop_Send_Statistics_Spawner2
_Main_Loop_Send_Statistics_Spawner2:
	cmp dword [SpawnerActive], 0
	jz .Normal_Code

	cmp dword [SessionType], 0	;CAMPAIGN
	jz .Normal_Code

	jmp .Send

.Send:
	jmp 0x0055D18E

.Dont_Send:
	jmp 0x0055D1B1

.Normal_Code:
	cmp dword [SessionType], 4	;INTERNET
	jnz .Dont_Send

	jmp .Send


;///////////////////////////////////////////////////////////////////////////////
;// Main_Loop()
;//
;///////////////////////////////////////////////////////////////////////////////
@LJMP 0x0055D0FB, _Main_Loop_Send_Statistics_Spawner1
_Main_Loop_Send_Statistics_Spawner1:
	cmp dword [SpawnerActive], 0
	jz .Normal_Code

	cmp dword [SessionType], 0	;CAMPAIGN
	jz .Normal_Code

	jmp .Send

.Send:
	jmp 0x0055D100

.Dont_Send:
	jmp 0x0055D123

.Normal_Code:
	cmp dword [SessionType], 4	;INTERNET
	jnz .Dont_Send

	jmp .Send

;///////////////////////////////////////////////////////////////////////////////
;// Queue_AI_Multiplayer()
;//
;///////////////////////////////////////////////////////////////////////////////
@LJMP 0x0064827D, _Queue_AI_Multiplayer_Send_Statistics_Spawner
_Queue_AI_Multiplayer_Send_Statistics_Spawner:
	cmp dword [SpawnerActive], 0
	jz .Normal_Code

	cmp dword [SessionType], 0	;CAMPAIGN
	jz .Normal_Code

	jmp .Send

.Send:
	jmp 0x00648285

.Dont_Send:
	jmp 0x00648310

.Normal_Code:
	cmp dword [SessionType], 4	;INTERNET
	jnz .Dont_Send

	jmp .Send

;///////////////////////////////////////////////////////////////////////////////
;// Kick_Player_Now()
;//
;//  CCHyper 24/01/2016 - COMPLETE.
;///////////////////////////////////////////////////////////////////////////////
@LJMP 0x0064B2E4, _Kick_Player_Now_Send_Statistics_Spawner
_Kick_Player_Now_Send_Statistics_Spawner:
	cmp dword [SpawnerActive], 0
	jz .Normal_Code

	cmp dword [SessionType], 0	;CAMPAIGN
	jz .Normal_Code

	jmp .Send

.Send:
	jmp 0x0064B2ED

.Dont_Send:
	jmp 0x0064B352

.Normal_Code:
	cmp dword [SessionType], 4	;INTERNET
	jnz .Dont_Send

	jmp .Send

;///////////////////////////////////////////////////////////////////////////////
;// Correct Duration
;//
;///////////////////////////////////////////////////////////////////////////////
hack 0x006C882A, 0x006C8830
_Regester_Game_End_Time_Hack:
    mov ecx, [0x00A8B230]       ; Scenario
    mov ecx, [ecx+0x614]        ; Scenario.elapsedTime
    jmp hackend

;///////////////////////////////////////////////////////////////////////////////
;// Correct Tournament game kicking
;//
;///////////////////////////////////////////////////////////////////////////////
@SET 0x0064AB6A, { cmp dword[SessionType], 3 }
@SET 0x00448524, { cmp dword[SessionType], 3 }

;///////////////////////////////////////////////////////////////////////////////
;// Correct other system not responding.
;//
;///////////////////////////////////////////////////////////////////////////////
@SET 0x00647AE8, { cmp dword[SessionType], 3 }
@SET 0x0064824B, { mov esi, 3 }
