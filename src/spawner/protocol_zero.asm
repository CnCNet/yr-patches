%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "Network.inc"
%include "session.inc"

hack 0x00647BEB, 0x00647BF4           ;Queue_AI_Multiplayer
    cmp byte[UseProtocolZero], 0
    jz  .Reg

    jmp hackend

.Reg:
    cmp esi, 5
    jl  0x00647F36
    jmp hackend

; Don't subtract 10 from MaxAhead
hack 0x004C800C,                       ;EventClass::Execute->TIMING
    mov eax,[0x00A8B230] ; Scenario

    cmp byte[UseProtocolZero], 0
    jz  hackend

    jmp 0x4C8024

; Don't set framesend rate to 10 in Generate_Process_Time_Event
hack 0x00647EB4, 0x00647EBE            ;Queue_AI_Multiplayer
    cmp byte[UseProtocolZero], 0
    jz  .Reg

    mov al, byte[NewFrameSendRate]
    mov ecx, [Frame]
    jmp hackend

.Reg:
    and al, 5
    mov ecx, [Frame]
    add al, 5
    jmp hackend

hack 0x00647DF7                 ;Queue_AI_Multiplayer
    cmp byte[UseProtocolZero], 0
    jz  .Reg

    mov edx, [MaxAhead]
    and edx, 0xffff

.Reg:
    cmp eax, 80h
    jmp hackend

; Don't throw "Packet received too late" when a null event or a RESPONSE_TIME2 packet arrives late
hack 0x0064C598, 0x0064C59E     ;Execute_DoList
    cmp byte[UseProtocolZero], 0
    jz  .Reg

    cmp dl, 0                   ;EVENTTYPE_EMPTY = 0,
    jz  0x0064C63D

    cmp dl, 47                  ;EVENTTYPE_RESPONSE_TIME2
    jz  0x0064C63D

    cmp dl, 33                  ;EVENTTYPE_PROCESS_TIME
    jz  0x0064C63D

.Reg:
    mov edx, [SessionType]
    jmp hackend


cextern Hack_Set_Timing
hack 0x00647E6B                 ;Queue_AI_Multiplayer
    mov ecx, ebx
    cmp byte[UseProtocolZero], 0
    jz  .Reg

    call Hack_Set_Timing
    jmp hackend

.Reg:
    call [edx+0x34]             ;Set_Timing
    jmp hackend

hack 0x0064771D                 ;Queue_AI_Multiplayer
    mov ecx, ebp
    cmp byte[UseProtocolZero], 0
    jz  .Reg

    call Hack_Set_Timing
    jmp hackend

 .Reg:
    call [edx+0x34]             ;Set_Timing
    jmp hackend

cextern Hack_Response_Time
hack 0x006476CB                 ;Queue_AI_Multiplayer
    mov ecx, ebp
    cmp byte[UseProtocolZero], 0
    jz  .Reg

    call Hack_Response_Time
    jmp hackend

 .Reg:
    call [eax+0x30]             ;Response_Time
    jmp  hackend

hack 0x00647CC5
    mov ecx, ebp
    cmp byte[UseProtocolZero], 0
    jz .Reg

    call Hack_Response_Time
    jmp hackend

 .Reg:
    call [edx+0x30]             ;Response_Time
    jmp  hackend
