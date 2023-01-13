library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MulModMersenne is
    Generic ( bits : INTEGER := 7);
    Port ( a : in STD_LOGIC_VECTOR (bits-1 downto 0);
           b : in STD_LOGIC_VECTOR (bits-1 downto 0);
           c : out STD_LOGIC_VECTOR (bits-1 downto 0));
end MulModMersenne;

architecture Behavioral of MulModMersenne is

    signal ab : STD_LOGIC_VECTOR(2*bits-1 downto 0);
    signal ab_r : STD_LOGIC_VECTOR(bits downto 0);

begin

    ab <= a * b;
    ab_r <= ('0' & ab(bits-1 downto 0)) + ('0' & ab(2*bits-1 downto bits));
    c <= ab_r(bits-1 downto 0) + ab_r(bits);

end Behavioral;