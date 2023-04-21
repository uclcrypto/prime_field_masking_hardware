library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SBOX_2SHARE_HPC1 is
    Generic (bits : INTEGER := 7);
    Port ( clk : in STD_LOGIC;
           a0 : in UNSIGNED (bits-1 downto 0);
           a1 : in UNSIGNED (bits-1 downto 0);
           r0 : in UNSIGNED (bits-1 downto 0);
           r1 : in UNSIGNED (bits-1 downto 0);
           r2 : in UNSIGNED (bits-1 downto 0);
           r3 : in UNSIGNED (bits-1 downto 0);
           r4 : in UNSIGNED (bits-1 downto 0);
           r5 : in UNSIGNED (bits-1 downto 0);
           d0 : out UNSIGNED (bits-1 downto 0);
           d1 : out UNSIGNED (bits-1 downto 0));
end SBOX_2SHARE_HPC1;

architecture Behavioral of SBOX_2SHARE_HPC1 is

    component SQ_2SHARE is
        Generic (bits : INTEGER := 7);
        Port ( clk : in STD_LOGIC;
               a0 : in UNSIGNED (bits-1 downto 0);
               a1 : in UNSIGNED (bits-1 downto 0);
               r0 : in UNSIGNED (bits-1 downto 0);
               r1 : in UNSIGNED (bits-1 downto 0);
               b0 : out UNSIGNED (bits-1 downto 0);
               b1 : out UNSIGNED (bits-1 downto 0));
    end component;
    
    component HPC1_2SHARE is
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
    
	 signal b0_r, b1_r, r2_r, r3_r, r4_r, r5_r, a0_r, a1_r, c0_rr, c1_rr, r4_rr, d0_rrr, d1_rrr, d0c : UNSIGNED (bits-1 downto 0);
     constant c : UNSIGNED (bits-1 downto 0) := (bits-1 downto 2 => '0') & "10";
     
begin

    -- SQ 1
    Squ1: SQ_2SHARE Generic Map (bits) Port Map (clk, a0, a1, r0, r1, b0_r, b1_r);
    FF1 : FF Generic Map (bits) Port Map (clk, r2, r2_r);
    FF2 : FF Generic Map (bits) Port Map (clk, r3, r3_r);
    FF3 : FF Generic Map (bits) Port Map (clk, r4, r4_r);
    FF4 : FF Generic Map (bits) Port Map (clk, r5, r5_r);
    FF5 : FF Generic Map (bits) Port Map (clk, a0, a0_r);
    FF6 : FF Generic Map (bits) Port Map (clk, a1, a1_r);
    
    -- SQ 1
    Squ2: SQ_2SHARE Generic Map (bits) Port Map (clk, b0_r, b1_r, r2_r, r3_r, c0_rr, c1_rr);
    FF7 : FF Generic Map (bits) Port Map (clk, r4_r, r4_rr);
    
    -- MUL
    Mul1: HPC1_2SHARE Generic Map (bits) Port Map (clk, c0_rr, c1_rr, a0_r, a1_r, r4_rr, r5_r, d0_rrr, d1_rrr);
    
    -- ADD c
    Add1 : AddModMersenne Generic Map (bits) Port Map (d0_rrr, c, d0c);

	 -- OUT
    d0 <= d0c;
    d1 <= d1_rrr;
    
end Behavioral;
