.ds "hello"

.db 0xff
.dh 0xaaaa; half word 16 bits

.data VARIABLES
.dw 0x1234fedc ; 32 bits 
.db 20: 0xfd
load r1, r0, VARIABLES 