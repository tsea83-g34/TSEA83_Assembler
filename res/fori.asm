%macro fori 4
    movlo $0, $1
    $3_start:
        cmpi $0, $2
        brge $end
        $3
        addi $0, $0, 1
        jmp $start
    $3_end:
%end


fori r1, 0, 10, @id+
%macro @id 0
    addi r2, r2, r1 
%end

# lambda finds the earliest next line with a macro.
# but macros don't have line indexes??
# maybe have a sign for replace with unique index?

# Solution: '@' constitutes internal