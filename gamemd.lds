/* GNU ld linker script for gamemd.exe */

start = 0x7CD80F;

ENTRY(start);

SECTIONS
{
    .text      0x401000        : { gamemd.dat(.text) }
    .rdata     0x7E1000        : { gamemd.dat(.rdata) }
    .data      0x812000        : { gamemd.dat(.data); . = ALIGN(0x1000); }
    .bss       ALIGN(0x1000)   : { . = + 0x2FBBE4; }

    /DISCARD/                  : { gamemd.dat(.rsrc) }

    .idata       ALIGN(0x1000) : { *(.idata); }

    /DISCARD/                  : { *(.drectve); }

    .p_text    ALIGN(0x1000)   : { *(.text) }
    .p_rdata   ALIGN(0x1000)   : { *(.rdata) }
    .p_data    ALIGN(0x1000)   : { *(.data) }
    .p_bss     ALIGN(0x1000)   : { *(.bss) *(COMMON) }

    .rsrc      ALIGN(0x1000)   : { *(.rsrc) }

    .patch     ALIGN(0x1000)   : { *(.patch) }
    
    .eh_frame    ALIGN(0x1000) : { *(.eh_frame) }
}
