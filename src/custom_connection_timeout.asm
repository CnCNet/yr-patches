%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"

cextern ConnTimeout

hack 0x006843C6
mov ecx, dword[ConnTimeout] ; original = 3600
jmp hackend
