library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity AES_prime is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           plaintext : in AES_prime_state;
           key : in AES_prime_state;
           ciphertext : out AES_prime_state;
           done : out STD_LOGIC);
end AES_prime;

architecture Behavioral of AES_prime is

    component AddRoundKey is
        Port ( input : in AES_prime_state;
               roundkey : in AES_prime_state;
               output : out AES_prime_state);
    end component;

    component SubBytes is
        Port ( input : in AES_prime_state;
               output : out AES_prime_state);
    end component;

    component ShiftRows is
        Port ( input : in AES_prime_state;
               output : out AES_prime_state);
    end component;

    component MixColumns is
        Port ( input : in AES_prime_state;
               output : out AES_prime_state);
    end component;

    component RoundKeyUpdate is
        Port ( rcon_in : in UNSIGNED (6 downto 0);
               input : in AES_prime_state;
               rcon_out : out UNSIGNED (6 downto 0);
               output : out AES_prime_state);
    end component;

    component AddRoundKeyNoP is
        Port ( input : in AES_prime_state;
               roundkey : in AES_prime_state;
               output : out AES_prime_state);
    end component;
    
    signal round_in, round_out, roundkey_in, roundkey_out, ark_out, sb_out, sr_out : AES_prime_state;
    signal rcon_in, rcon_out : UNSIGNED (6 downto 0);
    constant p1 : UNSIGNED (6 downto 0) := "0000001";
    
begin

    RK: RoundKeyUpdate Port Map (rcon_in, roundkey_in, rcon_out, roundkey_out);

    ARK: AddRoundKey Port Map (round_in, roundkey_in, ark_out);
    SB: SubBytes Port Map (ark_out, sb_out);
    SR: ShiftRows Port Map (sb_out, sr_out);
    MC: MixColumns Port Map (sr_out, round_out);

    FSM: process(clk)
        variable roundcounter : integer range 0 to 13;
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                round_in            <= plaintext;
                roundkey_in         <= key;
                rcon_in             <= p1;
                done                <= '0';
                roundcounter        := 0;
            else
                if (roundcounter < 13) then
                    round_in        <= round_out;
                    roundkey_in     <= roundkey_out;
                    rcon_in         <= rcon_out;
                    roundcounter    := roundcounter + 1;
                else
                    done <= '1';
                end if;
            end if;
        end if;
    end process;
    
    ARK_FINAL: AddRoundKeyNoP Port Map (sr_out, roundkey_out, ciphertext);
    
end Behavioral;
