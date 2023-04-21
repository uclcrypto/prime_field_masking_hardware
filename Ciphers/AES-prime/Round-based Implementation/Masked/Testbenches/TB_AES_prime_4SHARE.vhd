library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity TB_AES_prime_4SHARE is
end TB_AES_prime_4SHARE;

architecture Behavioral of TB_AES_prime_4SHARE is

    component AES_prime_4SHARE is
        Port ( clk : in STD_LOGIC;
               rst : in STD_LOGIC;
               plaintext_share0 : in AES_prime_state;
               plaintext_share1 : in AES_prime_state;
               plaintext_share2 : in AES_prime_state;
               plaintext_share3 : in AES_prime_state;
               randomness : UNSIGNED (4199 downto 0);
               key_share0 : in AES_prime_state;
               key_share1 : in AES_prime_state;
               key_share2 : in AES_prime_state;
               key_share3 : in AES_prime_state;
               ciphertext_share0 : out AES_prime_state;
               ciphertext_share1 : out AES_prime_state;
               ciphertext_share2 : out AES_prime_state;
               ciphertext_share3 : out AES_prime_state;
               done : out STD_LOGIC);
    end component;
    
    component AddModMersenne is
        Generic ( bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : in UNSIGNED (bits-1 downto 0);
               c : out UNSIGNED (bits-1 downto 0));
    end component;
    
    component AddModMersenneNoP is
        Generic ( bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : in UNSIGNED (bits-1 downto 0);
               c : out UNSIGNED (bits-1 downto 0));
    end component;
    
    signal clk, rst, done : STD_LOGIC;
    constant clk_period : time := 10ns;
    signal ciphertext, ciphertext12, ciphertext123, plaintext_share0, plaintext_share1, plaintext_share2, plaintext_share3, key_share0, key_share1, key_share2, key_share3, ciphertext_share0, ciphertext_share1, ciphertext_share2, ciphertext_share3 : AES_prime_state;
    signal randomness : UNSIGNED (4199 downto 0);
    
