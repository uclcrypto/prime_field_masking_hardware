library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SQ_4SHARE is
    Generic (bits : INTEGER := 7);
    Port ( clk : in STD_LOGIC;
           a0 : in UNSIGNED (bits-1 downto 0);
           a1 : in UNSIGNED (bits-1 downto 0);
           a2 : in UNSIGNED (bits-1 downto 0);
           a3 : in UNSIGNED (bits-1 downto 0);
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
           r10 : in UNSIGNED (bits-1 downto 0);
           r11 : in UNSIGNED (bits-1 downto 0);
           b0 : out UNSIGNED (bits-1 downto 0);
           b1 : out UNSIGNED (bits-1 downto 0);
           b2 : out UNSIGNED (bits-1 downto 0);
           b3 : out UNSIGNED (bits-1 downto 0));
end SQ_4SHARE;

architecture Behavioral of SQ_4SHARE is

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
                   
    component SquModMersenne is
        Generic (bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
              b : out UNSIGNED (bits-1 downto 0));
    end component;
    
    component FF is
        Generic ( bits : INTEGER := 7);
        Port ( clk : in STD_LOGIC;
               input : in UNSIGNED ((bits-1) downto 0);
               output : out UNSIGNED ((bits-1) downto 0));
    end component;
    
    signal a02, a12, a22, a32, a12r0, a22r1, a32r2, a22r3, a32r4, a32r5, r0r1, r0s, a0r0s, r1s, a1r1s, a2r2s, a0r0sa0, a1r1sa1, a2r2sa2, a3r3sa3, a12r0_r, a22r1_r, a32r2_r, a22r3_r, a32r4_r, a32r5_r, a12r0a0, a22r1a0, a32r2a0, a22r3a1, a32r4a1, a32r5a2, a12r0a0r6, a22r1a0r7, a32r2a0r8, a22r3a1r9, a32r4a1r10, a32r5a2r11, a12r0a0r6_r, a22r1a0r7_r, a32r2a0r8_r, a22r3a1r9_r, a32r4a1r10_r, a32r5a2r11_r, a0r0sa0a12r0a0r6, a22r1a0r7a32r2a0r8, a1r1sa1a22r3a1r9, a32r4a1r10r6, a2r2sa2a32r5a2r11, r7r9, a3r3sa3r8, r10r11 : UNSIGNED (bits-1 downto 0);
    
