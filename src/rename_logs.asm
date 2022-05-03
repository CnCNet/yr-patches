%include "macros/patch.inc"
%include "macros/datatypes.inc"

sstring str_except, "EXCEPT_CNCNET.TXT"
sstring str_sync1, "SYNC_CNCNET%01d.TXT"
sstring str_sync2, "SYNC_CNCNET%01d_%03d.TXT"

@SET 0x004C901C, {push str_except}
@SET 0x0064DEC4, {push str_sync1}
@SET 0x00651716, {push str_sync2}