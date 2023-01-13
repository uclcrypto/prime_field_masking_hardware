library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SBOX_3SHARE is
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
           r5 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r6 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r7 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r8 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r9 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r10 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r11 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           r12 : in STD_LOGIC_VECTOR (bits-1 downto 0);
           d0 : out STD_LOGIC_VECTOR (bits-1 downto 0);
           d1 : out STD_LOGIC_VECTOR (bits-1 downto 0);
           d2 : out STD_LOGIC_VECTOR (bits-1 downto 0));
end SBOX_3SHARE;

architecture Behavioral of SBOX_3SHARE is

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
    
    signal r3r4, r3r4_r, a02, a12, a22, a12r0, a22r1, a02r2, a0r0, a1r1, a2r2, a0r0a0, a1r1a1, a2r2a2, a0r0a0r3, a1r1a1r4, a2r2a2r3r4, r8r9, a0_r, a1_r, a2_r, r5_r, r6_r, r7_r, r8_r, r9_r, r8r9_r, r10_r, r11_r, r12_r, a12r0_r, a22r1_r, a02r2_r, a0r0a0r3_r, a1r1a1r4_r, a2r2a2r3r4_r, a12r0a0, a22r1a1, a02r2a2, b0_r, b1_r, b2_r : STD_LOGIC_VECTOR (bits-1 downto 0);
    signal b02, b12, b22, b12r5, b22r6, b02r7, b0r5, b1r6, b2r7, b0r5b0, b1r6b1, b2r7b2, b0r5b0r8, b1r6b1r9, b2r7b2r8r9, a0_rr, a1_rr, a2_rr, b0_rr, b1_rr, b2_rr, r10_rr, r11_rr, r12_rr, b12r5_rr, b22r6_rr, b02r7_rr, b0r5b0r8_rr, b1r6b1r9_rr, b2r7b2r8r9_rr, b12r5b0, b22r6b1, b02r7b2, b12r5b0b0r5b0r8, b22r6b1b1r6b1r9, b02r7b2b2r7b2r8r9, a0_rrr, a1_rrr, a2_rrr, r10_rrr, r11_rrr, r12_rrr, c0_rrr, c1_rrr, c2_rrr : STD_LOGIC_VECTOR (bits-1 downto 0);
    signal a0c0, a0c1, a0c2, a1c0, a1c1, a1c2, a2c0, a2c1, a2c2, a0c1r10, a0c2r11, a1c0r10, a1c2r12, a2c0r11, a2c1r12, a0c0_rrrr, a0c1r10_rrrr, a0c2r11_rrrr, a1c0r10_rrrr, a1c1_rrrr, a1c2r12_rrrr, a2c0r11_rrrr, a2c1r12_rrrr, a2c2_rrrr, a0c0a0c1r10, d0_rrrr, a1c1a1c0r10, d1_rrrr, a2c2a2c0r11, d2_rrrr, d0c : STD_LOGIC_VECTOR (bits-1 downto 0);
    constant c : STD_LOGIC_VECTOR (bits-1 downto 0) := (bits-1 downto 2 => '0') & "10";

