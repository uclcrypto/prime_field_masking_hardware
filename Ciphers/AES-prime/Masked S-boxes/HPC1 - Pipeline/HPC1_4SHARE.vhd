library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity HPC1_4SHARE is
    Generic ( bits : INTEGER := 7);
    Port ( clk : in STD_LOGIC;
           a0 : in UNSIGNED (bits-1 downto 0);
           a1 : in UNSIGNED (bits-1 downto 0);
           a2 : in UNSIGNED (bits-1 downto 0);
           a3 : in UNSIGNED (bits-1 downto 0);
           b0 : in UNSIGNED (bits-1 downto 0);
           b1 : in UNSIGNED (bits-1 downto 0);
           b2 : in UNSIGNED (bits-1 downto 0);
           b3 : in UNSIGNED (bits-1 downto 0);
           r0 : in UNSIGNED (bits-1 downto 0);
           r1 : in UNSIGNED (bits-1 downto 0);
           r2 : in UNSIGNED (bits-1 downto 0);
           r3 : in UNSIGNED (bits-1 downto 0);
           r4 : in UNSIGNED (bits-1 downto 0);
           r5 : in UNSIGNED (bits-1 downto 0);
           r6 : in UNSIGNED (bits-1 downto 0);
           r7 : in UNSIGNED (bits-1 downto 0);
           r8 : in UNSIGNED (bits-1 downto 0);
           r9 : in UNSIGNED (bits-1 downto 0);
           c0 : out UNSIGNED (bits-1 downto 0);
           c1 : out UNSIGNED (bits-1 downto 0);
           c2 : out UNSIGNED (bits-1 downto 0);
           c3 : out UNSIGNED (bits-1 downto 0));
end HPC1_4SHARE;

architecture Behavioral of HPC1_4SHARE is

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
    
    signal b0r6, b0r6r9, b1r7, b1r7r6, b2r8, b2r8r7, b3r9, b3r9r8, b0r6r9_r, b1r7r6_r, b2r8r7_r, b3r9r8_r, a0b0, a0b1, a0b2, a0b3, a1b0, a1b1, a1b2, a1b3, a2b0, a2b1, a2b2, a2b3, a3b0, a3b1, a3b2, a3b3, a0b1r0, a0b2r1, a0b3r3, a1b0r0, a1b2r2, a1b3r4, a2b0r1, a2b1r2, a2b3r5, a3b0r3, a3b1r4, a3b2r5, a0b1r0_r, a0b2r1_r, a0b3r3_r, a1b0r0_r, a1b2r2_r, a1b3r4_r, a2b0r1_r, a2b1r2_r, a2b3r5_r, a3b0r3_r, a3b1r4_r, a3b2r5_r, a0b0a0b1r0, a0b0a0b1r0a0b2r1, a1b1a1b0r0, a1b1a1b0r0a1b2r2, a2b2a2b0r1, a2b2a2b0r1a2b1r2, a3b3a3b0r3, a3b3a3b0r3a3b1r4 : UNSIGNED (bits-1 downto 0);
    
