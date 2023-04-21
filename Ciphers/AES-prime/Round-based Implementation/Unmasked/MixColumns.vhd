library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity MixColumns is
    Port ( input : in AES_prime_state;
           output : out AES_prime_state);
end MixColumns;

architecture Behavioral of MixColumns is

    component AddModMersenne is
        Generic ( bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : in UNSIGNED (bits-1 downto 0);
               c : out UNSIGNED (bits-1 downto 0));
    end component;

    signal input_m2, input_m4, input_m16, tmp1, tmp2 : AES_prime_state;
    
begin

    -- Mul 2
    ROT2: for i in 0 to 15 generate
        input_m2(i) <= input(i)(5 downto 0) & input(i)(6);
    end generate;

    -- Mul 4
    ROT4: for i in 0 to 15 generate
        input_m4(i) <= input_m2(i)(5 downto 0) & input_m2(i)(6);
    end generate;

    -- Mul 16
    ROT16: for i in 0 to 15 generate
        input_m16(i) <= input_m4(i)(4 downto 0) & input_m4(i)(6 downto 5);
    end generate;

    -- Column 0
    O00_1: AddModMersenne Generic Map (7) Port Map (input(0), input(1), tmp1(0));
    O00_2: AddModMersenne Generic Map (7) Port Map (tmp1(0), input(2), tmp2(0));
    O00_3: AddModMersenne Generic Map (7) Port Map (tmp2(0), input(3), output(0));
    O01_1: AddModMersenne Generic Map (7) Port Map (input(0), input_m2(1), tmp1(1));
    O01_2: AddModMersenne Generic Map (7) Port Map (tmp1(1), input_m4(2), tmp2(1));
    O01_3: AddModMersenne Generic Map (7) Port Map (tmp2(1), input_m16(3), output(1));
    O02_1: AddModMersenne Generic Map (7) Port Map (input(0), input_m4(1), tmp1(2));
    O02_2: AddModMersenne Generic Map (7) Port Map (tmp1(2), input_m16(2), tmp2(2));
    O02_3: AddModMersenne Generic Map (7) Port Map (tmp2(2), input_m2(3), output(2));
    O03_1: AddModMersenne Generic Map (7) Port Map (input(0), input_m16(1), tmp1(3));
    O03_2: AddModMersenne Generic Map (7) Port Map (tmp1(3), input_m2(2), tmp2(3));
    O03_3: AddModMersenne Generic Map (7) Port Map (tmp2(3), input_m4(3), output(3));

    -- Column 1
    O10_1: AddModMersenne Generic Map (7) Port Map (input(4), input(5), tmp1(4));
    O10_2: AddModMersenne Generic Map (7) Port Map (tmp1(4), input(6), tmp2(4));
    O10_3: AddModMersenne Generic Map (7) Port Map (tmp2(4), input(7), output(4));
    O11_1: AddModMersenne Generic Map (7) Port Map (input(4), input_m2(5), tmp1(5));
    O11_2: AddModMersenne Generic Map (7) Port Map (tmp1(5), input_m4(6), tmp2(5));
    O11_3: AddModMersenne Generic Map (7) Port Map (tmp2(5), input_m16(7), output(5));
    O12_1: AddModMersenne Generic Map (7) Port Map (input(4), input_m4(5), tmp1(6));
    O12_2: AddModMersenne Generic Map (7) Port Map (tmp1(6), input_m16(6), tmp2(6));
    O12_3: AddModMersenne Generic Map (7) Port Map (tmp2(6), input_m2(7), output(6));
    O13_1: AddModMersenne Generic Map (7) Port Map (input(4), input_m16(5), tmp1(7));
    O13_2: AddModMersenne Generic Map (7) Port Map (tmp1(7), input_m2(6), tmp2(7));
    O13_3: AddModMersenne Generic Map (7) Port Map (tmp2(7), input_m4(7), output(7));

    -- Column 2
    O20_1: AddModMersenne Generic Map (7) Port Map (input(8), input(9), tmp1(8));
    O20_2: AddModMersenne Generic Map (7) Port Map (tmp1(8), input(10), tmp2(8));
    O20_3: AddModMersenne Generic Map (7) Port Map (tmp2(8), input(11), output(8));
    O21_1: AddModMersenne Generic Map (7) Port Map (input(8), input_m2(9), tmp1(9));
    O21_2: AddModMersenne Generic Map (7) Port Map (tmp1(9), input_m4(10), tmp2(9));
    O21_3: AddModMersenne Generic Map (7) Port Map (tmp2(9), input_m16(11), output(9));
    O22_1: AddModMersenne Generic Map (7) Port Map (input(8), input_m4(9), tmp1(10));
    O22_2: AddModMersenne Generic Map (7) Port Map (tmp1(10), input_m16(10), tmp2(10));
    O22_3: AddModMersenne Generic Map (7) Port Map (tmp2(10), input_m2(11), output(10));
    O23_1: AddModMersenne Generic Map (7) Port Map (input(8), input_m16(9), tmp1(11));
    O23_2: AddModMersenne Generic Map (7) Port Map (tmp1(11), input_m2(10), tmp2(11));
    O23_3: AddModMersenne Generic Map (7) Port Map (tmp2(11), input_m4(11), output(11));
    
    -- Column 3
    O30_1: AddModMersenne Generic Map (7) Port Map (input(12), input(13), tmp1(12));
    O30_2: AddModMersenne Generic Map (7) Port Map (tmp1(12), input(14), tmp2(12));
    O30_3: AddModMersenne Generic Map (7) Port Map (tmp2(12), input(15), output(12));
    O31_1: AddModMersenne Generic Map (7) Port Map (input(12), input_m2(13), tmp1(13));
    O31_2: AddModMersenne Generic Map (7) Port Map (tmp1(13), input_m4(14), tmp2(13));
    O31_3: AddModMersenne Generic Map (7) Port Map (tmp2(13), input_m16(15), output(13));
    O32_1: AddModMersenne Generic Map (7) Port Map (input(12), input_m4(13), tmp1(14));
    O32_2: AddModMersenne Generic Map (7) Port Map (tmp1(14), input_m16(14), tmp2(14));
    O32_3: AddModMersenne Generic Map (7) Port Map (tmp2(14), input_m2(15), output(14));
    O33_1: AddModMersenne Generic Map (7) Port Map (input(12), input_m16(13), tmp1(15));
    O33_2: AddModMersenne Generic Map (7) Port Map (tmp1(15), input_m2(14), tmp2(15));
    O33_3: AddModMersenne Generic Map (7) Port Map (tmp2(15), input_m4(15), output(15));

end Behavioral;