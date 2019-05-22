.dw 0x09abcdef
.dh 0x09ab
.db 0xcd    ; Data 3
.data HALF
.dh 0xeffe  ; Data 2, 1
.data WORD
.dw 0x12345678  ; Data 2, 1

load[2] r1, r14, HALF ; Should be value 8
load[2] r1, r14, WORD ; Should be value 12