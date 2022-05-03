%include "macros/patch.inc"
%include "macros/datatypes.inc"

;;; This hack doesn't work. It doesn't move the players' score
;;; table to the correct location at the score screen
cextern ScreenWidth
cextern ScreenHeight
cextern LoadScreenWidth
cextern LoadScreenHeight
cextern SkipScoreScreen

;;; Load Screen
hack 0x006BC13C, 0x006BC141
    mov [ScreenHeight], eax

    cmp dword[ScreenHeight], 600
    jl  hackend

    mov [LoadScreenHeight], eax
    mov eax, [ScreenWidth]

    mov [LoadScreenWidth], eax
    jmp hackend


;;; Spawn Preview
hack 0X00640D07, 0x00640D36
    cmp dword[LoadScreenWidth], 800
    jle .Reg

    mov ecx, [LoadScreenHeight]
    sub ecx, 600
    shr ecx, 1
    add ecx, 379 ;Indent_from_Top

    mov eax, [LoadScreenWidth]
    sub eax, 800
    shr eax, 1
    add eax, 499 ;Indent_from_Left

    mov edx, 216 ;Minimap_Width
    mov esi, 166 ;Minimap_Height
    jmp hackend

 .Reg: ;original fallback values
    mov edx, 200
    mov eax, 385
    mov ecx, 270
    mov esi, edx
    jmp hackend


;;; Score Screen
hack 0x0060C43B, 0x0060C443
    cmp  dword[ScreenHeight], 600
    jl   .Reg

    mov  ecx, 2
    xor  edx, edx
    mov  eax, 600
    sub  eax, [LoadScreenHeight]
    cdq
    idiv ecx
    mov [esp+0x38], eax

    xor  edx, edx
    mov  eax, 800
    sub  eax, [LoadScreenWidth]
    cdq
    idiv ecx
    mov  [esp+0x34], eax

    mov dword[esp+0x3C], 640
    mov dword[esp+0x40], 480
    jmp hackend

 .Reg:
    lea  ecx, [esp+0x34]
    push ecx
    push eax
    call edi
    jmp  hackend

@SET 0x0072ECA4, { cmp esi, 600 }

;;; This will force the game to always use ddraw's blit function rather than WW blit.
;;; We're avoiding ww blit functions because they are not thread safe
@SET 0x004BB1FA, { mov byte[esp+19], 0 }
