library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package AES_prime_state_data_type is
    type AES_prime_state is array (15 downto 0) of UNSIGNED (6 downto 0);
end package;