begin

    Add1 : AddModMersenne Generic Map (bits) Port Map (b0, r6, b0r6);
    Sub1 : SubModMersenne Generic Map (bits) Port Map (b0r6, r9, b0r6r9);
    Add2 : AddModMersenne Generic Map (bits) Port Map (b1, r7, b1r7);
    Sub2 : SubModMersenne Generic Map (bits) Port Map (b1r7, r6, b1r7r6);
    Add3 : AddModMersenne Generic Map (bits) Port Map (b2, r8, b2r8);
    Sub3 : SubModMersenne Generic Map (bits) Port Map (b2r8, r7, b2r8r7);
    Add4 : AddModMersenne Generic Map (bits) Port Map (b3, r9, b3r9);
    Sub4 : SubModMersenne Generic Map (bits) Port Map (b3r9, r8, b3r9r8);
    
    FF1 : FF Generic Map (bits) Port Map (clk, b0r6r9, b0r6r9_r);
    FF2 : FF Generic Map (bits) Port Map (clk, b1r7r6, b1r7r6_r);
    FF3 : FF Generic Map (bits) Port Map (clk, b2r8r7, b2r8r7_r);
    FF4 : FF Generic Map (bits) Port Map (clk, b3r9r8, b3r9r8_r);

    Mul1 : MulModMersenne Generic Map (bits) Port Map (a0, b0r6r9_r, a0b0);
    Mul2 : MulModMersenne Generic Map (bits) Port Map (a0, b1r7r6_r, a0b1);
    Mul3 : MulModMersenne Generic Map (bits) Port Map (a0, b2r8r7_r, a0b2);
    Mul4 : MulModMersenne Generic Map (bits) Port Map (a0, b3r9r8_r, a0b3);
    Mul5 : MulModMersenne Generic Map (bits) Port Map (a1, b0r6r9_r, a1b0);
    Mul6 : MulModMersenne Generic Map (bits) Port Map (a1, b1r7r6_r, a1b1);
    Mul7 : MulModMersenne Generic Map (bits) Port Map (a1, b2r8r7_r, a1b2);
    Mul8 : MulModMersenne Generic Map (bits) Port Map (a1, b3r9r8_r, a1b3);
    Mul9 : MulModMersenne Generic Map (bits) Port Map (a2, b0r6r9_r, a2b0);
    Mul10 : MulModMersenne Generic Map (bits) Port Map (a2, b1r7r6_r, a2b1);
    Mul11 : MulModMersenne Generic Map (bits) Port Map (a2, b2r8r7_r, a2b2);
    Mul12 : MulModMersenne Generic Map (bits) Port Map (a2, b3r9r8_r, a2b3);
    Mul13 : MulModMersenne Generic Map (bits) Port Map (a3, b0r6r9_r, a3b0);
    Mul14 : MulModMersenne Generic Map (bits) Port Map (a3, b1r7r6_r, a3b1);
    Mul15 : MulModMersenne Generic Map (bits) Port Map (a3, b2r8r7_r, a3b2);
    Mul16 : MulModMersenne Generic Map (bits) Port Map (a3, b3r9r8_r, a3b3);

    Add5 : AddModMersenne Generic Map (bits) Port Map (a0b1, r0, a0b1r0);
    Add6 : AddModMersenne Generic Map (bits) Port Map (a0b2, r1, a0b2r1);
    Add7 : AddModMersenne Generic Map (bits) Port Map (a0b3, r3, a0b3r3);
    Sub5 : SubModMersenne Generic Map (bits) Port Map (a1b0, r0, a1b0r0);
    Add8 : AddModMersenne Generic Map (bits) Port Map (a1b2, r2, a1b2r2);
    Add9 : AddModMersenne Generic Map (bits) Port Map (a1b3, r4, a1b3r4);
    Sub6 : SubModMersenne Generic Map (bits) Port Map (a2b0, r1, a2b0r1);
    Sub7 : SubModMersenne Generic Map (bits) Port Map (a2b1, r2, a2b1r2);
    Add10 : AddModMersenne Generic Map (bits) Port Map (a2b3, r5, a2b3r5);
    Sub8 : SubModMersenne Generic Map (bits) Port Map (a3b0, r3, a3b0r3);
    Sub9 : SubModMersenne Generic Map (bits) Port Map (a3b1, r4, a3b1r4);
    Sub10 : SubModMersenne Generic Map (bits) Port Map (a3b2, r5, a3b2r5);
    
    FF5 : FF Generic Map (bits) Port Map (clk, a0b1r0, a0b1r0_r);
    FF6 : FF Generic Map (bits) Port Map (clk, a0b2r1, a0b2r1_r);
    FF7 : FF Generic Map (bits) Port Map (clk, a0b3r3, a0b3r3_r);
    FF8 : FF Generic Map (bits) Port Map (clk, a1b0r0, a1b0r0_r);
    FF9 : FF Generic Map (bits) Port Map (clk, a1b2r2, a1b2r2_r);
    FF10 : FF Generic Map (bits) Port Map (clk, a1b3r4, a1b3r4_r);
    FF11 : FF Generic Map (bits) Port Map (clk, a2b0r1, a2b0r1_r);
    FF12 : FF Generic Map (bits) Port Map (clk, a2b1r2, a2b1r2_r);
    FF13 : FF Generic Map (bits) Port Map (clk, a2b3r5, a2b3r5_r);
    FF14 : FF Generic Map (bits) Port Map (clk, a3b0r3, a3b0r3_r);
    FF15 : FF Generic Map (bits) Port Map (clk, a3b1r4, a3b1r4_r);
    FF16 : FF Generic Map (bits) Port Map (clk, a3b2r5, a3b2r5_r);
    
    Add11 : AddModMersenne Generic Map (bits) Port Map (a0b0, a0b1r0_r, a0b0a0b1r0);
    Add12 : AddModMersenne Generic Map (bits) Port Map (a0b0a0b1r0, a0b2r1_r, a0b0a0b1r0a0b2r1);
    Add13 : AddModMersenne Generic Map (bits) Port Map (a0b0a0b1r0a0b2r1, a0b3r3_r, c0);
    Add14 : AddModMersenne Generic Map (bits) Port Map (a1b1, a1b0r0_r, a1b1a1b0r0);
    Add15 : AddModMersenne Generic Map (bits) Port Map (a1b1a1b0r0, a1b2r2_r, a1b1a1b0r0a1b2r2);
    Add16 : AddModMersenne Generic Map (bits) Port Map (a1b1a1b0r0a1b2r2, a1b3r4_r, c1);
    Add17 : AddModMersenne Generic Map (bits) Port Map (a2b2, a2b0r1_r, a2b2a2b0r1);
    Add18 : AddModMersenne Generic Map (bits) Port Map (a2b2a2b0r1, a2b1r2_r, a2b2a2b0r1a2b1r2);
    Add19 : AddModMersenne Generic Map (bits) Port Map (a2b2a2b0r1a2b1r2, a2b3r5_r, c2);
    Add20 : AddModMersenne Generic Map (bits) Port Map (a3b3, a3b0r3_r, a3b3a3b0r3);
    Add21 : AddModMersenne Generic Map (bits) Port Map (a3b3a3b0r3, a3b1r4_r, a3b3a3b0r3a3b1r4);
    Add22 : AddModMersenne Generic Map (bits) Port Map (a3b3a3b0r3a3b1r4, a3b2r5_r, c3);
    
end Behavioral;