library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SBOX_3SHARE_HPC1 is
    Generic (bits : INTEGER := 7);
    Port ( clk : in STD_LOGIC;
           a0 : in UNSIGNED (bits-1 downto 0);
           a1 : in UNSIGNED (bits-1 downto 0);
           a2 : in UNSIGNED (bits-1 downto 0);
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
           d0 : out UNSIGNED (bits-1 downto 0);
           d1 : out UNSIGNED (bits-1 downto 0);
           d2 : out UNSIGNED (bits-1 downto 0));
end SBOX_3SHARE_HPC1;

architecture Behavioral of SBOX_3SHARE_HPC1 is

    component SQ_3SHARE is
        Generic (bits : INTEGER := 7);
        Port ( clk : in STD_LOGIC;
               a0 : in UNSIGNED (bits-1 downto 0);
               a1 : in UNSIGNED (bits-1 downto 0);
               a2 : in UNSIGNED (bits-1 downto 0);
               r0 : in UNSIGNED (bits-1 downto 0);
               r1 : in UNSIGNED (bits-1 downto 0);
               r2 : in UNSIGNED (bits-1 downto 0);
               r3 : in UNSIGNED (bits-1 downto 0);
               r4 : in UNSIGNED (bits-1 downto 0);
               b0 : out UNSIGNED (bits-1 downto 0);
               b1 : out UNSIGNED (bits-1 downto 0);
               b2 : out UNSIGNED (bits-1 downto 0));
    end component;
    
    component HPC1_3SHARE is
        Generic ( bits : INTEGER := 7);
        Port ( clk : in STD_LOGIC;
               a0 : in UNSIGNED (bits-1 downto 0);
               a1 : in UNSIGNED (bits-1 downto 0);
               a2 : in UNSIGNED (bits-1 downto 0);
               b0 : in UNSIGNED (bits-1 downto 0);
               b1 : in UNSIGNED (bits-1 downto 0);
               b2 : in UNSIGNED (bits-1 downto 0);
               r0 : in UNSIGNED (bits-1 downto 0);
               r1 : in UNSIGNED (bits-1 downto 0);
               r2 : in UNSIGNED (bits-1 downto 0);
               r3 : in UNSIGNED (bits-1 downto 0);
               r4 : in UNSIGNED (bits-1 downto 0);
               c0 : out UNSIGNED (bits-1 downto 0);
               c1 : out UNSIGNED (bits-1 downto 0);
               c2 : out UNSIGNED (bits-1 downto 0));
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
	 
    signal b0_r, b1_r, b2_r, r5_r, r6_r, r7_r, r8_r, r9_r, r10_r, r11_r, r12_r, a0_r, a1_r, a2_r, c0_rr, c1_rr, c2_rr, r10_rr, r11_rr, r12_rr, d0_rrr, d1_rrr, d2_rrr, d0c : UNSIGNED (bits-1 downto 0);
    constant c : UNSIGNED (bits-1 downto 0) := (bits-1 downto 2 => '0') & "10";
     
begin

    -- SQ 1
    Squ1: SQ_3SHARE Generic Map (bits) Port Map (clk, a0, a1, a2, r0, r1, r2, r3, r4, b0_r, b1_r, b2_r);
    FF1 : FF Generic Map (bits) Port Map (clk, r5, r5_r);
    FF2 : FF Generic Map (bits) Port Map (clk, r6, r6_r);
    FF3 : FF Generic Map (bits) Port Map (clk, r7, r7_r);
    FF4 : FF Generic Map (bits) Port Map (clk, r8, r8_r);
    FF5 : FF Generic Map (bits) Port Map (clk, r9, r9_r);
    FF6 : FF Generic Map (bits) Port Map (clk, r10, r10_r);
    FF7 : FF Generic Map (bits) Port Map (clk, r11, r11_r);
    FF8 : FF Generic Map (bits) Port Map (clk, r12, r12_r);
    FF9 : FF Generic Map (bits) Port Map (clk, a0, a0_r);
    FF10 : FF Generic Map (bits) Port Map (clk, a1, a1_r);
    FF11 : FF Generic Map (bits) Port Map (clk, a2, a2_r);
    
    -- SQ 1
    Squ2: SQ_3SHARE Generic Map (bits) Port Map (clk, b0_r, b1_r, b2_r, r5_r, r6_r, r7_r, r8_r, r9_r, c0_rr, c1_rr, c2_rr);
    FF12 : FF Generic Map (bits) Port Map (clk, r10_r, r10_rr);
    FF13 : FF Generic Map (bits) Port Map (clk, r11_r, r11_rr);
    FF14 : FF Generic Map (bits) Port Map (clk, r12_r, r12_rr);
    
    -- MUL
    Mul1: HPC1_3SHARE Generic Map (bits) Port Map (clk, c0_rr, c1_rr, c2_rr, a0_r, a1_r, a2_r, r10_rr, r11_rr, r12_rr, r13, r14, d0_rrr, d1_rrr, d2_rrr);
    
    -- ADD c
    Add1 : AddModMersenne Generic Map (bits) Port Map (d0_rrr, c, d0c);

	 -- OUT
    d0 <= d0c;
    d1 <= d1_rrr;
    d2 <= d2_rrr;
	 
end Behavioral;
