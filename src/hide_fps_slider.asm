%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"
%include "session.inc"

; Hide FPS/Gamespeed Slider from in-game menu based on spawn.ini setting
; This patch allows control over the FPS/gamespeed slider visibility in the pause/in-game menu
;
; Note: This patch works in conjunction with the spectators.asm patch and should be
; applied after it in the build order.

cextern HideFPSSlider

@HACK 0x004E20C0, _Hide_FPS_Slider_InGame_Menu_Override
    cmp byte[HideFPSSlider], 1
    jz .HideSlider

    mov eax, dword [0x00A8B538]
    test eax, eax
    jmp 0x004E20C5

.HideSlider:
    jmp 0x004E211A
@ENDHACK