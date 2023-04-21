library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SBOX_4SHARE is
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
           r12 : in UNSIGNED (bits-1 downto 0);
           r13 : in UNSIGNED (bits-1 downto 0);
           r14 : in UNSIGNED (bits-1 downto 0);
           r15 : in UNSIGNED (bits-1 downto 0);
           r16 : in UNSIGNED (bits-1 downto 0);
           r17 : in UNSIGNED (bits-1 downto 0);
           r18 : in UNSIGNED (bits-1 downto 0);
           r19 : in UNSIGNED (bits-1 downto 0);
           r20 : in UNSIGNED (bits-1 downto 0);
           r21 : in UNSIGNED (bits-1 downto 0);
           r22 : in UNSIGNED (bits-1 downto 0);
           r23 : in UNSIGNED (bits-1 downto 0);
           r24 : in UNSIGNED (bits-1 downto 0);
           r25 : in UNSIGNED (bits-1 downto 0);
           r26 : in UNSIGNED (bits-1 downto 0);
           r27 : in UNSIGNED (bits-1 downto 0);
           r28 : in UNSIGNED (bits-1 downto 0);
           r29 : in UNSIGNED (bits-1 downto 0);
           d0 : out UNSIGNED (bits-1 downto 0);
           d1 : out UNSIGNED (bits-1 downto 0);
           d2 : out UNSIGNED (bits-1 downto 0);
           d3 : out UNSIGNED (bits-1 downto 0));
end SBOX_4SHARE;

architecture Behavioral of SBOX_4SHARE is

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
        Generic ( bits : positive := 7);
        Port ( clk : in STD_LOGIC;
               input : in UNSIGNED ((bits-1) downto 0);
               output : out UNSIGNED ((bits-1) downto 0));
    end component;
    
    signal a02, a12, a22, a32, a12r0, a22r1, a32r2, a22r3, a32r4, a32r5, r0r1, r0s, a0r0s, r1s, a1r1s, a2r2s, a0_r, a1_r, a2_r, a3_r, r6_r, r7_r, r8_r, r9_r, r10_r, r11_r, r12_r, r13_r, r14_r, r15_r, r16_r, r17_r, r18_r, r19_r, r20_r, r21_r, r22_r, r23_r, r24_r, r25_r, r26_r, r27_r, r28_r, r29_r, a12r0_r, a22r1_r, a32r2_r, a22r3_r, a32r4_r, a32r5_r, a0r0s_r, a1r1s_r, a2r2s_r, a0r0sa0, a1r1sa1, a2r2sa2, a3r3sa3, a12r0a0, a22r1a0, a32r2a0, a22r3a1, a32r4a1, a32r5a2, a12r0a0r6, a22r1a0r7, a32r2a0r8, a22r3a1r9, a32r4a1r10, a32r5a2r11, a0_rr, a1_rr, a2_rr, a3_rr, r6_rr, r7_rr, r8_rr, r9_rr, r10_rr, r11_rr, r12_rr, r13_rr, r14_rr, r15_rr, r16_rr, r17_rr, r18_rr, r19_rr, r20_rr, r21_rr, r22_rr, r23_rr, r24_rr, r25_rr, r26_rr, r27_rr, r28_rr, r29_rr, a12r0a0r6_rr, a22r1a0r7_rr, a32r2a0r8_rr, a22r3a1r9_rr, a32r4a1r10_rr, a32r5a2r11_rr, a0r0sa0_rr, a1r1sa1_rr, a2r2sa2_rr, a3r3sa3_rr, a0r0sa0a12r0a0r6, a22r1a0r7a32r2a0r8, b0_rr, a1r1sa1a22r3a1r9, a32r4a1r10r6, b1_rr, a2r2sa2a32r5a2r11, r7r8, b2_rr, a3r3sa3r9, r10r11, b3_rr: UNSIGNED (bits-1 downto 0);
    signal b02, b12, b22, b32, b12r12, b22r13, b32r14, b22r15, b32r16, b32r17, r12r13, r4s, b0r4s, r5s, b1r5s, b2r6s, a0_rrr, a1_rrr, a2_rrr, a3_rrr, r18_rrr, r19_rrr, r20_rrr, r21_rrr, r22_rrr, r23_rrr, r24_rrr, r25_rrr, r26_rrr, r27_rrr, r28_rrr, r29_rrr, b12r12_rrr, b22r13_rrr, b32r14_rrr, b22r15_rrr, b32r16_rrr, b32r17_rrr, b0r4s_rrr, b1r5s_rrr, b2r6s_rrr, b0r4sb0, b1r5sb1, b2r6sb2, b3r7sb3, b12r12b0, b22r13b0, b32r14b0, b22r15b1, b32r16b1, b32r17b2, b12r12b0r18, b22r13b0r19, b32r14b0r20, b22r15b1r21, b32r16b1r22, b32r17b2r23, a0_rrrr, a1_rrrr, a2_rrrr, a3_rrrr, b0_rrr, b1_rrr, b2_rrr, b3_rrr, r18_rrrr, r19_rrrr, r20_rrrr, r21_rrrr, r22_rrrr, r23_rrrr, r24_rrrr, r25_rrrr, r26_rrrr, r27_rrrr, r28_rrrr, r29_rrrr, b12r12b0r18_rrrr, b22r13b0r19_rrrr, b32r14b0r20_rrrr, b22r15b1r21_rrrr, b32r16b1r22_rrrr, b32r17b2r23_rrrr, b0r4sb0_rrrr, b1r5sb1_rrrr, b2r6sb2_rrrr, b3r7sb3_rrrr, b0r4sb0b12r12b0r18, b22r13b0r19b32r14b0r20, c0_rrrr, b1r5sb1b22r15b1r21, b32r16b1r22r18, c1_rrrr, b2r6sb2b32r17b2r23, r19r20, c2_rrrr, b3r7sb3r21, r22r23, c3_rrrr : UNSIGNED (bits-1 downto 0);
    signal a0c0, a0c1, a0c2, a0c3, a1c0, a1c1, a1c2, a1c3, a2c0, a2c1, a2c2, a2c3, a3c0, a3c1, a3c2, a3c3, a0c1r24, a0c2r25, a0c3r27, a1c0r24, a1c2r26, a1c3r28, a2c0r25, a2c1r26, a2c3r29, a3c0r27, a3c1r28, a3c2r29, a0c0_rrrrr, a0c1r24_rrrrr, a0c2r25_rrrrr, a0c3r27_rrrrr, a1c0r24_rrrrr, a1c1_rrrrr, a1c2r26_rrrrr, a1c3r28_rrrrr, a2c0r25_rrrrr, a2c1r26_rrrrr, a2c2_rrrrr, a2c3r29_rrrrr, a3c0r27_rrrrr, a3c1r28_rrrrr, a3c2r29_rrrrr, a3c3_rrrrr, a0c0a0c1r24, a0c0a0c1r24a0c2r25, d0_rrrrr, a1c1a1c0r24, a1c1a1c0r24a1c2r26, d1_rrrrr, a2c2a2c0r25, a2c2a2c0r25a2c1r26, d2_rrrrr, a3c3a3c0r27, a3c3a3c0r27a3c1r28, d3_rrrrr, d0c : UNSIGNED (bits-1 downto 0);
    constant c : UNSIGNED (bits-1 downto 0) := (bits-1 downto 2 => '0') & "10";

