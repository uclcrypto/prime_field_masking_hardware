library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SBOX_2SHARE is
    Generic (bits : INTEGER := 7);
    Port ( clk : in STD_LOGIC;
           a0 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           a1 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r0 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r1 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r2 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r3 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r4 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           d0 : out STD_LOGIC_VECTOR (bits-1 downto 0);
           d1 : out STD_LOGIC_VECTOR (bits-1 downto 0));
end SBOX_2SHARE;

architecture Behavioral of SBOX_2SHARE is

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
    
    component SquModMersenne is
        Generic (bits : INTEGER := 7);
        Port ( a : in STD_LOGIC_VECTOR (bits-1 downto 0);
               b : out STD_LOGIC_VECTOR (bits-1 downto 0));
    end component;
    
    component MulModMersenne is
        Generic (bits : INTEGER := 7);
        Port ( a : in STD_LOGIC_VECTOR (bits-1 downto 0);
               b : in STD_LOGIC_VECTOR (bits-1 downto 0);
               c : out STD_LOGIC_VECTOR (bits-1 downto 0));
    end component;
    
    component FF is
        Generic ( bits : positive := 7);
        Port ( clk : in STD_LOGIC;
               input : in STD_LOGIC_VECTOR ((bits-1) downto 0);
               output : out STD_LOGIC_VECTOR ((bits-1) downto 0));
    end component;
    
    signal a12, a12r0, a0r0, a0r0a0, a0r0a0r1, a1s, a1sr1, a0_r, a1_r, r2_r, r3_r, r4_r, a12r0_r, a0r0a0r1_r, b0_r, a12r0a0, b1_r : STD_LOGIC_VECTOR (bits-1 downto 0);
    signal b12, b12r2, b0r2, b0r2b0, b0r2b0r3, b1s, b1sr3, a0_rr, a1_rr, r4_rr, b0_rr, b12r2_rr, b0r2b0r3_rr, c0_rr, b12r2b0, c1_rr : STD_LOGIC_VECTOR (bits-1 downto 0);
    signal a0c0, a0c1, a1c0, a1c1, a0c1r4, a1c0r4, a0c0_rrr, a0c1r4_rrr, a1c0r4_rrr, a1c1_rrr, d0_rrr, d1_rrr, d0c : STD_LOGIC_VECTOR (bits-1 downto 0);
    constant c : STD_LOGIC_VECTOR (bits-1 downto 0) := (bits-1 downto 2 => '0') & "10";

begin
     
    -- SQ 1
    a12 <= a1(bits-2 downto 0) & a1(bits-1);
    Add1 : AddModMersenne Generic Map (bits) Port Map (a12, r0, a12r0);
    Sub1 : SubModMersenne Generic Map (bits) Port Map (a0, r0, a0r0);
    Mul1 : MulModMersenne Generic Map (bits) Port Map (a0r0, a0, a0r0a0);
    Add2 : AddModMersenne Generic Map (bits) Port Map (a0r0a0, r1, a0r0a0r1);
    Squ1 : SquModMersenne Generic Map (bits) Port Map (a1, a1s);
    Sub2 : SubModMersenne Generic Map (bits) Port Map (a1s, r1, a1sr1);
    
    FF1 : FF Generic Map (bits) Port Map (clk, a0, a0_r);
    FF2 : FF Generic Map (bits) Port Map (clk, a1, a1_r);
    FF3 : FF Generic Map (bits) Port Map (clk, r2, r2_r);
    FF4 : FF Generic Map (bits) Port Map (clk, r3, r3_r);
    FF5 : FF Generic Map (bits) Port Map (clk, r4, r4_r);
    FF6 : FF Generic Map (bits) Port Map (clk, a12r0, a12r0_r);
    FF7 : FF Generic Map (bits) Port Map (clk, a0r0a0r1, a0r0a0r1_r);
    FF8 : FF Generic Map (bits) Port Map (clk, a1sr1, b0_r);
    
    Mul2 : MulModMersenne Generic Map (bits) Port Map (a12r0_r, a0_r, a12r0a0);
    Add3 : AddModMersenne Generic Map (bits) Port Map (a12r0a0, a0r0a0r1_r, b1_r);
     
    -- SQ 2
    b12 <= b1_r(bits-2 downto 0) & b1_r(bits-1);
    Add4 : AddModMersenne Generic Map (bits) Port Map (b12, r2_r, b12r2);
    Sub3 : SubModMersenne Generic Map (bits) Port Map (b0_r, r2_r, b0r2);
    Mul3 : MulModMersenne Generic Map (bits) Port Map (b0r2, b0_r, b0r2b0);
    Add5 : AddModMersenne Generic Map (bits) Port Map (b0r2b0, r3_r, b0r2b0r3);
    Squ2 : SquModMersenne Generic Map (bits) Port Map (b1_r, b1s);
    Sub4 : SubModMersenne Generic Map (bits) Port Map (b1s, r3_r, b1sr3);
     
    FF9 : FF Generic Map (bits) Port Map (clk, a0_r, a0_rr);
    FF10 : FF Generic Map (bits) Port Map (clk, a1_r, a1_rr);
    FF11 : FF Generic Map (bits) Port Map (clk, r4_r, r4_rr);
    FF12 : FF Generic Map (bits) Port Map (clk, b0_r, b0_rr);
    FF13 : FF Generic Map (bits) Port Map (clk, b12r2, b12r2_rr);
    FF14 : FF Generic Map (bits) Port Map (clk, b0r2b0r3, b0r2b0r3_rr);
    FF15 : FF Generic Map (bits) Port Map (clk, b1sr3, c0_rr);
    
    Mul4 : MulModMersenne Generic Map (bits) Port Map (b12r2_rr, b0_rr, b12r2b0);
    Add6 : AddModMersenne Generic Map (bits) Port Map (b12r2b0, b0r2b0r3_rr, c1_rr);
     
    -- MUL
    Mul5 : MulModMersenne Generic Map (bits) Port Map (a0_rr, c0_rr, a0c0);
    Mul6 : MulModMersenne Generic Map (bits) Port Map (a0_rr, c1_rr, a0c1);
    Mul7 : MulModMersenne Generic Map (bits) Port Map (a1_rr, c0_rr, a1c0);
    Mul8 : MulModMersenne Generic Map (bits) Port Map (a1_rr, c1_rr, a1c1);
    
    Add7 : AddModMersenne Generic Map (bits) Port Map (a0c1, r4_rr, a0c1r4);
    Sub5 : SubModMersenne Generic Map (bits) Port Map (a1c0, r4_rr, a1c0r4);
    
    FF16 : FF Generic Map (bits) Port Map (clk, a0c0, a0c0_rrr);
    FF17 : FF Generic Map (bits) Port Map (clk, a0c1r4, a0c1r4_rrr);
    FF18 : FF Generic Map (bits) Port Map (clk, a1c0r4, a1c0r4_rrr);  
    FF19 : FF Generic Map (bits) Port Map (clk, a1c1, a1c1_rrr);   
    
    Add8 : AddModMersenne Generic Map (bits) Port Map (a0c0_rrr, a0c1r4_rrr, d0_rrr);
    Add9 : AddModMersenne Generic Map (bits) Port Map (a1c1_rrr, a1c0r4_rrr, d1_rrr);
    
    -- ADD c
    Add10 : AddModMersenne Generic Map (bits) Port Map (d0_rrr, c, d0c);
	
    -- OUT
    d0 <= d0c;
    d1 <= d1_rrr;

end Behavioral;
