%include "macros/patch.inc"
%include "macros/hack.inc"
%include "macros/datatypes.inc"
%include "session.inc"

; Hide FPS/Gamespeed Slider from in-game menu based on spawn.ini setting
; =====================================================================
; This patch allows control over the FPS/gamespeed slider visibility in the pause/in-game menu
;
; Usage:
; Add the following line to the [Settings] section of spawn.ini:
; HideFPSSlider=yes     ; Hide the FPS/gamespeed slider from in-game menu
; HideFPSSlider=no      ; Show the FPS/gamespeed slider (default)
;
; When HideFPSSlider=yes, the slider will be hidden from the pause menu during gameplay.
; This is useful for tournament play or when you want to prevent players from adjusting
; the game speed during matches.
;
; Note: This patch works in conjunction with the spectators.asm patch and should be
; applied after it in the build order.

cextern HideFPSSlider

; Override the existing gamespeed slider logic to also check our HideFPSSlider setting
; We patch at a point after the spectators check but before slider display
@HACK 0x004E20C0, _Hide_FPS_Slider_InGame_Menu_Override
    ; First check our HideFPSSlider setting
    cmp byte[HideFPSSlider], 1
    jz .HideSlider

    ; If not hiding, continue with normal execution (including spectator logic)
    ; This is the instruction that would normally execute after the spectators patch
    mov eax, dword [0x00A8B538]
    test eax, eax
    jmp 0x004E20C5

.HideSlider:
    ; Hide the slider by jumping past the display code
    jmp 0x004E211A
@ENDHACK
