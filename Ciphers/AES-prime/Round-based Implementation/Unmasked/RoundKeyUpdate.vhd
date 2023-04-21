library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity RoundKeyUpdate is
    Port ( rcon_in : in UNSIGNED (6 downto 0);
           input : in AES_prime_state;
           rcon_out : out UNSIGNED (6 downto 0);
           output : out AES_prime_state);
end RoundKeyUpdate;

architecture Behavioral of RoundKeyUpdate is

    component Sbox is
        Port ( input : in UNSIGNED (6 downto 0);
               output : out UNSIGNED (6 downto 0));
    end component;

    component AddModMersenne is
        Generic ( bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : in UNSIGNED (bits-1 downto 0);
               c : out UNSIGNED (bits-1 downto 0));
    end component;

    signal rcon_x2, tmp : UNSIGNED (6 downto 0);
    signal w : AES_prime_state;

begin

    -- Sbox and rotation of word
    SB1: Sbox Port Map (input(12), w(3));
    SB2: Sbox Port Map (input(13), tmp);
    SB3: Sbox Port Map (input(14), w(1));
    SB4: Sbox Port Map (input(15), w(2));
    
    rcon_x2 <= rcon_in(5 downto 0) & rcon_in(6);
    ADD1: AddModMersenne Generic Map (7) Port Map (rcon_in, tmp, w(0));
    ADD2: AddModMersenne Generic Map (7) Port Map (rcon_in, rcon_x2, rcon_out);
    
    ADD_o: for i in 0 to 3 generate
        ADD_i: for j in 0 to 2 generate
            ADDs_i: AddModMersenne Generic Map (7) Port Map (input(i+j*4), w(i+j*4), w(i+(j+1)*4));
            output(i+j*4) <= w(i+(j+1)*4);
        end generate;
        ADDs_o: AddModMersenne Generic Map (7) Port Map (input(i+12), w(i+12), output(i+12));
    end generate;

end Behavioral;
