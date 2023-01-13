library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity AddModMersenne is
    Generic ( bits : INTEGER := 7);
    Port ( a : in STD_LOGIC_VECTOR (bits-1 downto 0);
           b : in STD_LOGIC_VECTOR (bits-1 downto 0);
           c : out STD_LOGIC_VECTOR (bits-1 downto 0));
end AddModMersenne;

architecture Behavioral of AddModMersenne is

    signal ab : STD_LOGIC_VECTOR(bits downto 0);

begin

    ab <= ('0' & a) + ('0' & b);
    c <= ab(bits-1 downto 0) + ab(bits);

end Behavioral;