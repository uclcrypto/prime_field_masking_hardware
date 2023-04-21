library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity SubBytes is
    Port ( input : in AES_prime_state;
           output : out AES_prime_state);
end SubBytes;

architecture Behavioral of SubBytes is

    component Sbox is
        Port ( input : in UNSIGNED (6 downto 0);
               output : out UNSIGNED (6 downto 0));
    end component;

begin

    SB: for i in 0 to 15 generate
        SBs: Sbox Port Map (input(i), output(i));
    end generate;

end Behavioral;