library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SBOX_4SHARE_HPC1 is
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
           r30 : in UNSIGNED (bits-1 downto 0);
           r31 : in UNSIGNED (bits-1 downto 0);
           r32 : in UNSIGNED (bits-1 downto 0);
           r33 : in UNSIGNED (bits-1 downto 0);
           d0 : out UNSIGNED (bits-1 downto 0);
           d1 : out UNSIGNED (bits-1 downto 0);
           d2 : out UNSIGNED (bits-1 downto 0);
           d3 : out UNSIGNED (bits-1 downto 0));
end SBOX_4SHARE_HPC1;

architecture Behavioral of SBOX_4SHARE_HPC1 is

    component SQ_4SHARE is
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
    end component;
        
    component HPC1_4SHARE is
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
    end component;
        
    component FF is
		  Generic ( bits : positive := 7);
		  Port ( clk : in STD_LOGIC;
				   input : in UNSIGNED ((bits-1) downto 0);
				   output : out UNSIGNED ((bits-1) downto 0));
	 end component;
	 
    component AddModMersenne is
        Generic ( bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : in UNSIGNED (bits-1 downto 0);
               c : out UNSIGNED (bits-1 downto 0));
    end component;
    
    signal b0_rr, b1_rr, b2_rr, b3_rr, r12_r, r12_rr, r13_r, r13_rr, r14_r, r14_rr, r15_r, r15_rr, r16_r, r16_rr, r17_r, r17_rr, r18_r, r18_rr, r19_r, r19_rr, r20_r, r20_rr, r21_r, r21_rr, r22_r, r22_rr, r23_r, r23_rr, r24_r, r24_rr, r25_r, r25_rr, r26_r, r26_rr, r27_r, r27_rr, r28_r, r28_rr, r29_r, r29_rr, r30_r, r30_rr, r31_r, r31_rr, r32_r, r32_rr, r33_r, r33_rr, a0_r, a0_rr, a1_r, a1_rr, a2_r, a2_rr, a3_r, a3_rr, c0_rrrr, c1_rrrr, c2_rrrr, c3_rrrr, r24_rrr, r24_rrrr, r25_rrr, r25_rrrr, r26_rrr, r26_rrrr, r27_rrr, r27_rrrr, r28_rrr, r28_rrrr, r29_rrr, r29_rrrr, r30_rrr, r31_rrr, r32_rrr, r33_rrr, a0_rrr, a1_rrr, a2_rrr, a3_rrr, d0_rrrrrr, d1_rrrrrr, d2_rrrrrr, d3_rrrrrr, d0c : UNSIGNED (bits-1 downto 0);
    constant c : UNSIGNED (bits-1 downto 0) := (bits-1 downto 2 => '0') & "10";
     
