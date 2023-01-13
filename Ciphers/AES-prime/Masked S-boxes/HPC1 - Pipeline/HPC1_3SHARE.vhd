library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HPC1_3SHARE is
    Generic ( bits : INTEGER := 7);
    Port ( clk : in STD_LOGIC;
           a0 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           a1 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           a2 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           b0 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           b1 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           b2 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r0 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r1 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r2 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r3 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r4 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           c0 : out STD_LOGIC_VECTOR (bits-1 downto 0);
           c1 : out STD_LOGIC_VECTOR (bits-1 downto 0);
           c2 : out STD_LOGIC_VECTOR (bits-1 downto 0));
end HPC1_3SHARE;

architecture Behavioral of HPC1_3SHARE is

    component AddModMersenne is
        Generic ( bits : INTEGER := 7);
        Port ( a : in STD_LOGIC_VECTOR (bits-1 downto 0);
               b : in STD_LOGIC_VECTOR (bits-1 downto 0);
               c : out STD_LOGIC_VECTOR (bits-1 downto 0));
    end component;
    
    component SubModMersenne is
        Generic ( bits : INTEGER := 7);
        Port ( a : in STD_LOGIC_VECTOR (bits-1 downto 0);
               b : in STD_LOGIC_VECTOR (bits-1 downto 0);
               c : out STD_LOGIC_VECTOR (bits-1 downto 0));
    end component;
    
    component MulModMersenne is
        Generic (bits : INTEGER := 7);
        Port ( a : in STD_LOGIC_VECTOR (bits-1 downto 0);
               b : in STD_LOGIC_VECTOR (bits-1 downto 0);
               c : out STD_LOGIC_VECTOR (bits-1 downto 0));
    end component;
    
    component FF is
        Generic ( bits : INTEGER := 7);
        Port ( clk : in STD_LOGIC;
               input : in STD_LOGIC_VECTOR ((bits-1) downto 0);
               output : out STD_LOGIC_VECTOR ((bits-1) downto 0));
    end component;
    
    signal r3r4, r3_r, r4_r, r3r4_r, b0r3, b1r4, b2r3r4, b0r3_r, b1r4_r, b2r3r4_r, a0b0, a0b1, a0b2, a1b0, a1b1, a1b2, a2b0, a2b1, a2b2, a0b1r0, a0b2r1, a1b0r0, a1b2r2, a2b0r1, a2b1r2, a0b1r0_r, a0b2r1_r, a1b0r0_r, a1b2r2_r, a2b0r1_r, a2b1r2_r, a0b0a0b1r0, a1b1a1b0r0, a2b2a2b0r1 : STD_LOGIC_VECTOR (bits-1 downto 0);
    
begin

    Add1 : AddModMersenne Generic Map (bits) Port Map (r3, r4, r3r4);
    
    FF1 : FF Generic Map (bits) Port Map (clk, r3, r3_r);
    FF2 : FF Generic Map (bits) Port Map (clk, r4, r4_r);
    FF3 : FF Generic Map (bits) Port Map (clk, r3r4, r3r4_r);
    
    Add2 : AddModMersenne Generic Map (bits) Port Map (b0, r3_r, b0r3);
    Add3 : AddModMersenne Generic Map (bits) Port Map (b1, r4_r, b1r4);
    Sub1 : SubModMersenne Generic Map (bits) Port Map (b2, r3r4_r, b2r3r4);
    
    FF4 : FF Generic Map (bits) Port Map (clk, b0r3, b0r3_r);
    FF5 : FF Generic Map (bits) Port Map (clk, b1r4, b1r4_r);
    FF6 : FF Generic Map (bits) Port Map (clk, b2r3r4, b2r3r4_r);

    Mul1 : MulModMersenne Generic Map (bits) Port Map (a0, b0r3_r, a0b0);
    Mul2 : MulModMersenne Generic Map (bits) Port Map (a0, b1r4_r, a0b1);
    Mul3 : MulModMersenne Generic Map (bits) Port Map (a0, b2r3r4_r, a0b2);
    Mul4 : MulModMersenne Generic Map (bits) Port Map (a1, b0r3_r, a1b0);
    Mul5 : MulModMersenne Generic Map (bits) Port Map (a1, b1r4_r, a1b1);
    Mul6 : MulModMersenne Generic Map (bits) Port Map (a1, b2r3r4_r, a1b2);
    Mul7 : MulModMersenne Generic Map (bits) Port Map (a2, b0r3_r, a2b0);
    Mul8 : MulModMersenne Generic Map (bits) Port Map (a2, b1r4_r, a2b1);
    Mul9 : MulModMersenne Generic Map (bits) Port Map (a2, b2r3r4_r, a2b2);

    Add4 : AddModMersenne Generic Map (bits) Port Map (a0b1, r0, a0b1r0);
    Add5 : AddModMersenne Generic Map (bits) Port Map (a0b2, r1, a0b2r1);
    Sub2 : SubModMersenne Generic Map (bits) Port Map (a1b0, r0, a1b0r0);
    Add6 : AddModMersenne Generic Map (bits) Port Map (a1b2, r2, a1b2r2);
    Sub3 : SubModMersenne Generic Map (bits) Port Map (a2b0, r1, a2b0r1);
    Sub4 : SubModMersenne Generic Map (bits) Port Map (a2b1, r2, a2b1r2);
    
    FF7 : FF Generic Map (bits) Port Map (clk, a0b1r0, a0b1r0_r);
    FF8 : FF Generic Map (bits) Port Map (clk, a0b2r1, a0b2r1_r);
    FF9 : FF Generic Map (bits) Port Map (clk, a1b0r0, a1b0r0_r);
    FF10 : FF Generic Map (bits) Port Map (clk, a1b2r2, a1b2r2_r);
    FF11 : FF Generic Map (bits) Port Map (clk, a2b0r1, a2b0r1_r);
    FF12 : FF Generic Map (bits) Port Map (clk, a2b1r2, a2b1r2_r);    
    
    Add7 : AddModMersenne Generic Map (bits) Port Map (a0b0, a0b1r0_r, a0b0a0b1r0);
    Add8 : AddModMersenne Generic Map (bits) Port Map (a0b0a0b1r0, a0b2r1_r, c0);
    Add9 : AddModMersenne Generic Map (bits) Port Map (a1b1, a1b0r0_r, a1b1a1b0r0);
    Add10 : AddModMersenne Generic Map (bits) Port Map (a1b1a1b0r0, a1b2r2_r, c1);
    Add11 : AddModMersenne Generic Map (bits) Port Map (a2b2, a2b0r1_r, a2b2a2b0r1);
    Add12 : AddModMersenne Generic Map (bits) Port Map (a2b2a2b0r1, a2b1r2_r, c2);
    
end Behavioral;