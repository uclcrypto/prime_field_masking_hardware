library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SQ_3SHARE is
    Generic (bits : INTEGER := 7);
    Port ( clk : in STD_LOGIC;
           a0 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           a1 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           a2 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r0 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r1 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r2 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r3 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r4 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           b0 : out STD_LOGIC_VECTOR (bits-1 downto 0);
           b1 : out STD_LOGIC_VECTOR (bits-1 downto 0);
           b2 : out STD_LOGIC_VECTOR (bits-1 downto 0));
end SQ_3SHARE;

architecture Behavioral of SQ_3SHARE is

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
    
    signal r3r4, r5, a02, a12, a22, a12r0, a22r1, a02r2, a0r0, a1r1, a2r2, a0r0a0, a1r1a1, a2r2a2, a0r0a0r3, a1r1a1r4, a2r2a2r5, a0_r, a1_r, a2_r, a12r0_r, a22r1_r, a02r2_r, a0r0a0r3_r, a1r1a1r4_r, a2r2a2r5_r, a12r0a0, a22r1a1, a02r2a2 : STD_LOGIC_VECTOR (bits-1 downto 0);
    
begin
    
    Add1 : AddModMersenne Generic Map (bits) Port Map (r3, r4, r3r4);
    FF1 : FF Generic Map (bits) Port Map (clk, r3r4, r5);
    
    a02 <= a0(bits-2 downto 0) & a0(bits-1);
    a12 <= a1(bits-2 downto 0) & a1(bits-1);
    a22 <= a2(bits-2 downto 0) & a2(bits-1);
    Add2 : AddModMersenne Generic Map (bits) Port Map (a12, r0, a12r0);
    Add3 : AddModMersenne Generic Map (bits) Port Map (a22, r1, a22r1);
    Add4 : AddModMersenne Generic Map (bits) Port Map (a02, r2, a02r2);
    Sub1 : SubModMersenne Generic Map (bits) Port Map (a0, r0, a0r0);
    Sub2 : SubModMersenne Generic Map (bits) Port Map (a1, r1, a1r1);
    Sub3 : SubModMersenne Generic Map (bits) Port Map (a2, r2, a2r2);
    Mul1 : MulModMersenne Generic Map (bits) Port Map (a0r0, a0, a0r0a0);
    Mul2 : MulModMersenne Generic Map (bits) Port Map (a1r1, a1, a1r1a1);
    Mul3 : MulModMersenne Generic Map (bits) Port Map (a2r2, a2, a2r2a2);
    Add5 : AddModMersenne Generic Map (bits) Port Map (a0r0a0, r3, a0r0a0r3);
    Add6 : AddModMersenne Generic Map (bits) Port Map (a1r1a1, r4, a1r1a1r4);
    Sub4 : SubModMersenne Generic Map (bits) Port Map (a2r2a2, r5, a2r2a2r5);

    FF2 : FF Generic Map (bits) Port Map (clk, a0, a0_r);
    FF3 : FF Generic Map (bits) Port Map (clk, a1, a1_r);
    FF4 : FF Generic Map (bits) Port Map (clk, a2, a2_r);
    FF5 : FF Generic Map (bits) Port Map (clk, a12r0, a12r0_r);
    FF6 : FF Generic Map (bits) Port Map (clk, a22r1, a22r1_r);
    FF7 : FF Generic Map (bits) Port Map (clk, a02r2, a02r2_r);
    FF8 : FF Generic Map (bits) Port Map (clk, a0r0a0r3, a0r0a0r3_r);
    FF9 : FF Generic Map (bits) Port Map (clk, a1r1a1r4, a1r1a1r4_r);
    FF10 : FF Generic Map (bits) Port Map (clk, a2r2a2r5, a2r2a2r5_r);
    
    Mul4 : MulModMersenne Generic Map (bits) Port Map (a12r0_r, a0_r, a12r0a0);
    Mul5 : MulModMersenne Generic Map (bits) Port Map (a22r1_r, a1_r, a22r1a1);
    Mul6 : MulModMersenne Generic Map (bits) Port Map (a02r2_r, a2_r, a02r2a2);
    Add7 : AddModMersenne Generic Map (bits) Port Map (a12r0a0, a0r0a0r3_r, b0);
    Add8 : AddModMersenne Generic Map (bits) Port Map (a22r1a1, a1r1a1r4_r, b1);
    Add9 : AddModMersenne Generic Map (bits) Port Map (a02r2a2, a2r2a2r5_r, b2);

end Behavioral;