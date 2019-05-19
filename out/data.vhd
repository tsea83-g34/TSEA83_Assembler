library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library work;
use work.PIPECPU_STD.ALL;

package data_file is
  
  constant data0 : data_chunk_array := (
--$DATA1
X"67",
X"ff",
--$DATA1_END
others => X"00"
);
  constant data1 : data_chunk_array := (
--$DATA2
X"0a",
X"ff",
--$DATA2_END
others => X"00"
);

  constant data2 : data_chunk_array := (
--$DATA3
X"67",
--$DATA3_END
others => X"00"
);

  constant data3 : data_chunk_array := (
--$DATA4
X"00",
--$DATA4_END
others => X"00"
);
  
end data_file;
