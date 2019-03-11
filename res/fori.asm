%macro fori 4
    movlo $0, $1
    $3_start:
        cmpi $0, $2
        brge $3_end
        $3
        addi $0, $0, 1
        jmp $3_start
    $3_end:
%end


fori r1, 0, 10, @id+
%macro @id 0
    add r2, r2, r1 
%end
