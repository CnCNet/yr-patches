%include "macros/patch.inc"
%include "macros/datatypes.inc"
%include "macros/string.inc"

;;; Fix crash 6F9DB6
@CLEAR 0x005F58CB, 0x90, 0x005F58D2

;;; Fix crash at 727B48
hack 0x00727B3E, 0x00727B44
    mov  eax, [esi+0xA4]

    test eax, eax
    jz   0x00727B55

    jmp  hackend


;;; Fix crash at 4722F0
hack 0x0070F831

    test ecx, ecx
    jz   0x0070F837

    call 0x004722F0
    jmp  hackend

;; TODO fix 5d6c21 (Related to spectator)

;; Fix 6f49de
hack 0x006F49D2, 0x006F49D8
    mov eax, [esi+0x21C]

    test eax, eax
    jz   0x006F4A31

    jmp  hackend

;; Fix 70af6c
hack 0x0070AF66, 0x0070AF6C
    mov  eax, [esi+0x21C]

    test eax, eax
    jz   0x00070B1C7

    jmp  hackend


;; Fix 4c2c19 (let's see if this works)
@SJZ  0x004C2BDA, 0x004C2C0B
@SJNZ 0x004C2BE6, 0x004C2C0B
@SJZ  0x004C2BF0, 0x004C2C0B
@SJNZ 0x004C2BFA, 0x004C2C0B
hack 0x004C2C0B
    mov dword[edi+0x20], 0
    mov dword[edi+0x24], 0

    pop edi
    pop esi
    retn 8

;; Fix 65dc17
hack 0x0065DC17, 0x0065DC1D
    test ecx, ecx
    jnz  .Reg

    mov eax, 0
    jmp 0x0065DC2B

 .Reg:
    mov eax, [ecx+0x1E0]
    jmp hackend
