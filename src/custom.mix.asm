%include "macros/patch.inc"
%include "macros/datatypes.inc"

gbool ClassicMode, false
cextern Ra2Mode

sstring themeMix, "theme.mix"
sstring ClassicModeMix, "ClassicMode.mix"

;Replaces EXPANDMD%02d.MIX with EXPANDSPAWN%02d.MIX so we can ship our own patches without
;interfering with the retail
sstring ExpandMix, "EXPANDSPAWN%02d.MIX"
sstring ExpandMixRa2, "EXPAND%02d.MIX"

hack 0x005301C4
    cmp edi, 99 ; load theme.mix instead of expandmd99.mix
    jz .ThemeMix

    cmp edi, 98 ; load ClassicMode.mix instead of expandmd98.mix
    jz .ClassicModeMix

    jmp .OriginalCode

.ThemeMix:
    push themeMix
    jmp hackend

.ClassicModeMix:
    cmp byte[ClassicMode], 1
    jnz .OriginalCode

    push ClassicModeMix
    jmp hackend

.OriginalCode:
    cmp byte[Ra2Mode], 0
    jz  .Reg

    push ExpandMixRa2
    jmp  hackend

 .Reg:
    push ExpandMix
    jmp hackend
