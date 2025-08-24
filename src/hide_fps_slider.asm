%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"
%include "session.inc"

; Hide FPS/Gamespeed Slider from in-game menu based on spawn.ini setting
; This patch allows control over the FPS/gamespeed slider visibility in the pause/in-game menu
;
; Note: This patch replaces the spectators.asm patch logic for the FPS slider

cextern HideFPSSlider

; This replaces the spectators.asm patch at 0x004E20BA
@HACK 0x004E20BA, _Hide_FPS_Slider_InGame_Menu_Override
    ; First check if HideFPSSlider is enabled
    cmp byte[HideFPSSlider], 1
    jz .HideSlider

    ; Then check for spectator mode (original spectators.asm logic)
    cmp dword [SessionType], 5
    jnz .ShowSlider

    cmp dword [ObserverMode], 1
    jnz .ShowSlider

.HideSlider:
    ; Hide the slider (jump to the code that skips slider creation)
    jmp 0x004E211A

.ShowSlider:
    ; Show the slider (normal code path)
    mov eax, dword [0x00A8B538]
    jmp 0x004E20BF
@ENDHACK