begin

    -- SQ 1
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
    
    FF1 : FF Generic Map (bits) Port Map (clk, a0, a0_r);
    FF2 : FF Generic Map (bits) Port Map (clk, a1, a1_r);
    FF3 : FF Generic Map (bits) Port Map (clk, a2, a2_r);
    FF4 : FF Generic Map (bits) Port Map (clk, a3, a3_r);
    FF5 : FF Generic Map (bits) Port Map (clk, r6, r6_r);
    FF6 : FF Generic Map (bits) Port Map (clk, r7, r7_r);
    FF7 : FF Generic Map (bits) Port Map (clk, r8, r8_r);
    FF8 : FF Generic Map (bits) Port Map (clk, r9, r9_r);
    FF9 : FF Generic Map (bits) Port Map (clk, r10, r10_r);
    FF10 : FF Generic Map (bits) Port Map (clk, r11, r11_r);
    FF11 : FF Generic Map (bits) Port Map (clk, r12, r12_r);
    FF12 : FF Generic Map (bits) Port Map (clk, r13, r13_r);
    FF13 : FF Generic Map (bits) Port Map (clk, r14, r14_r);
    FF14 : FF Generic Map (bits) Port Map (clk, r15, r15_r);
    FF15 : FF Generic Map (bits) Port Map (clk, r16, r16_r);
    FF16 : FF Generic Map (bits) Port Map (clk, r17, r17_r);
    FF17 : FF Generic Map (bits) Port Map (clk, r18, r18_r);
    FF18 : FF Generic Map (bits) Port Map (clk, r19, r19_r);
    FF19 : FF Generic Map (bits) Port Map (clk, r20, r20_r);
    FF20 : FF Generic Map (bits) Port Map (clk, r21, r21_r);
    FF21 : FF Generic Map (bits) Port Map (clk, r22, r22_r);
    FF22 : FF Generic Map (bits) Port Map (clk, r23, r23_r);
    FF23 : FF Generic Map (bits) Port Map (clk, r24, r24_r);
    FF24 : FF Generic Map (bits) Port Map (clk, r25, r25_r);
    FF25 : FF Generic Map (bits) Port Map (clk, r26, r26_r);
    FF26 : FF Generic Map (bits) Port Map (clk, r27, r27_r);
    FF27 : FF Generic Map (bits) Port Map (clk, r28, r28_r);
    FF28 : FF Generic Map (bits) Port Map (clk, r29, r29_r);
    FF29 : FF Generic Map (bits) Port Map (clk, a12r0, a12r0_r);
    FF30 : FF Generic Map (bits) Port Map (clk, a22r1, a22r1_r);
    FF31 : FF Generic Map (bits) Port Map (clk, a32r2, a32r2_r);
    FF32 : FF Generic Map (bits) Port Map (clk, a22r3, a22r3_r);
    FF33 : FF Generic Map (bits) Port Map (clk, a32r4, a32r4_r);
    FF34 : FF Generic Map (bits) Port Map (clk, a32r5, a32r5_r);
    FF35 : FF Generic Map (bits) Port Map (clk, a0r0s, a0r0s_r);
    FF36 : FF Generic Map (bits) Port Map (clk, a1r1s, a1r1s_r);
    FF37 : FF Generic Map (bits) Port Map (clk, a2r2s, a2r2s_r);
    
    Mul1 : MulModMersenne Generic Map (bits) Port Map (a0r0s_r, a0_r, a0r0sa0);
    Mul2 : MulModMersenne Generic Map (bits) Port Map (a1r1s_r, a1_r, a1r1sa1);
    Mul3 : MulModMersenne Generic Map (bits) Port Map (a2r2s_r, a2_r, a2r2sa2);
    Squ1 : SquModMersenne Generic Map (bits) Port Map (a3_r, a3r3sa3);
    Mul4 : MulModMersenne Generic Map (bits) Port Map (a12r0_r, a0_r, a12r0a0);
    Mul5 : MulModMersenne Generic Map (bits) Port Map (a22r1_r, a0_r, a22r1a0);
    Mul6 : MulModMersenne Generic Map (bits) Port Map (a32r2_r, a0_r, a32r2a0);
    Mul7 : MulModMersenne Generic Map (bits) Port Map (a22r3_r, a1_r, a22r3a1);
    Mul8 : MulModMersenne Generic Map (bits) Port Map (a32r4_r, a1_r, a32r4a1);
    Mul9 : MulModMersenne Generic Map (bits) Port Map (a32r5_r, a2_r, a32r5a2);
    Add10 : AddModMersenne Generic Map (bits) Port Map (a12r0a0, r6_r, a12r0a0r6);
    Add11 : AddModMersenne Generic Map (bits) Port Map (a22r1a0, r7_r, a22r1a0r7);
    Add12 : AddModMersenne Generic Map (bits) Port Map (a32r2a0, r8_r, a32r2a0r8);
    Add13 : AddModMersenne Generic Map (bits) Port Map (a22r3a1, r9_r, a22r3a1r9);
    Add14 : AddModMersenne Generic Map (bits) Port Map (a32r4a1, r10_r, a32r4a1r10);
    Add15 : AddModMersenne Generic Map (bits) Port Map (a32r5a2, r11_r, a32r5a2r11);
    
    FF38 : FF Generic Map (bits) Port Map (clk, a0_r, a0_rr);
    FF39 : FF Generic Map (bits) Port Map (clk, a1_r, a1_rr);
    FF40 : FF Generic Map (bits) Port Map (clk, a2_r, a2_rr);
    FF41 : FF Generic Map (bits) Port Map (clk, a3_r, a3_rr);
    FF42 : FF Generic Map (bits) Port Map (clk, r6_r, r6_rr);
    FF43 : FF Generic Map (bits) Port Map (clk, r7_r, r7_rr);
    FF44 : FF Generic Map (bits) Port Map (clk, r8_r, r8_rr);
    FF45 : FF Generic Map (bits) Port Map (clk, r9_r, r9_rr);
    FF46 : FF Generic Map (bits) Port Map (clk, r10_r, r10_rr);
    FF47 : FF Generic Map (bits) Port Map (clk, r11_r, r11_rr);
    FF48 : FF Generic Map (bits) Port Map (clk, r12_r, r12_rr);
    FF49 : FF Generic Map (bits) Port Map (clk, r13_r, r13_rr);
    FF50 : FF Generic Map (bits) Port Map (clk, r14_r, r14_rr);
    FF51 : FF Generic Map (bits) Port Map (clk, r15_r, r15_rr);
    FF52 : FF Generic Map (bits) Port Map (clk, r16_r, r16_rr);
    FF53 : FF Generic Map (bits) Port Map (clk, r17_r, r17_rr);
    FF54 : FF Generic Map (bits) Port Map (clk, r18_r, r18_rr);
    FF55 : FF Generic Map (bits) Port Map (clk, r19_r, r19_rr);
    FF56 : FF Generic Map (bits) Port Map (clk, r20_r, r20_rr);
    FF57 : FF Generic Map (bits) Port Map (clk, r21_r, r21_rr);
    FF58 : FF Generic Map (bits) Port Map (clk, r22_r, r22_rr);
    FF59 : FF Generic Map (bits) Port Map (clk, r23_r, r23_rr);
    FF60 : FF Generic Map (bits) Port Map (clk, r24_r, r24_rr);
    FF61 : FF Generic Map (bits) Port Map (clk, r25_r, r25_rr);
    FF62 : FF Generic Map (bits) Port Map (clk, r26_r, r26_rr);
    FF63 : FF Generic Map (bits) Port Map (clk, r27_r, r27_rr);
    FF64 : FF Generic Map (bits) Port Map (clk, r28_r, r28_rr);
    FF65 : FF Generic Map (bits) Port Map (clk, r29_r, r29_rr);
    FF66 : FF Generic Map (bits) Port Map (clk, a12r0a0r6, a12r0a0r6_rr);
    FF67 : FF Generic Map (bits) Port Map (clk, a22r1a0r7, a22r1a0r7_rr);
    FF68 : FF Generic Map (bits) Port Map (clk, a32r2a0r8, a32r2a0r8_rr);
    FF69 : FF Generic Map (bits) Port Map (clk, a22r3a1r9, a22r3a1r9_rr);
    FF70 : FF Generic Map (bits) Port Map (clk, a32r4a1r10, a32r4a1r10_rr);
    FF71 : FF Generic Map (bits) Port Map (clk, a32r5a2r11, a32r5a2r11_rr);
    FF72 : FF Generic Map (bits) Port Map (clk, a0r0sa0, a0r0sa0_rr);
    FF73 : FF Generic Map (bits) Port Map (clk, a1r1sa1, a1r1sa1_rr);
    FF74 : FF Generic Map (bits) Port Map (clk, a2r2sa2, a2r2sa2_rr);
    FF75 : FF Generic Map (bits) Port Map (clk, a3r3sa3, a3r3sa3_rr);
    
    Add16 : AddModMersenne Generic Map (bits) Port Map (a0r0sa0_rr, a12r0a0r6_rr, a0r0sa0a12r0a0r6);
    Add17 : AddModMersenne Generic Map (bits) Port Map (a22r1a0r7_rr, a32r2a0r8_rr, a22r1a0r7a32r2a0r8);
    Add18 : AddModMersenne Generic Map (bits) Port Map (a0r0sa0a12r0a0r6, a22r1a0r7a32r2a0r8, b0_rr);
    Add19 : AddModMersenne Generic Map (bits) Port Map (a1r1sa1_rr, a22r3a1r9_rr, a1r1sa1a22r3a1r9);
    Sub4 : SubModMersenne Generic Map (bits) Port Map (a32r4a1r10_rr, r6_rr, a32r4a1r10r6);
    Add20 : AddModMersenne Generic Map (bits) Port Map (a1r1sa1a22r3a1r9, a32r4a1r10r6, b1_rr);
    Add21 : AddModMersenne Generic Map (bits) Port Map (a2r2sa2_rr, a32r5a2r11_rr, a2r2sa2a32r5a2r11);
    Add22 : AddModMersenne Generic Map (bits) Port Map (r7_rr, r8_rr, r7r8);
    Sub5 : SubModMersenne Generic Map (bits) Port Map (a2r2sa2a32r5a2r11, r7r8, b2_rr);
    Sub6 : SubModMersenne Generic Map (bits) Port Map (a3r3sa3_rr, r9_rr, a3r3sa3r9);
    Add23 : AddModMersenne Generic Map (bits) Port Map (r10_rr, r11_rr, r10r11);
    Sub7 : SubModMersenne Generic Map (bits) Port Map (a3r3sa3r9, r10r11, b3_rr);
     
    -- SQ 2
    b12 <= b1_rr(bits-2 downto 0) & b1_rr(bits-1);
    b22 <= b2_rr(bits-2 downto 0) & b2_rr(bits-1);
    b32 <= b3_rr(bits-2 downto 0) & b3_rr(bits-1);
    Add24 : AddModMersenne Generic Map (bits) Port Map (b12, r12_rr, b12r12);
    Add25 : AddModMersenne Generic Map (bits) Port Map (b22, r13_rr, b22r13);
    Add26 : AddModMersenne Generic Map (bits) Port Map (b32, r14_rr, b32r14);
    Add27 : AddModMersenne Generic Map (bits) Port Map (b22, r15_rr, b22r15);
    Add28 : AddModMersenne Generic Map (bits) Port Map (b32, r16_rr, b32r16);
    Add29 : AddModMersenne Generic Map (bits) Port Map (b32, r17_rr, b32r17);
    Add30 : AddModMersenne Generic Map (bits) Port Map (r12_rr, r13_rr, r12r13);
    Add31 : AddModMersenne Generic Map (bits) Port Map (r12r13, r14_rr, r4s);
    Sub8 : SubModMersenne Generic Map (bits) Port Map (b0_rr, r4s, b0r4s);
    Add32 : AddModMersenne Generic Map (bits) Port Map (r15_rr, r16_rr, r5s);
    Sub9 : SubModMersenne Generic Map (bits) Port Map (b1_rr, r5s, b1r5s);
    Sub10 : SubModMersenne Generic Map (bits) Port Map (b2_rr, r17_rr, b2r6s);
    
    FF76 : FF Generic Map (bits) Port Map (clk, a0_rr, a0_rrr);
    FF77 : FF Generic Map (bits) Port Map (clk, a1_rr, a1_rrr);
    FF78 : FF Generic Map (bits) Port Map (clk, a2_rr, a2_rrr);
    FF79 : FF Generic Map (bits) Port Map (clk, a3_rr, a3_rrr);
    FF80 : FF Generic Map (bits) Port Map (clk, b0_rr, b0_rrr);
    FF81 : FF Generic Map (bits) Port Map (clk, b1_rr, b1_rrr);
    FF82 : FF Generic Map (bits) Port Map (clk, b2_rr, b2_rrr);
    FF83 : FF Generic Map (bits) Port Map (clk, b3_rr, b3_rrr);
    FF84 : FF Generic Map (bits) Port Map (clk, r18_rr, r18_rrr);
    FF85 : FF Generic Map (bits) Port Map (clk, r19_rr, r19_rrr);
    FF86 : FF Generic Map (bits) Port Map (clk, r20_rr, r20_rrr);
    FF87 : FF Generic Map (bits) Port Map (clk, r21_rr, r21_rrr);
    FF88 : FF Generic Map (bits) Port Map (clk, r22_rr, r22_rrr);
    FF89 : FF Generic Map (bits) Port Map (clk, r23_rr, r23_rrr);
    FF90 : FF Generic Map (bits) Port Map (clk, r24_rr, r24_rrr);
    FF91 : FF Generic Map (bits) Port Map (clk, r25_rr, r25_rrr);
    FF92 : FF Generic Map (bits) Port Map (clk, r26_rr, r26_rrr);
    FF93 : FF Generic Map (bits) Port Map (clk, r27_rr, r27_rrr);
    FF94 : FF Generic Map (bits) Port Map (clk, r28_rr, r28_rrr);
    FF95 : FF Generic Map (bits) Port Map (clk, r29_rr, r29_rrr);
    FF96 : FF Generic Map (bits) Port Map (clk, b12r12, b12r12_rrr);
    FF97 : FF Generic Map (bits) Port Map (clk, b22r13, b22r13_rrr);
    FF98 : FF Generic Map (bits) Port Map (clk, b32r14, b32r14_rrr);
    FF99 : FF Generic Map (bits) Port Map (clk, b22r15, b22r15_rrr);
    FF100 : FF Generic Map (bits) Port Map (clk, b32r16, b32r16_rrr);
    FF101 : FF Generic Map (bits) Port Map (clk, b32r17, b32r17_rrr);
    FF102 : FF Generic Map (bits) Port Map (clk, b0r4s, b0r4s_rrr);
    FF103 : FF Generic Map (bits) Port Map (clk, b1r5s, b1r5s_rrr);
    FF104 : FF Generic Map (bits) Port Map (clk, b2r6s, b2r6s_rrr);
    
    Mul10 : MulModMersenne Generic Map (bits) Port Map (b0r4s_rrr, b0_rrr, b0r4sb0);
    Mul11 : MulModMersenne Generic Map (bits) Port Map (b1r5s_rrr, b1_rrr, b1r5sb1);
    Mul12 : MulModMersenne Generic Map (bits) Port Map (b2r6s_rrr, b2_rrr, b2r6sb2);
    Squ2 : SquModMersenne Generic Map (bits) Port Map (b3_rrr, b3r7sb3);
    Mul13 : MulModMersenne Generic Map (bits) Port Map (b12r12_rrr, b0_rrr, b12r12b0);
    Mul14 : MulModMersenne Generic Map (bits) Port Map (b22r13_rrr, b0_rrr, b22r13b0);
    Mul15 : MulModMersenne Generic Map (bits) Port Map (b32r14_rrr, b0_rrr, b32r14b0);
    Mul16 : MulModMersenne Generic Map (bits) Port Map (b22r15_rrr, b1_rrr, b22r15b1);
    Mul17 : MulModMersenne Generic Map (bits) Port Map (b32r16_rrr, b1_rrr, b32r16b1);
    Mul18 : MulModMersenne Generic Map (bits) Port Map (b32r17_rrr, b2_rrr, b32r17b2);
    Add33 : AddModMersenne Generic Map (bits) Port Map (b12r12b0, r18_rrr, b12r12b0r18);
    Add34 : AddModMersenne Generic Map (bits) Port Map (b22r13b0, r19_rrr, b22r13b0r19);
    Add35 : AddModMersenne Generic Map (bits) Port Map (b32r14b0, r20_rrr, b32r14b0r20);
    Add36 : AddModMersenne Generic Map (bits) Port Map (b22r15b1, r21_rrr, b22r15b1r21);
    Add37 : AddModMersenne Generic Map (bits) Port Map (b32r16b1, r22_rrr, b32r16b1r22);
    Add38 : AddModMersenne Generic Map (bits) Port Map (b32r17b2, r23_rrr, b32r17b2r23);
    
    FF105 : FF Generic Map (bits) Port Map (clk, a0_rrr, a0_rrrr);
    FF106 : FF Generic Map (bits) Port Map (clk, a1_rrr, a1_rrrr);
    FF107 : FF Generic Map (bits) Port Map (clk, a2_rrr, a2_rrrr);
    FF108 : FF Generic Map (bits) Port Map (clk, a3_rrr, a3_rrrr);
    FF109 : FF Generic Map (bits) Port Map (clk, r18_rrr, r18_rrrr);
    FF110 : FF Generic Map (bits) Port Map (clk, r19_rrr, r19_rrrr);
    FF111 : FF Generic Map (bits) Port Map (clk, r20_rrr, r20_rrrr);
    FF112 : FF Generic Map (bits) Port Map (clk, r21_rrr, r21_rrrr);
    FF113 : FF Generic Map (bits) Port Map (clk, r22_rrr, r22_rrrr);
    FF114 : FF Generic Map (bits) Port Map (clk, r23_rrr, r23_rrrr);
    FF115 : FF Generic Map (bits) Port Map (clk, r24_rrr, r24_rrrr);
    FF116 : FF Generic Map (bits) Port Map (clk, r25_rrr, r25_rrrr);
    FF117 : FF Generic Map (bits) Port Map (clk, r26_rrr, r26_rrrr);
    FF118 : FF Generic Map (bits) Port Map (clk, r27_rrr, r27_rrrr);
    FF119 : FF Generic Map (bits) Port Map (clk, r28_rrr, r28_rrrr);
    FF120 : FF Generic Map (bits) Port Map (clk, r29_rrr, r29_rrrr);
    FF121 : FF Generic Map (bits) Port Map (clk, b12r12b0r18, b12r12b0r18_rrrr);
    FF122 : FF Generic Map (bits) Port Map (clk, b22r13b0r19, b22r13b0r19_rrrr);
    FF123 : FF Generic Map (bits) Port Map (clk, b32r14b0r20, b32r14b0r20_rrrr);
    FF124 : FF Generic Map (bits) Port Map (clk, b22r15b1r21, b22r15b1r21_rrrr);
    FF125 : FF Generic Map (bits) Port Map (clk, b32r16b1r22, b32r16b1r22_rrrr);
    FF126 : FF Generic Map (bits) Port Map (clk, b32r17b2r23, b32r17b2r23_rrrr);
    FF127 : FF Generic Map (bits) Port Map (clk, b0r4sb0, b0r4sb0_rrrr);
    FF128 : FF Generic Map (bits) Port Map (clk, b1r5sb1, b1r5sb1_rrrr);
    FF129 : FF Generic Map (bits) Port Map (clk, b2r6sb2, b2r6sb2_rrrr);
    FF130 : FF Generic Map (bits) Port Map (clk, b3r7sb3, b3r7sb3_rrrr);
    
    Add39 : AddModMersenne Generic Map (bits) Port Map (b0r4sb0_rrrr, b12r12b0r18_rrrr, b0r4sb0b12r12b0r18);
    Add40 : AddModMersenne Generic Map (bits) Port Map (b22r13b0r19_rrrr, b32r14b0r20_rrrr, b22r13b0r19b32r14b0r20);
    Add41 : AddModMersenne Generic Map (bits) Port Map (b0r4sb0b12r12b0r18, b22r13b0r19b32r14b0r20, c0_rrrr);
    Add42 : AddModMersenne Generic Map (bits) Port Map (b1r5sb1_rrrr, b22r15b1r21_rrrr, b1r5sb1b22r15b1r21);
    Sub11 : SubModMersenne Generic Map (bits) Port Map (b32r16b1r22_rrrr, r18_rrrr, b32r16b1r22r18);
    Add43 : AddModMersenne Generic Map (bits) Port Map (b1r5sb1b22r15b1r21, b32r16b1r22r18, c1_rrrr);
    Add44 : AddModMersenne Generic Map (bits) Port Map (b2r6sb2_rrrr, b32r17b2r23_rrrr, b2r6sb2b32r17b2r23);
    Add45 : AddModMersenne Generic Map (bits) Port Map (r19_rrrr, r20_rrrr, r19r20);
    Sub12 : SubModMersenne Generic Map (bits) Port Map (b2r6sb2b32r17b2r23, r19r20, c2_rrrr);
    Sub13 : SubModMersenne Generic Map (bits) Port Map (b3r7sb3_rrrr, r21_rrrr, b3r7sb3r21);
    Add46 : AddModMersenne Generic Map (bits) Port Map (r22_rrrr, r23_rrrr, r22r23);
    Sub14 : SubModMersenne Generic Map (bits) Port Map (b3r7sb3r21, r22r23, c3_rrrr);
    
     -- MUL
    Mul19 : MulModMersenne Generic Map (bits) Port Map (a0_rrrr, c0_rrrr, a0c0);
    Mul20 : MulModMersenne Generic Map (bits) Port Map (a0_rrrr, c1_rrrr, a0c1);
    Mul21 : MulModMersenne Generic Map (bits) Port Map (a0_rrrr, c2_rrrr, a0c2);
    Mul22 : MulModMersenne Generic Map (bits) Port Map (a0_rrrr, c3_rrrr, a0c3);
    Mul23 : MulModMersenne Generic Map (bits) Port Map (a1_rrrr, c0_rrrr, a1c0);
    Mul24 : MulModMersenne Generic Map (bits) Port Map (a1_rrrr, c1_rrrr, a1c1);
    Mul25 : MulModMersenne Generic Map (bits) Port Map (a1_rrrr, c2_rrrr, a1c2);
    Mul26 : MulModMersenne Generic Map (bits) Port Map (a1_rrrr, c3_rrrr, a1c3);
    Mul27 : MulModMersenne Generic Map (bits) Port Map (a2_rrrr, c0_rrrr, a2c0);
    Mul28 : MulModMersenne Generic Map (bits) Port Map (a2_rrrr, c1_rrrr, a2c1);
    Mul29 : MulModMersenne Generic Map (bits) Port Map (a2_rrrr, c2_rrrr, a2c2);
    Mul30 : MulModMersenne Generic Map (bits) Port Map (a2_rrrr, c3_rrrr, a2c3);
    Mul31 : MulModMersenne Generic Map (bits) Port Map (a3_rrrr, c0_rrrr, a3c0);
    Mul32 : MulModMersenne Generic Map (bits) Port Map (a3_rrrr, c1_rrrr, a3c1);
    Mul33 : MulModMersenne Generic Map (bits) Port Map (a3_rrrr, c2_rrrr, a3c2);
    Mul34 : MulModMersenne Generic Map (bits) Port Map (a3_rrrr, c3_rrrr, a3c3);
    Add47 : AddModMersenne Generic Map (bits) Port Map (a0c1, r24_rrrr, a0c1r24);
    Add48 : AddModMersenne Generic Map (bits) Port Map (a0c2, r25_rrrr, a0c2r25);
    Add49 : AddModMersenne Generic Map (bits) Port Map (a0c3, r27_rrrr, a0c3r27);
    Sub15 : SubModMersenne Generic Map (bits) Port Map (a1c0, r24_rrrr, a1c0r24);
    Add50 : AddModMersenne Generic Map (bits) Port Map (a1c2, r26_rrrr, a1c2r26);
    Add51 : AddModMersenne Generic Map (bits) Port Map (a1c3, r28_rrrr, a1c3r28);
    Sub16 : SubModMersenne Generic Map (bits) Port Map (a2c0, r25_rrrr, a2c0r25);
    Sub17 : SubModMersenne Generic Map (bits) Port Map (a2c1, r26_rrrr, a2c1r26);
    Add52 : AddModMersenne Generic Map (bits) Port Map (a2c3, r29_rrrr, a2c3r29);
    Sub18 : SubModMersenne Generic Map (bits) Port Map (a3c0, r27_rrrr, a3c0r27);
    Sub19 : SubModMersenne Generic Map (bits) Port Map (a3c1, r28_rrrr, a3c1r28);
    Sub20 : SubModMersenne Generic Map (bits) Port Map (a3c2, r29_rrrr, a3c2r29);
     
    FF131 : FF Generic Map (bits) Port Map (clk, a0c0, a0c0_rrrrr);
    FF132 : FF Generic Map (bits) Port Map (clk, a0c1r24, a0c1r24_rrrrr);
    FF133 : FF Generic Map (bits) Port Map (clk, a0c2r25, a0c2r25_rrrrr);
    FF134 : FF Generic Map (bits) Port Map (clk, a0c3r27, a0c3r27_rrrrr);
    FF135 : FF Generic Map (bits) Port Map (clk, a1c0r24, a1c0r24_rrrrr);
    FF136 : FF Generic Map (bits) Port Map (clk, a1c1, a1c1_rrrrr);
    FF137 : FF Generic Map (bits) Port Map (clk, a1c2r26, a1c2r26_rrrrr);
    FF138 : FF Generic Map (bits) Port Map (clk, a1c3r28, a1c3r28_rrrrr);
    FF139 : FF Generic Map (bits) Port Map (clk, a2c0r25, a2c0r25_rrrrr);
    FF140 : FF Generic Map (bits) Port Map (clk, a2c1r26, a2c1r26_rrrrr);
    FF141 : FF Generic Map (bits) Port Map (clk, a2c2, a2c2_rrrrr);
    FF142 : FF Generic Map (bits) Port Map (clk, a2c3r29, a2c3r29_rrrrr);
    FF143 : FF Generic Map (bits) Port Map (clk, a3c0r27, a3c0r27_rrrrr);
    FF144 : FF Generic Map (bits) Port Map (clk, a3c1r28, a3c1r28_rrrrr);
    FF145 : FF Generic Map (bits) Port Map (clk, a3c2r29, a3c2r29_rrrrr);
    FF146 : FF Generic Map (bits) Port Map (clk, a3c3, a3c3_rrrrr);
    
    Add53 : AddModMersenne Generic Map (bits) Port Map (a0c0_rrrrr, a0c1r24_rrrrr, a0c0a0c1r24);
    Add54 : AddModMersenne Generic Map (bits) Port Map (a0c0a0c1r24, a0c2r25_rrrrr, a0c0a0c1r24a0c2r25);
    Add55 : AddModMersenne Generic Map (bits) Port Map (a0c0a0c1r24a0c2r25, a0c3r27_rrrrr, d0_rrrrr);
    Add56 : AddModMersenne Generic Map (bits) Port Map (a1c1_rrrrr, a1c0r24_rrrrr, a1c1a1c0r24);
    Add57 : AddModMersenne Generic Map (bits) Port Map (a1c1a1c0r24, a1c2r26_rrrrr, a1c1a1c0r24a1c2r26);
    Add58 : AddModMersenne Generic Map (bits) Port Map (a1c1a1c0r24a1c2r26, a1c3r28_rrrrr, d1_rrrrr);
    Add59 : AddModMersenne Generic Map (bits) Port Map (a2c2_rrrrr, a2c0r25_rrrrr, a2c2a2c0r25);
    Add60 : AddModMersenne Generic Map (bits) Port Map (a2c2a2c0r25, a2c1r26_rrrrr, a2c2a2c0r25a2c1r26);
    Add61 : AddModMersenne Generic Map (bits) Port Map (a2c2a2c0r25a2c1r26, a2c3r29_rrrrr, d2_rrrrr);
    Add62 : AddModMersenne Generic Map (bits) Port Map (a3c3_rrrrr, a3c0r27_rrrrr, a3c3a3c0r27);
    Add63 : AddModMersenne Generic Map (bits) Port Map (a3c3a3c0r27, a3c1r28_rrrrr, a3c3a3c0r27a3c1r28);
    Add64 : AddModMersenne Generic Map (bits) Port Map (a3c3a3c0r27a3c1r28, a3c2r29_rrrrr, d3_rrrrr);
     
    -- ADD c
    Add65 : AddModMersenne Generic Map (bits) Port Map (d0_rrrrr, c, d0c);
	
    -- OUT
    d0 <= d0c;
    d1 <= d1_rrrrr;
    d2 <= d2_rrrrr;
    d3 <= d3_rrrrr;

end Behavioral;