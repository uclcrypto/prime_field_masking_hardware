library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity HPC1_2SHARE is
    Generic ( bits : INTEGER := 7);
    Port ( clk : in STD_LOGIC;
           a0 : in UNSIGNED (bits-1 downto 0);
           a1 : in UNSIGNED (bits-1 downto 0);
           b0 : in UNSIGNED (bits-1 downto 0);
           b1 : in UNSIGNED (bits-1 downto 0);
           r0 : in UNSIGNED (bits-1 downto 0);
           r1 : in UNSIGNED (bits-1 downto 0);
           c0 : out UNSIGNED (bits-1 downto 0);
           c1 : out UNSIGNED (bits-1 downto 0));
end HPC1_2SHARE;

architecture Behavioral of HPC1_2SHARE is

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
    
    signal b0r1, b1r1, b0r1_r, b1r1_r, a0b0, a0b1, a1b0, a1b1, a0b1r0, a1b0r0, a0b1r0_r, a1b0r0_r : UNSIGNED (bits-1 downto 0);
    
begin
    
    Add1 : AddModMersenne Generic Map (bits) Port Map (b0, r1, b0r1);
    Sub1 : SubModMersenne Generic Map (bits) Port Map (b1, r1, b1r1);

    FF1 : FF Generic Map (bits) Port Map (clk, b0r1, b0r1_r);
    FF2 : FF Generic Map (bits) Port Map (clk, b1r1, b1r1_r);
    
    Mul1 : MulModMersenne Generic Map (bits) Port Map (a0, b0r1_r, a0b0);
    Mul2 : MulModMersenne Generic Map (bits) Port Map (a0, b1r1_r, a0b1);
    Mul3 : MulModMersenne Generic Map (bits) Port Map (a1, b0r1_r, a1b0);
    Mul4 : MulModMersenne Generic Map (bits) Port Map (a1, b1r1_r, a1b1);

    Add2 : AddModMersenne Generic Map (bits) Port Map (a0b1, r0, a0b1r0);
    Sub2 : SubModMersenne Generic Map (bits) Port Map (a1b0, r0, a1b0r0);
    
    FF3 : FF Generic Map (bits) Port Map (clk, a0b1r0, a0b1r0_r);
    FF4 : FF Generic Map (bits) Port Map (clk, a1b0r0, a1b0r0_r);
    
    Add3 : AddModMersenne Generic Map (bits) Port Map (a0b0, a0b1r0_r, c0);
    Add4 : AddModMersenne Generic Map (bits) Port Map (a1b1, a1b0r0_r, c1);
    
end Behavioral;