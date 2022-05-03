%include "macros/extern.inc"

; C(++) standard library
cextern strstr
cextern stristr
cextern strcmpi
cextern strtok

cextern sprintf

cextern new
cextern calloc
cextern memcpy
cextern memset

%macro strcmp_i 2
    push    %1             ; Str2
    push    %2             ; Str1
    call    strcmpi
    add     esp, 8
%endmacro
