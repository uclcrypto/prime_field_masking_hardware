library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity AddRoundKeyNoP is
    Port ( input : in AES_prime_state;
           roundkey : in AES_prime_state;
           output : out AES_prime_state);
end AddRoundKeyNoP;

architecture Behavioral of AddRoundKeyNoP is

    component AddModMersenneNoP is
        Generic ( bits : INTEGER := 7);
        Port ( a : in UNSIGNED (bits-1 downto 0);
               b : in UNSIGNED (bits-1 downto 0);
               c : out UNSIGNED (bits-1 downto 0));
    end component;
    
begin

    ARK: for i in 0 to 15 generate
        ADDs: AddModMersenneNoP Generic Map (7) Port Map (input(i), roundkey(i), output(i));
    end generate;

end Behavioral;
