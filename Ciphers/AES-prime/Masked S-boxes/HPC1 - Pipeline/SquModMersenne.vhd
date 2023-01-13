library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SquModMersenne is
    Generic ( bits : INTEGER := 7);
    Port ( a : in STD_LOGIC_VECTOR (bits-1 downto 0);
           b : out STD_LOGIC_VECTOR (bits-1 downto 0));
end SquModMersenne;

architecture Behavioral of SquModMersenne is

    signal aa : STD_LOGIC_VECTOR(2*bits-1 downto 0);
    signal aa_r : STD_LOGIC_VECTOR(bits downto 0);

begin

    aa <= a * a;
    aa_r <= ('0' & aa(bits-1 downto 0)) + ('0' & aa(2*bits-1 downto bits));
    b <= aa_r(bits-1 downto 0) + aa_r(bits);

end Behavioral;