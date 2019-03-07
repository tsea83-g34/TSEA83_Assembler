%macro inc 1
    addi $0, $0, 1
%end

%macro inc_mem 2
    load $0, $1
    inc $0
    store $0, $1
%end 

addi r1, r1, 1
inc r1
inc r2
inc r3
inc_mem r1, r4 