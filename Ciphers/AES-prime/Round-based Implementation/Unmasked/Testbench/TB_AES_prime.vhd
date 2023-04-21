library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity TB_AES_prime is
end TB_AES_prime;

architecture Behavioral of TB_AES_prime is

    component AES_prime is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               plaintext : in AES_prime_state;
               key : in AES_prime_state;
               ciphertext : out AES_prime_state;
               done : out STD_LOGIC);
    end component;
    
    signal clk, rst, done : STD_LOGIC;
    constant clk_period : time := 10ns;
    signal plaintext, key, ciphertext : AES_prime_state;
begin

    UUT: AES_prime Port Map (clk, rst, plaintext, key, ciphertext, done);

    clk_proc: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    stim_proc: process
    begin
        rst <= '1';
        plaintext(0) <= "1010010"; -- 0x52
        plaintext(1) <= "0110000"; -- 0x30
        plaintext(2) <= "0110100"; -- 0x34
        plaintext(3) <= "1100111"; -- 0x67
        plaintext(4) <= "0110111"; -- 0x37
        plaintext(5) <= "0001101"; -- 0x0d
        plaintext(6) <= "0001110"; -- 0x0e
        plaintext(7) <= "0100111"; -- 0x27
        plaintext(8) <= "0100100"; -- 0x24
        plaintext(9) <= "1010111"; -- 0x57
        plaintext(10) <= "1001000"; -- 0x48
        plaintext(11) <= "1100010"; -- 0x62
        plaintext(12) <= "1111011"; -- 0x7b
        plaintext(13) <= "1101111"; -- 0x6f
        plaintext(14) <= "1111011"; -- 0x7b
        plaintext(15) <= "0011001"; -- 0x19
    
        key(0) <= "0101101"; -- 0x2d
        key(1) <= "1100000"; -- 0x60
        key(2) <= "0000101"; -- 0x05
        key(3) <= "1101101"; -- 0x6d
        key(4) <= "0111011"; -- 0x3b
        key(5) <= "0101110"; -- 0x2e
        key(6) <= "0001100"; -- 0x0c
        key(7) <= "0011110"; -- 0x1e
        key(8) <= "0010101"; -- 0x15
        key(9) <= "0101010"; -- 0x2a
        key(10) <= "1101011"; -- 0x6b
        key(11) <= "1010101"; -- 0x55
        key(12) <= "0000111"; -- 0x07
        key(13) <= "0010001"; -- 0x11
        key(14) <= "0010000"; -- 0x10
        key(15) <= "0100110"; -- 0x26
        
        wait for 2*clk_period;
        
        rst <= '0';
        
        wait until done = '1';
        
        if (ciphertext(0) = "0001111" and
            ciphertext(1) = "0110101" and
            ciphertext(2) = "0010001" and
            ciphertext(3) = "1011010" and
            ciphertext(4) = "1010110" and
            ciphertext(5) = "1111110" and
            ciphertext(6) = "1000001" and
            ciphertext(7) = "1011110" and
            ciphertext(8) = "0010000" and
            ciphertext(9) = "0110101" and
            ciphertext(10) = "0001000" and
            ciphertext(11) = "0000111" and
            ciphertext(12) = "1111110" and
            ciphertext(13) = "0011111" and
            ciphertext(14) = "1011110" and
            ciphertext(15) = "0011111") then
            report "SUCCESS";
        else
            report "FAILURE";
        end if;
        
        wait;
    end process;

end Behavioral;
