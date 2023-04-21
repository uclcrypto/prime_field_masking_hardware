library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Sbox is
    Port ( input : in UNSIGNED (6 downto 0);
           output : out UNSIGNED (6 downto 0));
end Sbox;

architecture Behavioral of Sbox is

    component SquModMersenne is
        Generic ( bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : out UNSIGNED (bits-1 downto 0));
    end component;

    component MulModMersenne is
        Generic ( bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : in UNSIGNED (bits-1 downto 0);
               c : out UNSIGNED (bits-1 downto 0));
    end component;
    
    component AddModMersenne is
        Generic ( bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : in UNSIGNED (bits-1 downto 0);
               c : out UNSIGNED (bits-1 downto 0));
    end component;

    signal x2, x3, x4, x5, x8, x11 : UNSIGNED (6 downto 0);
    constant c : UNSIGNED (6 downto 0) := "0000010";
    
begin

    SQ1: SquModMersenne Generic Map (7) Port Map (input, x2);
    SQ2: SquModMersenne Generic Map (7) Port Map (x2, x4);
    MUL1: MulModMersenne Generic Map (7) Port Map (input, x4, x5);
    ADD1: AddModMersenne Generic Map (7) Port Map (x5, c, output);

end Behavioral;