begin

    Add1 : AddModMersenne Generic Map (bits) Port Map (r3, r4, r3r4);
    FF1 : FF Generic Map (bits) Port Map (clk, r3r4, r3r4_r);

    -- SQ 1
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
    Sub4 : SubModMersenne Generic Map (bits) Port Map (a2r2a2, r3r4_r, a2r2a2r3r4);
    Add7 : AddModMersenne Generic Map (bits) Port Map (r8, r9, r8r9);
    
    FF2 : FF Generic Map (bits) Port Map (clk, a0, a0_r);
    FF3 : FF Generic Map (bits) Port Map (clk, a1, a1_r);
    FF4 : FF Generic Map (bits) Port Map (clk, a2, a2_r);
    FF5 : FF Generic Map (bits) Port Map (clk, r5, r5_r);
    FF6 : FF Generic Map (bits) Port Map (clk, r6, r6_r);
    FF7 : FF Generic Map (bits) Port Map (clk, r7, r7_r);
    FF8 : FF Generic Map (bits) Port Map (clk, r8, r8_r);
    FF9 : FF Generic Map (bits) Port Map (clk, r9, r9_r);
    FF10 : FF Generic Map (bits) Port Map (clk, r8r9, r8r9_r);
    FF11 : FF Generic Map (bits) Port Map (clk, r10, r10_r);
    FF12 : FF Generic Map (bits) Port Map (clk, r11, r11_r);
    FF13 : FF Generic Map (bits) Port Map (clk, r12, r12_r);
    FF14 : FF Generic Map (bits) Port Map (clk, a12r0, a12r0_r);
    FF15 : FF Generic Map (bits) Port Map (clk, a22r1, a22r1_r);
    FF16 : FF Generic Map (bits) Port Map (clk, a02r2, a02r2_r);
    FF17 : FF Generic Map (bits) Port Map (clk, a0r0a0r3, a0r0a0r3_r);
    FF18 : FF Generic Map (bits) Port Map (clk, a1r1a1r4, a1r1a1r4_r);
    FF19 : FF Generic Map (bits) Port Map (clk, a2r2a2r3r4, a2r2a2r3r4_r);
    
    Mul4 : MulModMersenne Generic Map (bits) Port Map (a12r0_r, a0_r, a12r0a0);
    Mul5 : MulModMersenne Generic Map (bits) Port Map (a22r1_r, a1_r, a22r1a1);
    Mul6 : MulModMersenne Generic Map (bits) Port Map (a02r2_r, a2_r, a02r2a2);
    Add8 : AddModMersenne Generic Map (bits) Port Map (a12r0a0, a0r0a0r3_r, b0_r);
    Add9 : AddModMersenne Generic Map (bits) Port Map (a22r1a1, a1r1a1r4_r, b1_r);
    Add10 : AddModMersenne Generic Map (bits) Port Map (a02r2a2, a2r2a2r3r4_r, b2_r);
     
    -- SQ 2
    b02 <= b0_r(bits-2 downto 0) & b0_r(bits-1);
    b12 <= b1_r(bits-2 downto 0) & b1_r(bits-1);
    b22 <= b2_r(bits-2 downto 0) & b2_r(bits-1);
    Add11 : AddModMersenne Generic Map (bits) Port Map (b12, r5_r, b12r5);
    Add12 : AddModMersenne Generic Map (bits) Port Map (b22, r6_r, b22r6);
    Add13 : AddModMersenne Generic Map (bits) Port Map (b02, r7_r, b02r7);
    Sub5 : SubModMersenne Generic Map (bits) Port Map (b0_r, r5_r, b0r5);
    Sub6 : SubModMersenne Generic Map (bits) Port Map (b1_r, r6_r, b1r6);
    Sub7 : SubModMersenne Generic Map (bits) Port Map (b2_r, r7_r, b2r7);
    Mul7 : MulModMersenne Generic Map (bits) Port Map (b0r5, b0_r, b0r5b0);
    Mul8 : MulModMersenne Generic Map (bits) Port Map (b1r6, b1_r, b1r6b1);
    Mul9 : MulModMersenne Generic Map (bits) Port Map (b2r7, b2_r, b2r7b2);
    Add14 : AddModMersenne Generic Map (bits) Port Map (b0r5b0, r8_r, b0r5b0r8);
    Add15 : AddModMersenne Generic Map (bits) Port Map (b1r6b1, r9_r, b1r6b1r9);
    Sub8 : SubModMersenne Generic Map (bits) Port Map (b2r7b2, r8r9_r, b2r7b2r8r9);
    
    FF20 : FF Generic Map (bits) Port Map (clk, a0_r, a0_rr);
    FF21 : FF Generic Map (bits) Port Map (clk, a1_r, a1_rr);
    FF22 : FF Generic Map (bits) Port Map (clk, a2_r, a2_rr);
    FF23 : FF Generic Map (bits) Port Map (clk, b0_r, b0_rr);
    FF24 : FF Generic Map (bits) Port Map (clk, b1_r, b1_rr);
    FF25 : FF Generic Map (bits) Port Map (clk, b2_r, b2_rr);
    FF26 : FF Generic Map (bits) Port Map (clk, r10_r, r10_rr);
    FF27 : FF Generic Map (bits) Port Map (clk, r11_r, r11_rr);
    FF28 : FF Generic Map (bits) Port Map (clk, r12_r, r12_rr);
    FF29 : FF Generic Map (bits) Port Map (clk, b12r5, b12r5_rr);
    FF30 : FF Generic Map (bits) Port Map (clk, b22r6, b22r6_rr);
    FF31 : FF Generic Map (bits) Port Map (clk, b02r7, b02r7_rr);
    FF32 : FF Generic Map (bits) Port Map (clk, b0r5b0r8, b0r5b0r8_rr);
    FF33 : FF Generic Map (bits) Port Map (clk, b1r6b1r9, b1r6b1r9_rr);
    FF34 : FF Generic Map (bits) Port Map (clk, b2r7b2r8r9, b2r7b2r8r9_rr);
    
    Mul10 : MulModMersenne Generic Map (bits) Port Map (b12r5_rr, b0_rr, b12r5b0);
    Mul11 : MulModMersenne Generic Map (bits) Port Map (b22r6_rr, b1_rr, b22r6b1);
    Mul12 : MulModMersenne Generic Map (bits) Port Map (b02r7_rr, b2_rr, b02r7b2);
    Add16 : AddModMersenne Generic Map (bits) Port Map (b12r5b0, b0r5b0r8_rr, b12r5b0b0r5b0r8);
    Add17 : AddModMersenne Generic Map (bits) Port Map (b22r6b1, b1r6b1r9_rr, b22r6b1b1r6b1r9);
    Add18 : AddModMersenne Generic Map (bits) Port Map (b02r7b2, b2r7b2r8r9_rr, b02r7b2b2r7b2r8r9);
     
    FF35 : FF Generic Map (bits) Port Map (clk, a0_rr, a0_rrr);
    FF36 : FF Generic Map (bits) Port Map (clk, a1_rr, a1_rrr);
    FF37 : FF Generic Map (bits) Port Map (clk, a2_rr, a2_rrr);
    FF38 : FF Generic Map (bits) Port Map (clk, r10_rr, r10_rrr);
    FF39 : FF Generic Map (bits) Port Map (clk, r11_rr, r11_rrr);
    FF40 : FF Generic Map (bits) Port Map (clk, r12_rr, r12_rrr);
    FF41 : FF Generic Map (bits) Port Map (clk, b12r5b0b0r5b0r8, c0_rrr);
    FF42 : FF Generic Map (bits) Port Map (clk, b22r6b1b1r6b1r9, c1_rrr);
    FF43 : FF Generic Map (bits) Port Map (clk, b02r7b2b2r7b2r8r9, c2_rrr);
    
     -- MUL
    Mul13 : MulModMersenne Generic Map (bits) Port Map (a0_rrr, c0_rrr, a0c0);
    Mul14 : MulModMersenne Generic Map (bits) Port Map (a0_rrr, c1_rrr, a0c1);
    Mul15 : MulModMersenne Generic Map (bits) Port Map (a0_rrr, c2_rrr, a0c2);
    Mul16 : MulModMersenne Generic Map (bits) Port Map (a1_rrr, c0_rrr, a1c0);
    Mul17 : MulModMersenne Generic Map (bits) Port Map (a1_rrr, c1_rrr, a1c1);
    Mul18 : MulModMersenne Generic Map (bits) Port Map (a1_rrr, c2_rrr, a1c2);
    Mul19 : MulModMersenne Generic Map (bits) Port Map (a2_rrr, c0_rrr, a2c0);
    Mul20 : MulModMersenne Generic Map (bits) Port Map (a2_rrr, c1_rrr, a2c1);
    Mul21 : MulModMersenne Generic Map (bits) Port Map (a2_rrr, c2_rrr, a2c2);
    
    Add19 : AddModMersenne Generic Map (bits) Port Map (a0c1, r10_rrr, a0c1r10);
    Add20 : AddModMersenne Generic Map (bits) Port Map (a0c2, r11_rrr, a0c2r11);
    Sub9 : SubModMersenne Generic Map (bits) Port Map (a1c0, r10_rrr, a1c0r10);
    Add21 : AddModMersenne Generic Map (bits) Port Map (a1c2, r12_rrr, a1c2r12);
    Sub10 : SubModMersenne Generic Map (bits) Port Map (a2c0, r11_rrr, a2c0r11);
    Sub11 : SubModMersenne Generic Map (bits) Port Map (a2c1, r12_rrr, a2c1r12);
    
    FF44 : FF Generic Map (bits) Port Map (clk, a0c0, a0c0_rrrr);
    FF45 : FF Generic Map (bits) Port Map (clk, a0c1r10, a0c1r10_rrrr);
    FF46 : FF Generic Map (bits) Port Map (clk, a0c2r11, a0c2r11_rrrr);
    FF47 : FF Generic Map (bits) Port Map (clk, a1c0r10, a1c0r10_rrrr);
    FF48 : FF Generic Map (bits) Port Map (clk, a1c1, a1c1_rrrr);
    FF49 : FF Generic Map (bits) Port Map (clk, a1c2r12, a1c2r12_rrrr);
    FF50 : FF Generic Map (bits) Port Map (clk, a2c0r11, a2c0r11_rrrr);
    FF51 : FF Generic Map (bits) Port Map (clk, a2c1r12, a2c1r12_rrrr);
    FF52 : FF Generic Map (bits) Port Map (clk, a2c2, a2c2_rrrr);
    
    Add22 : AddModMersenne Generic Map (bits) Port Map (a0c0_rrrr, a0c1r10_rrrr, a0c0a0c1r10);
    Add23 : AddModMersenne Generic Map (bits) Port Map (a0c0a0c1r10, a0c2r11_rrrr, d0_rrrr);
    Add24 : AddModMersenne Generic Map (bits) Port Map (a1c1_rrrr, a1c0r10_rrrr, a1c1a1c0r10);
    Add25 : AddModMersenne Generic Map (bits) Port Map (a1c1a1c0r10, a1c2r12_rrrr, d1_rrrr);
    Add26 : AddModMersenne Generic Map (bits) Port Map (a2c2_rrrr, a2c0r11_rrrr, a2c2a2c0r11);
    Add27 : AddModMersenne Generic Map (bits) Port Map (a2c2a2c0r11, a2c1r12_rrrr, d2_rrrr);
    
    -- ADD c
    Add28 : AddModMersenne Generic Map (bits) Port Map (d0_rrrr, c, d0c);
	
    -- OUT
    d0 <= d0c;
    d1 <= d1_rrrr;
    d2 <= d2_rrrr;

end Behavioral;
