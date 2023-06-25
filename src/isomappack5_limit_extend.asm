; Extend IsoMapPack5 decoding size limit
; (Large map support)

; When big sized maps with high details cross about 9750 + few lines in 
; IsoMapPack5 section, game doesn't decode those and fills those (typically
; bottom-left corner of the map) with height level 0 clear tiles.
; This patch raises the buffer usage limit to about 3 times the original.
; From 640 (0x280), 400 (0x190) and value of 512000 (= 640 * 400 * 2)
; To 1024 (0x400), 768 (0x300) and 1572864 (= 1024 * 768 * 2).

; Credits: E1 Elite

%include "macros/patch.inc"

@SET 0x004AD343, {push 0x00000300}
@SET 0x004AD348, {push 0x00000400}
@SET 0x004AD356, {push 0x00180000}

