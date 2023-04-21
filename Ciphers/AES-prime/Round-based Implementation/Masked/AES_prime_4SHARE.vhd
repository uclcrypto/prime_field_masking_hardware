library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity AES_prime_4SHARE is
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
end AES_prime_4SHARE;

architecture Behavioral of AES_prime_4SHARE is

    component AddRoundKey is
        Port ( input : in AES_prime_state;
               roundkey : in AES_prime_state;
               output : out AES_prime_state);
    end component;

    component SubBytes_4SHARE is
            Port ( clk : in STD_LOGIC;
                   input_share0 : in AES_prime_state;
                   input_share1 : in AES_prime_state;
                   input_share2 : in AES_prime_state;
                   input_share3 : in AES_prime_state;
                   randomness : UNSIGNED (3359 downto 0);
                   output_share0 : out AES_prime_state;
                   output_share1 : out AES_prime_state;
                   output_share2 : out AES_prime_state;
                   output_share3 : out AES_prime_state);
    end component;

    component ShiftRows is
        Port ( input : in AES_prime_state;
               output : out AES_prime_state);
    end component;

    component MixColumns is
        Port ( input : in AES_prime_state;
               output : out AES_prime_state);
    end component;

    component RoundKeyUpdate_4SHARE is
        Port ( clk : in STD_LOGIC;
               rcon_in : in UNSIGNED (6 downto 0);
               input_share0 : in AES_prime_state;
               input_share1 : in AES_prime_state;
               input_share2 : in AES_prime_state;
               input_share3 : in AES_prime_state;
               randomness : UNSIGNED (839 downto 0);
               rcon_out : out UNSIGNED (6 downto 0);
               output_share0 : out AES_prime_state;
               output_share1 : out AES_prime_state;
               output_share2 : out AES_prime_state;
               output_share3 : out AES_prime_state);
    end component;

    signal round_in_share0, round_out_share0, roundkey_in_share0, roundkey_out_share0, ark_out_share0, sb_out_share0, sr_out_share0 : AES_prime_state;
    signal round_in_share1, round_out_share1, roundkey_in_share1, roundkey_out_share1, ark_out_share1, sb_out_share1, sr_out_share1 : AES_prime_state;
    signal round_in_share2, round_out_share2, roundkey_in_share2, roundkey_out_share2, ark_out_share2, sb_out_share2, sr_out_share2 : AES_prime_state;
    signal round_in_share3, round_out_share3, roundkey_in_share3, roundkey_out_share3, ark_out_share3, sb_out_share3, sr_out_share3 : AES_prime_state;
    signal rcon_in, rcon_out : UNSIGNED (6 downto 0);
    constant p1 : UNSIGNED (6 downto 0) := "0000001";
    
begin

    RK: RoundKeyUpdate_4SHARE Port Map (clk, rcon_in, roundkey_in_share0, roundkey_in_share1, roundkey_in_share2, roundkey_in_share3, randomness(839 downto 0), rcon_out, roundkey_out_share0, roundkey_out_share1, roundkey_out_share2, roundkey_out_share3);

    ARK0: AddRoundKey Port Map (round_in_share0, roundkey_in_share0, ark_out_share0);
    ARK1: AddRoundKey Port Map (round_in_share1, roundkey_in_share1, ark_out_share1);
    ARK2: AddRoundKey Port Map (round_in_share2, roundkey_in_share2, ark_out_share2);
    ARK3: AddRoundKey Port Map (round_in_share3, roundkey_in_share3, ark_out_share3);
    SB: SubBytes_4SHARE Port Map (clk, ark_out_share0, ark_out_share1, ark_out_share2, ark_out_share3, randomness(4199 downto 840), sb_out_share0, sb_out_share1, sb_out_share2, sb_out_share3);
    SR0: ShiftRows Port Map (sb_out_share0, sr_out_share0);
    SR1: ShiftRows Port Map (sb_out_share1, sr_out_share1);
    SR2: ShiftRows Port Map (sb_out_share2, sr_out_share2);
    SR3: ShiftRows Port Map (sb_out_share3, sr_out_share3);
    MC0: MixColumns Port Map (sr_out_share0, round_out_share0);
    MC1: MixColumns Port Map (sr_out_share1, round_out_share1);
    MC2: MixColumns Port Map (sr_out_share2, round_out_share2);
    MC3: MixColumns Port Map (sr_out_share3, round_out_share3);
    
    FSM: process(clk)
        variable roundcounter : integer range 0 to 13;
        variable roundcyclecounter : integer range 0 to 5;
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                round_in_share0         <= plaintext_share0;
                round_in_share1         <= plaintext_share1;
                round_in_share2         <= plaintext_share2;
                round_in_share3         <= plaintext_share3;
                roundkey_in_share0      <= key_share0;
                roundkey_in_share1      <= key_share1;
                roundkey_in_share2      <= key_share2;
                roundkey_in_share3      <= key_share3;
                rcon_in                 <= p1;
                done                    <= '0';
                roundcounter            := 0;
                roundcyclecounter       := 0;
            else
                if (roundcounter < 13) then
                    round_in_share0         <= round_out_share0;
                    round_in_share1         <= round_out_share1;
                    round_in_share2         <= round_out_share2;
                    round_in_share3         <= round_out_share3;
                    roundkey_in_share0      <= roundkey_out_share0;
                    roundkey_in_share1      <= roundkey_out_share1;
                    roundkey_in_share2      <= roundkey_out_share2;
                    roundkey_in_share3      <= roundkey_out_share3;
                    if (roundcyclecounter < 5) then
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
    ARK_FINAL2: AddRoundKey Port Map (sr_out_share2, roundkey_out_share2, ciphertext_share2);
    ARK_FINAL3: AddRoundKey Port Map (sr_out_share3, roundkey_out_share3, ciphertext_share3);
    
end Behavioral;
