library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package data_file is
  
  constant data0 : data_chunk_array := (
--$DATA1
X"68",
X"6f",
X"72",
--$DATA1_END
others => X"00"
);
  constant data1 : data_chunk_array := (
--$DATA2
X"65",
X"20",
X"6c",
--$DATA2_END
others => X"00"
);

  constant data2 : data_chunk_array := (
--$DATA3
X"6c",
X"77",
X"64",
--$DATA3_END
others => X"00"
);

  constant data3 : data_chunk_array := (
--$DATA4
X"6c",
X"6f",
X"00",
--$DATA4_END
others => X"00"
);
  
end data_file;
