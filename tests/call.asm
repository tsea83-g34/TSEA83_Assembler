call MAIN
halt

MAIN:
    call MAIN2
    ret 

MAIN2:
    add r1, r1, r2 
    ret 