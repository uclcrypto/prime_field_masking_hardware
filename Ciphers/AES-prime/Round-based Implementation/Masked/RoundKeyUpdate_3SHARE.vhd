library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity RoundKeyUpdate_3SHARE is
    Port ( clk : in STD_LOGIC;
           rcon_in : in UNSIGNED (6 downto 0);
           input_share0 : in AES_prime_state;
           input_share1 : in AES_prime_state;
           input_share2 : in AES_prime_state;
           randomness : UNSIGNED (363 downto 0);
           rcon_out : out UNSIGNED (6 downto 0);
           output_share0 : out AES_prime_state;
           output_share1 : out AES_prime_state;
           output_share2 : out AES_prime_state);
end RoundKeyUpdate_3SHARE;

architecture Behavioral of RoundKeyUpdate_3SHARE is

    component SBOX_3SHARE is
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
               d0 : out UNSIGNED (bits-1 downto 0);
               d1 : out UNSIGNED (bits-1 downto 0);
               d2 : out UNSIGNED (bits-1 downto 0));
    end component;

    component AddModMersenne is
        Generic ( bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : in UNSIGNED (bits-1 downto 0);
               c : out UNSIGNED (bits-1 downto 0));
    end component;

    signal rcon_x2, tmp : UNSIGNED (6 downto 0);
    signal w_share0, w_share1, w_share2, input_reg1_share0, input_reg1_share1, input_reg1_share2, input_reg2_share0, input_reg2_share1, input_reg2_share2, input_reg3_share0, input_reg3_share1, input_reg3_share2, input_reg4_share0, input_reg4_share1, input_reg4_share2 : AES_prime_state;

begin
            
    Input_Reg: process(clk)
    begin
        if rising_edge(clk) then
            input_reg1_share0 <= input_share0;
            input_reg1_share1 <= input_share1;
            input_reg1_share2 <= input_share2;
            input_reg2_share0 <= input_reg1_share0;
            input_reg2_share1 <= input_reg1_share1;
            input_reg2_share2 <= input_reg1_share2;
            input_reg3_share0 <= input_reg2_share0;
            input_reg3_share1 <= input_reg2_share1;
            input_reg3_share2 <= input_reg2_share2;
            input_reg4_share0 <= input_reg3_share0;
            input_reg4_share1 <= input_reg3_share1;
            input_reg4_share2 <= input_reg3_share2;
        end if;
    end process;
    
    -- Sbox and rotation of word
    SB1: SBOX_3SHARE Port Map (clk, input_share0(12), input_share1(12), input_share2(12), randomness(363 downto 357), randomness(356 downto 350), randomness(349 downto 343), randomness(342 downto 336), randomness(335 downto 329), randomness(328 downto 322), randomness(321 downto 315), randomness(314 downto 308), randomness(307 downto 301), randomness(300 downto 294), randomness(293 downto 287), randomness(286 downto 280), randomness(279 downto 273), w_share0(3), w_share1(3), w_share2(3));
    SB2: SBOX_3SHARE Port Map (clk, input_share0(13), input_share1(13), input_share2(13), randomness(272 downto 266), randomness(265 downto 259), randomness(258 downto 252), randomness(251 downto 245), randomness(244 downto 238), randomness(237 downto 231), randomness(230 downto 224), randomness(223 downto 217), randomness(216 downto 210), randomness(209 downto 203), randomness(202 downto 196), randomness(195 downto 189), randomness(188 downto 182), tmp, w_share1(0), w_share2(0));
    SB3: SBOX_3SHARE Port Map (clk, input_share0(14), input_share1(14), input_share2(14), randomness(181 downto 175), randomness(174 downto 168), randomness(167 downto 161), randomness(160 downto 154), randomness(153 downto 147), randomness(146 downto 140), randomness(139 downto 133), randomness(132 downto 126), randomness(125 downto 119), randomness(118 downto 112), randomness(111 downto 105), randomness(104 downto 98), randomness(97 downto 91), w_share0(1), w_share1(1), w_share2(1));
    SB4: SBOX_3SHARE Port Map (clk, input_share0(15), input_share1(15), input_share2(15), randomness(90 downto 84), randomness(83 downto 77), randomness(76 downto 70), randomness(69 downto 63), randomness(62 downto 56), randomness(55 downto 49), randomness(48 downto 42), randomness(41 downto 35), randomness(34 downto 28), randomness(27 downto 21), randomness(20 downto 14), randomness(13 downto 7), randomness(6 downto 0), w_share0(2), w_share1(2), w_share2(2));
    
    rcon_x2 <= rcon_in(5 downto 0) & rcon_in(6);
    ADD1: AddModMersenne Generic Map (7) Port Map (rcon_in, tmp, w_share0(0));
    ADD2: AddModMersenne Generic Map (7) Port Map (rcon_in, rcon_x2, rcon_out);
    
    ADD_o: for i in 0 to 3 generate
        ADD_i: for j in 0 to 2 generate
            ADDs_i0: AddModMersenne Generic Map (7) Port Map (input_reg4_share0(i+j*4), w_share0(i+j*4), w_share0(i+(j+1)*4));
            ADDs_i1: AddModMersenne Generic Map (7) Port Map (input_reg4_share1(i+j*4), w_share1(i+j*4), w_share1(i+(j+1)*4));
            ADDs_i2: AddModMersenne Generic Map (7) Port Map (input_reg4_share2(i+j*4), w_share2(i+j*4), w_share2(i+(j+1)*4));
            output_share0(i+j*4) <= w_share0(i+(j+1)*4);
            output_share1(i+j*4) <= w_share1(i+(j+1)*4);
            output_share2(i+j*4) <= w_share2(i+(j+1)*4);
        end generate;
        ADDs_o0: AddModMersenne Generic Map (7) Port Map (input_reg4_share0(i+12), w_share0(i+12), output_share0(i+12));
        ADDs_o1: AddModMersenne Generic Map (7) Port Map (input_reg4_share1(i+12), w_share1(i+12), output_share1(i+12));
        ADDs_o2: AddModMersenne Generic Map (7) Port Map (input_reg4_share2(i+12), w_share2(i+12), output_share2(i+12));
    end generate;

end Behavioral;
