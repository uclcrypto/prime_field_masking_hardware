library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity SubBytes_3SHARE is
        Port ( clk : in STD_LOGIC;
               input_share0 : in AES_prime_state;
               input_share1 : in AES_prime_state;
               input_share2 : in AES_prime_state;
               randomness : UNSIGNED (1455 downto 0);
               output_share0 : out AES_prime_state;
               output_share1 : out AES_prime_state;
               output_share2 : out AES_prime_state);
end SubBytes_3SHARE;

architecture Behavioral of SubBytes_3SHARE is

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

begin

    SB: for i in 0 to 15 generate
        SBs: SBOX_3SHARE Port Map (clk, input_share0(i), input_share1(i), input_share2(i), randomness(1455-i*91 downto 1449-i*91), randomness(1448-i*91 downto 1442-i*91), randomness(1441-i*91 downto 1435-i*91), randomness(1434-i*91 downto 1428-i*91), randomness(1427-i*91 downto 1421-i*91), randomness(1420-i*91 downto 1414-i*91), randomness(1413-i*91 downto 1407-i*91), randomness(1406-i*91 downto 1400-i*91), randomness(1399-i*91 downto 1393-i*91), randomness(1392-i*91 downto 1386-i*91), randomness(1385-i*91 downto 1379-i*91), randomness(1378-i*91 downto 1372-i*91), randomness(1371-i*91 downto 1365-i*91), output_share0(i), output_share1(i), output_share2(i));
    end generate;

end Behavioral;