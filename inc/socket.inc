%include "macros/extern.inc"

cextern sendto
cextern recvfrom
cextern htonl
cextern htons

struc sockaddr_in
    .sin_family     RESW 1
    .sin_port       RESW 1
    .sin_addr       RESD 1
    .sin_zero       RESB 8
endstruc

struc ListAddress
    .port:      RESD 1
    .ip:        RESD 1
endstruc

struc NetAddress
    .port:      RESD 1
    .ip:        RESD 1
    .zero:      RESW 1
endstruc

struc SpawnAddress
    .pad1:      RESD 1
    .id:        RESD 1
    .pad2:      RESW 1
endstruc
