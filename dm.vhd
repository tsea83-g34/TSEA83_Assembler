library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- dMem interface
entity dMem is
  port(
    dAddr : in unsigned(31 downto 0);
    dData : out unsigned(31 downto 0));
end dMem;

architecture Behavioral of dMem is

-- Data Memory
type d_mem_t is array (0 to 255) of unsigned(31 downto 0);
constant p_mem_c : p_mem_t :=
  (
    --$$INSERT$$
   );

  signal p_mem : p_mem_t := p_mem_c;


begin  -- pMem
  pData <= p_mem(to_integer(pAddr));

end Behavioral;
