library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity AES_prime_2SHARE is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           plaintext_share0 : in AES_prime_state;
           plaintext_share1 : in AES_prime_state;
           randomness : UNSIGNED (699 downto 0);
           key_share0 : in AES_prime_state;
           key_share1 : in AES_prime_state;
           ciphertext_share0 : out AES_prime_state;
           ciphertext_share1 : out AES_prime_state;
           done : out STD_LOGIC);
end AES_prime_2SHARE;

architecture Behavioral of AES_prime_2SHARE is

    component AddRoundKey is
        Port ( input : in AES_prime_state;
               roundkey : in AES_prime_state;
               output : out AES_prime_state);
    end component;

    component SubBytes_2SHARE is
        Port ( clk : in STD_LOGIC;
               input_share0 : in AES_prime_state;
               input_share1 : in AES_prime_state;
               randomness : UNSIGNED (559 downto 0);
               output_share0 : out AES_prime_state;
               output_share1 : out AES_prime_state);
    end component;

    component ShiftRows is
        Port ( input : in AES_prime_state;
               output : out AES_prime_state);
    end component;

    component MixColumns is
        Port ( input : in AES_prime_state;
               output : out AES_prime_state);
    end component;

    component RoundKeyUpdate_2SHARE is
        Port ( clk : in STD_LOGIC;
               rcon_in : in UNSIGNED (6 downto 0);
               input_share0 : in AES_prime_state;
               input_share1 : in AES_prime_state;
               randomness : UNSIGNED (139 downto 0);
               rcon_out : out UNSIGNED (6 downto 0);
               output_share0 : out AES_prime_state;
               output_share1 : out AES_prime_state);
    end component;

    signal round_in_share0, round_out_share0, roundkey_in_share0, roundkey_out_share0, ark_out_share0, sb_out_share0, sr_out_share0 : AES_prime_state;
    signal round_in_share1, round_out_share1, roundkey_in_share1, roundkey_out_share1, ark_out_share1, sb_out_share1, sr_out_share1 : AES_prime_state;
    signal rcon_in, rcon_out : UNSIGNED (6 downto 0);
    constant p1 : UNSIGNED (6 downto 0) := "0000001";
    
begin

    RK: RoundKeyUpdate_2SHARE Port Map (clk, rcon_in, roundkey_in_share0, roundkey_in_share1, randomness(139 downto 0), rcon_out, roundkey_out_share0, roundkey_out_share1);

    ARK0: AddRoundKey Port Map (round_in_share0, roundkey_in_share0, ark_out_share0);
    ARK1: AddRoundKey Port Map (round_in_share1, roundkey_in_share1, ark_out_share1);
    SB: SubBytes_2SHARE Port Map (clk, ark_out_share0, ark_out_share1, randomness(699 downto 140), sb_out_share0, sb_out_share1);
    SR0: ShiftRows Port Map (sb_out_share0, sr_out_share0);
    SR1: ShiftRows Port Map (sb_out_share1, sr_out_share1);
    MC0: MixColumns Port Map (sr_out_share0, round_out_share0);
    MC1: MixColumns Port Map (sr_out_share1, round_out_share1);
    
    FSM: process(clk)
        variable roundcounter : integer range 0 to 13;
        variable roundcyclecounter : integer range 0 to 3;
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                round_in_share0         <= plaintext_share0;
                round_in_share1         <= plaintext_share1;
                roundkey_in_share0      <= key_share0;
                roundkey_in_share1      <= key_share1;
                rcon_in                 <= p1;
                done                    <= '0';
                roundcounter            := 0;
                roundcyclecounter       := 0;
            else
                if (roundcounter < 13) then
                    round_in_share0         <= round_out_share0;
                    round_in_share1         <= round_out_share1;
                    roundkey_in_share0      <= roundkey_out_share0;
                    roundkey_in_share1      <= roundkey_out_share1;
                    if (roundcyclecounter < 3) then
                        roundcyclecounter   := roundcyclecounter + 1;
                    else
                        rcon_in             <= rcon_out;
                        roundcounter        := roundcounter + 1;
                        roundcyclecounter   := 0;
                    end if;
                else
                    done <= '1';
                end if;
            end if;
        end if;
    end process;
    
    ARK_FINAL0: AddRoundKey Port Map (sr_out_share0, roundkey_out_share0, ciphertext_share0);
    ARK_FINAL1: AddRoundKey Port Map (sr_out_share1, roundkey_out_share1, ciphertext_share1);
    
end Behavioral;
