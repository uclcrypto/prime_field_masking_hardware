library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity AddModMersenneNoP is
    Generic ( bits : INTEGER := 7);
    Port ( a : in UNSIGNED (bits-1 downto 0);
           b : in UNSIGNED (bits-1 downto 0);
           c : out UNSIGNED (bits-1 downto 0));
end AddModMersenneNoP;

architecture Behavioral of AddModMersenneNoP is

    signal ab : UNSIGNED(bits downto 0);
    signal ab_r : UNSIGNED(bits-1 downto 0);

begin

    ab <= ('0' & a) + ('0' & b);
    ab_r <= ab(bits-1 downto 0) + ('0' & ab(bits));
    c <= (OTHERS => '0') when (ab_r = (bits-1 downto 0 => '1')) else ab_r;

end Behavioral;