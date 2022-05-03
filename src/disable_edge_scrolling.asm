%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

gbool DisableEdgeScrolling, false

;;; Maybe call DisplayClass::Scroll_Map to see which cursor to render
hack 0x00692DEB, 0x00692DF1
    cmp byte[DisableEdgeScrolling], 0
    jz  .Reg

    add esp, 12
    mov eax, 0                  ;no-scroll
    jmp hackend

 .Reg:
   call dword[edx+0xA4]
   jmp hackend


;;; Maybe call Render no-scroll cursor
hack 0x00692DFD
    mov ecx, edi

    cmp byte[DisableEdgeScrolling], 0
    jz  .Reg

    add esp, 8
    jmp hackend

 .Reg:
    call dword[edx+0x4C]        ;Render No-Scroll Cursor
    jmp hackend

;;; Maybe call DisplayClass::Scroll_Map to move the map
hack 0x00692E3A, 0x00692E40
    cmp byte[DisableEdgeScrolling], 0
    jz  .Reg

    add esp, 12
    mov eax, 0
    jmp hackend

 .Reg:
    call dword[edx+0xA4]
    jmp hackend
