library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SQ_2SHARE is
    Generic (bits : INTEGER := 7);
    Port ( clk : in STD_LOGIC;
           a0 : in UNSIGNED (bits-1 downto 0);
           a1 : in UNSIGNED (bits-1 downto 0);
           r0 : in UNSIGNED (bits-1 downto 0);
           r1 : in UNSIGNED (bits-1 downto 0);
           b0 : out UNSIGNED (bits-1 downto 0);
           b1 : out UNSIGNED (bits-1 downto 0));
end SQ_2SHARE;

architecture Behavioral of SQ_2SHARE is

    component AddModMersenne is
        Generic ( bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : in UNSIGNED (bits-1 downto 0);
               c : out UNSIGNED (bits-1 downto 0));
    end component;
    
    component SubModMersenne is
        Generic ( bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : in UNSIGNED (bits-1 downto 0);
               c : out UNSIGNED (bits-1 downto 0));
    end component;
    
    component SquModMersenne is
        Generic (bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : out UNSIGNED (bits-1 downto 0));
    end component;
    
    component MulModMersenne is
        Generic (bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : in UNSIGNED (bits-1 downto 0);
               c : out UNSIGNED (bits-1 downto 0));
    end component;
    
    component FF is
        Generic ( bits : INTEGER := 7);
        Port ( clk : in STD_LOGIC;
               input : in UNSIGNED ((bits-1) downto 0);
               output : out UNSIGNED ((bits-1) downto 0));
    end component;
    
    signal a12, a12r0, a0r0, a0r0a0, a0r0a0r1, a1s, a12r0_r, a0r0a0r1_r, a12r0a0 : UNSIGNED (bits-1 downto 0);
    
begin

    a12 <= a1(bits-2 downto 0) & a1(bits-1);
    Add1 : AddModMersenne Generic Map (bits) Port Map (a12, r0, a12r0);
    Sub1 : SubModMersenne Generic Map (bits) Port Map (a0, r0, a0r0);
    Mul1 : MulModMersenne Generic Map (bits) Port Map (a0r0, a0, a0r0a0);
    Add2 : AddModMersenne Generic Map (bits) Port Map (a0r0a0, r1, a0r0a0r1);
    Squ1 : SquModMersenne Generic Map (bits) Port Map (a1, a1s);
    Sub2 : SubModMersenne Generic Map (bits) Port Map (a1s, r1, b1);
 
    FF1 : FF Generic Map (bits) Port Map (clk, a12r0, a12r0_r);
    FF2 : FF Generic Map (bits) Port Map (clk, a0r0a0r1, a0r0a0r1_r);
    
    Mul2 : MulModMersenne Generic Map (bits) Port Map (a12r0_r, a0, a12r0a0);
    Add3 : AddModMersenne Generic Map (bits) Port Map (a12r0a0, a0r0a0r1_r, b0);

end Behavioral;