begin

    UUT: AES_prime_4SHARE Port Map (clk, rst, plaintext_share0, plaintext_share1, plaintext_share2, plaintext_share3, randomness, key_share0, key_share1, key_share2, key_share3, ciphertext_share0, ciphertext_share1, ciphertext_share2, ciphertext_share3, done);

    Unmask: for i in 0 to 15 generate
        ADD0s : AddModMersenne Generic Map (7) Port Map (ciphertext_share0(i), ciphertext_share1(i), ciphertext12(i));
        ADD1s : AddModMersenne Generic Map (7) Port Map (ciphertext12(i), ciphertext_share2(i), ciphertext123(i));
        ADD2s : AddModMersenneNoP Generic Map (7) Port Map (ciphertext123(i), ciphertext_share3(i), ciphertext(i));
    end generate;

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
        plaintext_share0(0) <= "1010010"; -- 0x52
        plaintext_share0(1) <= "0110000"; -- 0x30
        plaintext_share0(2) <= "0110100"; -- 0x34
        plaintext_share0(3) <= "1100111"; -- 0x67
        plaintext_share0(4) <= "0110111"; -- 0x37
        plaintext_share0(5) <= "0001101"; -- 0x0d
        plaintext_share0(6) <= "0001110"; -- 0x0e
        plaintext_share0(7) <= "0100111"; -- 0x27
        plaintext_share0(8) <= "0100100"; -- 0x24
        plaintext_share0(9) <= "1010111"; -- 0x57
        plaintext_share0(10) <= "1001000"; -- 0x48
        plaintext_share0(11) <= "1100010"; -- 0x62
        plaintext_share0(12) <= "1111011"; -- 0x7b
        plaintext_share0(13) <= "1101111"; -- 0x6f
        plaintext_share0(14) <= "1111011"; -- 0x7b
        plaintext_share0(15) <= "0011001"; -- 0x19
        
        plaintext_share1(0) <= "0000000"; -- 0x00
        plaintext_share1(1) <= "0000000"; -- 0x00
        plaintext_share1(2) <= "0000000"; -- 0x00
        plaintext_share1(3) <= "0000000"; -- 0x00
        plaintext_share1(4) <= "0000000"; -- 0x00
        plaintext_share1(5) <= "0000000"; -- 0x00
        plaintext_share1(6) <= "0000000"; -- 0x00
        plaintext_share1(7) <= "0000000"; -- 0x00
        plaintext_share1(8) <= "0000000"; -- 0x00
        plaintext_share1(9) <= "0000000"; -- 0x00
        plaintext_share1(10) <= "0000000"; -- 0x00
        plaintext_share1(11) <= "0000000"; -- 0x00
        plaintext_share1(12) <= "0000000"; -- 0x00
        plaintext_share1(13) <= "0000000"; -- 0x00
        plaintext_share1(14) <= "0000000"; -- 0x00
        plaintext_share1(15) <= "0000000"; -- 0x00
        
        plaintext_share2(0) <= "0000000"; -- 0x00
        plaintext_share2(1) <= "0000000"; -- 0x00
        plaintext_share2(2) <= "0000000"; -- 0x00
        plaintext_share2(3) <= "0000000"; -- 0x00
        plaintext_share2(4) <= "0000000"; -- 0x00
        plaintext_share2(5) <= "0000000"; -- 0x00
        plaintext_share2(6) <= "0000000"; -- 0x00
        plaintext_share2(7) <= "0000000"; -- 0x00
        plaintext_share2(8) <= "0000000"; -- 0x00
        plaintext_share2(9) <= "0000000"; -- 0x00
        plaintext_share2(10) <= "0000000"; -- 0x00
        plaintext_share2(11) <= "0000000"; -- 0x00
        plaintext_share2(12) <= "0000000"; -- 0x00
        plaintext_share2(13) <= "0000000"; -- 0x00
        plaintext_share2(14) <= "0000000"; -- 0x00
        plaintext_share2(15) <= "0000000"; -- 0x00
        
        plaintext_share3(0) <= "0000000"; -- 0x00
        plaintext_share3(1) <= "0000000"; -- 0x00
        plaintext_share3(2) <= "0000000"; -- 0x00
        plaintext_share3(3) <= "0000000"; -- 0x00
        plaintext_share3(4) <= "0000000"; -- 0x00
        plaintext_share3(5) <= "0000000"; -- 0x00
        plaintext_share3(6) <= "0000000"; -- 0x00
        plaintext_share3(7) <= "0000000"; -- 0x00
        plaintext_share3(8) <= "0000000"; -- 0x00
        plaintext_share3(9) <= "0000000"; -- 0x00
        plaintext_share3(10) <= "0000000"; -- 0x00
        plaintext_share3(11) <= "0000000"; -- 0x00
        plaintext_share3(12) <= "0000000"; -- 0x00
        plaintext_share3(13) <= "0000000"; -- 0x00
        plaintext_share3(14) <= "0000000"; -- 0x00
        plaintext_share3(15) <= "0000000"; -- 0x00
   
        key_share0(0) <= "0101101"; -- 0x2d
        key_share0(1) <= "1100000"; -- 0x60
        key_share0(2) <= "0000101"; -- 0x05
        key_share0(3) <= "1101101"; -- 0x6d
        key_share0(4) <= "0111011"; -- 0x3b
        key_share0(5) <= "0101110"; -- 0x2e
        key_share0(6) <= "0001100"; -- 0x0c
        key_share0(7) <= "0011110"; -- 0x1e
        key_share0(8) <= "0010101"; -- 0x15
        key_share0(9) <= "0101010"; -- 0x2a
        key_share0(10) <= "1101011"; -- 0x6b
        key_share0(11) <= "1010101"; -- 0x55
        key_share0(12) <= "0000111"; -- 0x07
        key_share0(13) <= "0010001"; -- 0x11
        key_share0(14) <= "0010000"; -- 0x10
        key_share0(15) <= "0100110"; -- 0x26
        
        key_share1(0) <= "0000000"; -- 0x00
        key_share1(1) <= "0000000"; -- 0x00
        key_share1(2) <= "0000000"; -- 0x00
        key_share1(3) <= "0000000"; -- 0x00
        key_share1(4) <= "0000000"; -- 0x00
        key_share1(5) <= "0000000"; -- 0x00
        key_share1(6) <= "0000000"; -- 0x00
        key_share1(7) <= "0000000"; -- 0x00
        key_share1(8) <= "0000000"; -- 0x00
        key_share1(9) <= "0000000"; -- 0x00
        key_share1(10) <= "0000000"; -- 0x00
        key_share1(11) <= "0000000"; -- 0x00
        key_share1(12) <= "0000000"; -- 0x00
        key_share1(13) <= "0000000"; -- 0x00
        key_share1(14) <= "0000000"; -- 0x00
        key_share1(15) <= "0000000"; -- 0x00
        
        key_share2(0) <= "0000000"; -- 0x00
        key_share2(1) <= "0000000"; -- 0x00
        key_share2(2) <= "0000000"; -- 0x00
        key_share2(3) <= "0000000"; -- 0x00
        key_share2(4) <= "0000000"; -- 0x00
        key_share2(5) <= "0000000"; -- 0x00
        key_share2(6) <= "0000000"; -- 0x00
        key_share2(7) <= "0000000"; -- 0x00
        key_share2(8) <= "0000000"; -- 0x00
        key_share2(9) <= "0000000"; -- 0x00
        key_share2(10) <= "0000000"; -- 0x00
        key_share2(11) <= "0000000"; -- 0x00
        key_share2(12) <= "0000000"; -- 0x00
        key_share2(13) <= "0000000"; -- 0x00
        key_share2(14) <= "0000000"; -- 0x00
        key_share2(15) <= "0000000"; -- 0x00
        
        key_share3(0) <= "0000000"; -- 0x00
        key_share3(1) <= "0000000"; -- 0x00
        key_share3(2) <= "0000000"; -- 0x00
        key_share3(3) <= "0000000"; -- 0x00
        key_share3(4) <= "0000000"; -- 0x00
        key_share3(5) <= "0000000"; -- 0x00
        key_share3(6) <= "0000000"; -- 0x00
        key_share3(7) <= "0000000"; -- 0x00
        key_share3(8) <= "0000000"; -- 0x00
        key_share3(9) <= "0000000"; -- 0x00
        key_share3(10) <= "0000000"; -- 0x00
        key_share3(11) <= "0000000"; -- 0x00
        key_share3(12) <= "0000000"; -- 0x00
        key_share3(13) <= "0000000"; -- 0x00
        key_share3(14) <= "0000000"; -- 0x00
        key_share3(15) <= "0000000"; -- 0x00
        
        -- never set 7 bits in a row
        randomness <= x"001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344556677889900112233445566778899001122334455667788990011223344";
        
        wait for 6*clk_period;
        
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
