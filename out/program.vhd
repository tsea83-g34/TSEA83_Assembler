library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
--$PROGRAM
X"93123000", -- add r1 r2 r3
X"8b220001", -- addi r2 r2 1
--$PROGRAM_END
others => X"00000000"
);

end program_file;
