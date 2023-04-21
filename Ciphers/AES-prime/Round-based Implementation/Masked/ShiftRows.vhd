library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.AES_prime_state_data_type.ALL;

entity ShiftRows is
    Port ( input : in AES_prime_state;
           output : out AES_prime_state);
end ShiftRows;

architecture Behavioral of ShiftRows is

begin

    output(0) <= input(0);
    output(1) <= input(5);
    output(2) <= input(10);
    output(3) <= input(15);
    output(4) <= input(4);
    output(5) <= input(9);
    output(6) <= input(14);
    output(7) <= input(3);
    output(8) <= input(8);
    output(9) <= input(13);
    output(10) <= input(2);
    output(11) <= input(7);
    output(12) <= input(12);
    output(13) <= input(1);
    output(14) <= input(6);
    output(15) <= input(11);

end Behavioral;
