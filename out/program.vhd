library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package program_file is
  
  constant program : program_memory_array := (
--$PROGRAM
X"821e0008", -- load r1 r14 8 [2]
--$PROGRAM_END
others => X"00000000"
);

end program_file;