begin
    
    a02 <= a0(bits-2 downto 0) & a0(bits-1);
    a12 <= a1(bits-2 downto 0) & a1(bits-1);
    a22 <= a2(bits-2 downto 0) & a2(bits-1);
    a32 <= a3(bits-2 downto 0) & a3(bits-1);
    Add1 : AddModMersenne Generic Map (bits) Port Map (a12, r0, a12r0);
    Add2 : AddModMersenne Generic Map (bits) Port Map (a22, r1, a22r1);
    Add3 : AddModMersenne Generic Map (bits) Port Map (a32, r2, a32r2);
    Add4 : AddModMersenne Generic Map (bits) Port Map (a22, r3, a22r3);
    Add5 : AddModMersenne Generic Map (bits) Port Map (a32, r4, a32r4);
    Add6 : AddModMersenne Generic Map (bits) Port Map (a32, r5, a32r5);
    Add7 : AddModMersenne Generic Map (bits) Port Map (r0, r1, r0r1);
    Add8 : AddModMersenne Generic Map (bits) Port Map (r0r1, r2, r0s);
    Sub1 : SubModMersenne Generic Map (bits) Port Map (a0, r0s, a0r0s);
    Add9 : AddModMersenne Generic Map (bits) Port Map (r3, r4, r1s);
    Sub2 : SubModMersenne Generic Map (bits) Port Map (a1, r1s, a1r1s);
    Sub3 : SubModMersenne Generic Map (bits) Port Map (a2, r5, a2r2s);
    Mul1 : MulModMersenne Generic Map (bits) Port Map (a0r0s, a0, a0r0sa0);
    Mul2 : MulModMersenne Generic Map (bits) Port Map (a1r1s, a1, a1r1sa1);
    Mul3 : MulModMersenne Generic Map (bits) Port Map (a2r2s, a2, a2r2sa2);
    Squ1 : SquModMersenne Generic Map (bits) Port Map (a3, a3r3sa3);
    
    FF1 : FF Generic Map (bits) Port Map (clk, a12r0, a12r0_r);
    FF2 : FF Generic Map (bits) Port Map (clk, a22r1, a22r1_r);
    FF3 : FF Generic Map (bits) Port Map (clk, a32r2, a32r2_r);
    FF4 : FF Generic Map (bits) Port Map (clk, a22r3, a22r3_r);
    FF5 : FF Generic Map (bits) Port Map (clk, a32r4, a32r4_r);
    FF6 : FF Generic Map (bits) Port Map (clk, a32r5, a32r5_r);
    
    Mul4 : MulModMersenne Generic Map (bits) Port Map (a12r0_r, a0, a12r0a0);
    Mul5 : MulModMersenne Generic Map (bits) Port Map (a22r1_r, a0, a22r1a0);
    Mul6 : MulModMersenne Generic Map (bits) Port Map (a32r2_r, a0, a32r2a0);
    Mul7 : MulModMersenne Generic Map (bits) Port Map (a22r3_r, a1, a22r3a1);
    Mul8 : MulModMersenne Generic Map (bits) Port Map (a32r4_r, a1, a32r4a1);
    Mul9 : MulModMersenne Generic Map (bits) Port Map (a32r5_r, a2, a32r5a2);
    Add10 : AddModMersenne Generic Map (bits) Port Map (a12r0a0, r6, a12r0a0r6);
    Add11 : AddModMersenne Generic Map (bits) Port Map (a22r1a0, r7, a22r1a0r7);
    Add12 : AddModMersenne Generic Map (bits) Port Map (a32r2a0, r8, a32r2a0r8);
    Add13 : AddModMersenne Generic Map (bits) Port Map (a22r3a1, r9, a22r3a1r9);
    Add14 : AddModMersenne Generic Map (bits) Port Map (a32r4a1, r10, a32r4a1r10);
    Add15 : AddModMersenne Generic Map (bits) Port Map (a32r5a2, r11, a32r5a2r11);
    
    FF7 : FF Generic Map (bits) Port Map (clk, a12r0a0r6, a12r0a0r6_r);
    FF8 : FF Generic Map (bits) Port Map (clk, a22r1a0r7, a22r1a0r7_r);
    FF9 : FF Generic Map (bits) Port Map (clk, a32r2a0r8, a32r2a0r8_r);
    FF10 : FF Generic Map (bits) Port Map (clk, a22r3a1r9, a22r3a1r9_r);
    FF11 : FF Generic Map (bits) Port Map (clk, a32r4a1r10, a32r4a1r10_r);
    FF12 : FF Generic Map (bits) Port Map (clk, a32r5a2r11, a32r5a2r11_r);
    
    Add16 : AddModMersenne Generic Map (bits) Port Map (a0r0sa0, a12r0a0r6_r, a0r0sa0a12r0a0r6);
    Add17 : AddModMersenne Generic Map (bits) Port Map (a22r1a0r7_r, a32r2a0r8_r, a22r1a0r7a32r2a0r8);
    Add18 : AddModMersenne Generic Map (bits) Port Map (a0r0sa0a12r0a0r6, a22r1a0r7a32r2a0r8, b0);
    Add19 : AddModMersenne Generic Map (bits) Port Map (a1r1sa1, a22r3a1r9_r, a1r1sa1a22r3a1r9);
    Sub4 : SubModMersenne Generic Map (bits) Port Map (a32r4a1r10_r, r6, a32r4a1r10r6);
    Add20 : AddModMersenne Generic Map (bits) Port Map (a1r1sa1a22r3a1r9, a32r4a1r10r6, b1);
    Add21 : AddModMersenne Generic Map (bits) Port Map (a2r2sa2, a32r5a2r11_r, a2r2sa2a32r5a2r11);
    Add22 : AddModMersenne Generic Map (bits) Port Map (r7, r9, r7r9);
    Sub5 : SubModMersenne Generic Map (bits) Port Map (a2r2sa2a32r5a2r11, r7r9, b2);
    Sub6 : SubModMersenne Generic Map (bits) Port Map (a3r3sa3, r8, a3r3sa3r8);
    Add23 : AddModMersenne Generic Map (bits) Port Map (r10, r11, r10r11);
    Sub7 : SubModMersenne Generic Map (bits) Port Map (a3r3sa3r8, r10r11, b3);

end Behavioral;