begin
	 
    -- SQ 1
    Squ1: SQ_4SHARE Generic Map (bits) Port Map (clk, a0, a1, a2, a3, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, b0_rr, b1_rr, b2_rr, b3_rr);
    FF1 : FF Generic Map (bits) Port Map (clk, r12, r12_r);
    FF2 : FF Generic Map (bits) Port Map (clk, r12_r, r12_rr);
    FF3 : FF Generic Map (bits) Port Map (clk, r13, r13_r);
    FF4 : FF Generic Map (bits) Port Map (clk, r13_r, r13_rr);
    FF5 : FF Generic Map (bits) Port Map (clk, r14, r14_r);
    FF6 : FF Generic Map (bits) Port Map (clk, r14_r, r14_rr);
    FF7 : FF Generic Map (bits) Port Map (clk, r15, r15_r);
    FF8 : FF Generic Map (bits) Port Map (clk, r15_r, r15_rr);
    FF9 : FF Generic Map (bits) Port Map (clk, r16, r16_r);
    FF10 : FF Generic Map (bits) Port Map (clk, r16_r, r16_rr);
    FF11 : FF Generic Map (bits) Port Map (clk, r17, r17_r);
    FF12 : FF Generic Map (bits) Port Map (clk, r17_r, r17_rr);
    FF13 : FF Generic Map (bits) Port Map (clk, r18, r18_r);
    FF14 : FF Generic Map (bits) Port Map (clk, r18_r, r18_rr);
    FF15 : FF Generic Map (bits) Port Map (clk, r19, r19_r);
    FF16 : FF Generic Map (bits) Port Map (clk, r19_r, r19_rr);
    FF17 : FF Generic Map (bits) Port Map (clk, r20, r20_r);
    FF18 : FF Generic Map (bits) Port Map (clk, r20_r, r20_rr);
    FF19 : FF Generic Map (bits) Port Map (clk, r21, r21_r);
    FF20 : FF Generic Map (bits) Port Map (clk, r21_r, r21_rr);
    FF21 : FF Generic Map (bits) Port Map (clk, r22, r22_r);
    FF22 : FF Generic Map (bits) Port Map (clk, r22_r, r22_rr);
    FF23 : FF Generic Map (bits) Port Map (clk, r23, r23_r);
    FF24 : FF Generic Map (bits) Port Map (clk, r23_r, r23_rr);
    FF25 : FF Generic Map (bits) Port Map (clk, r24, r24_r);
    FF26 : FF Generic Map (bits) Port Map (clk, r24_r, r24_rr);
    FF27 : FF Generic Map (bits) Port Map (clk, r25, r25_r);
    FF28 : FF Generic Map (bits) Port Map (clk, r25_r, r25_rr);
    FF29 : FF Generic Map (bits) Port Map (clk, r26, r26_r);
    FF30 : FF Generic Map (bits) Port Map (clk, r26_r, r26_rr);
    FF31 : FF Generic Map (bits) Port Map (clk, r27, r27_r);
    FF32 : FF Generic Map (bits) Port Map (clk, r27_r, r27_rr);
    FF33 : FF Generic Map (bits) Port Map (clk, r28, r28_r);
    FF34 : FF Generic Map (bits) Port Map (clk, r28_r, r28_rr);
    FF35 : FF Generic Map (bits) Port Map (clk, r29, r29_r);
    FF36 : FF Generic Map (bits) Port Map (clk, r29_r, r29_rr);
    FF37 : FF Generic Map (bits) Port Map (clk, r30, r30_r);
    FF38 : FF Generic Map (bits) Port Map (clk, r30_r, r30_rr);
    FF39 : FF Generic Map (bits) Port Map (clk, r31, r31_r);
    FF40 : FF Generic Map (bits) Port Map (clk, r31_r, r31_rr);
    FF41 : FF Generic Map (bits) Port Map (clk, r32, r32_r);
    FF42 : FF Generic Map (bits) Port Map (clk, r32_r, r32_rr);
    FF43 : FF Generic Map (bits) Port Map (clk, r33, r33_r);
    FF44 : FF Generic Map (bits) Port Map (clk, r33_r, r33_rr);
    FF45 : FF Generic Map (bits) Port Map (clk, a0, a0_r);
    FF46 : FF Generic Map (bits) Port Map (clk, a0_r, a0_rr);
    FF47 : FF Generic Map (bits) Port Map (clk, a1, a1_r);
    FF48 : FF Generic Map (bits) Port Map (clk, a1_r, a1_rr);
    FF49 : FF Generic Map (bits) Port Map (clk, a2, a2_r);
    FF50 : FF Generic Map (bits) Port Map (clk, a2_r, a2_rr);
    FF51 : FF Generic Map (bits) Port Map (clk, a3, a3_r);
    FF52 : FF Generic Map (bits) Port Map (clk, a3_r, a3_rr);
    
    -- SQ 1
    Squ2: SQ_4SHARE Generic Map (bits) Port Map (clk, b0_rr, b1_rr, b2_rr, b3_rr, r12_rr, r13_rr, r14_rr, r15_rr, r16_rr, r17_rr, r18_rr, r19_rr, r20_rr, r21_rr, r22_rr, r23_rr, c0_rrrr, c1_rrrr, c2_rrrr, c3_rrrr);
    FF53 : FF Generic Map (bits) Port Map (clk, r24_rr, r24_rrr);
    FF54 : FF Generic Map (bits) Port Map (clk, r24_rrr, r24_rrrr);
    FF55 : FF Generic Map (bits) Port Map (clk, r25_rr, r25_rrr);
    FF56 : FF Generic Map (bits) Port Map (clk, r25_rrr, r25_rrrr);
    FF57 : FF Generic Map (bits) Port Map (clk, r26_rr, r26_rrr);
    FF58 : FF Generic Map (bits) Port Map (clk, r26_rrr, r26_rrrr);
    FF59 : FF Generic Map (bits) Port Map (clk, r27_rr, r27_rrr);
    FF60 : FF Generic Map (bits) Port Map (clk, r27_rrr, r27_rrrr);
    FF61 : FF Generic Map (bits) Port Map (clk, r28_rr, r28_rrr);
    FF62 : FF Generic Map (bits) Port Map (clk, r28_rrr, r28_rrrr);
    FF63 : FF Generic Map (bits) Port Map (clk, r29_rr, r29_rrr);
    FF64 : FF Generic Map (bits) Port Map (clk, r29_rrr, r29_rrrr);
    FF65 : FF Generic Map (bits) Port Map (clk, r30_rr, r30_rrr);
    FF66 : FF Generic Map (bits) Port Map (clk, r31_rr, r31_rrr);
    FF67 : FF Generic Map (bits) Port Map (clk, r32_rr, r32_rrr);
    FF68 : FF Generic Map (bits) Port Map (clk, r33_rr, r33_rrr);
    FF69 : FF Generic Map (bits) Port Map (clk, a0_rr, a0_rrr);
    FF70 : FF Generic Map (bits) Port Map (clk, a1_rr, a1_rrr);
    FF71 : FF Generic Map (bits) Port Map (clk, a2_rr, a2_rrr);
    FF72 : FF Generic Map (bits) Port Map (clk, a3_rr, a3_rrr);
    
    -- MUL
    Mul1: HPC1_4SHARE Generic Map (bits) Port Map (clk, c0_rrrr, c1_rrrr, c2_rrrr, c3_rrrr, a0_rrr, a1_rrr, a2_rrr, a3_rrr, r24_rrrr, r25_rrrr, r26_rrrr, r27_rrrr, r28_rrrr, r29_rrrr, r30_rrr, r31_rrr, r32_rrr, r33_rrr, d0_rrrrrr, d1_rrrrrr, d2_rrrrrr, d3_rrrrrr);
	 
    -- ADD c
    Add1 : AddModMersenne Generic Map (bits) Port Map (d0_rrrrrr, c, d0c);
 
	 -- OUT
    d0 <= d0c;
    d1 <= d1_rrrrrr;
    d2 <= d2_rrrrrr;
    d3 <= d3_rrrrrr;

end Behavioral;
