library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity SubBytes_2SHARE is
        Port ( clk : in STD_LOGIC;
               input_share0 : in AES_prime_state;
               input_share1 : in AES_prime_state;
               randomness : UNSIGNED (559 downto 0);
               output_share0 : out AES_prime_state;
               output_share1 : out AES_prime_state);
end SubBytes_2SHARE;

architecture Behavioral of SubBytes_2SHARE is

    component SBOX_2SHARE is
        Generic (bits : INTEGER := 7);
        Port ( clk : in STD_LOGIC;
               a0 : in UNSIGNED (bits-1 downto 0);
               a1 : in UNSIGNED (bits-1 downto 0);
               r0 : in UNSIGNED (bits-1 downto 0);
               r1 : in UNSIGNED (bits-1 downto 0);
               r2 : in UNSIGNED (bits-1 downto 0);
               r3 : in UNSIGNED (bits-1 downto 0);
               r4 : in UNSIGNED (bits-1 downto 0);
               d0 : out UNSIGNED (bits-1 downto 0);
               d1 : out UNSIGNED (bits-1 downto 0));
    end component;

begin

    SB: for i in 0 to 15 generate
        SBs: SBOX_2SHARE Port Map (clk, input_share0(i), input_share1(i), randomness(559-i*35 downto 553-i*35), randomness(552-i*35 downto 546-i*35), randomness(545-i*35 downto 539-i*35), randomness(538-i*35 downto 532-i*35), randomness(531-i*35 downto 525-i*35), output_share0(i), output_share1(i));
    end generate;

end Behavioral;