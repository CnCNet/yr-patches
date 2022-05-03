%include "macros/extern.inc"

; easier way to define null terminated string
%macro StringZ 2
    [section .rdata]
    cglobal str_%1
    str_%1 db %2,0
    __SECT__
%endmacro

%macro String16 2
    [section .rdata]
    cglobal str16_%1
    str16_%1 dw __utf16__(%2),0
    __SECT__
%endmacro
