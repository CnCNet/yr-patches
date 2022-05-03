%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/string.inc"
%include "session.inc"

[section .rdata]
NoWolOKText: dw __utf16__('OK'),0
NoWOLWindowText: dw __utf16__("This version of Yuri\'s Revenge only supports online play using CnCNet 5 (www.cncnet.org)"),0
__SECT__

;hook at 0x0052E21E jmp to 0x0052E446

@HACK 0x0052E21E, Select_Game_Disable_Internet_Menu
    mov dword [SessionType], 0

    xor edx, edx

    push 0
    push 0
    push 0
    push NoWolOKText ; button text, needs to be 'ok'
    push NoWOLWindowText ; window message

    call 0x005D3490 ; show messsage
    jmp 0x0052E446
@ENDHACK
