library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.AES_prime_state_data_type.ALL;

entity SubBytes_4SHARE is
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
end SubBytes_4SHARE;

architecture Behavioral of SubBytes_4SHARE is

    component SBOX_4SHARE is
    Generic (bits : INTEGER := 7);
    Port ( clk : in STD_LOGIC;
           a0 : in UNSIGNED (bits-1 downto 0);
           a1 : in UNSIGNED (bits-1 downto 0);
           a2 : in UNSIGNED (bits-1 downto 0);
           a3 : in UNSIGNED (bits-1 downto 0);
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
           r13 : in UNSIGNED (bits-1 downto 0);
           r14 : in UNSIGNED (bits-1 downto 0);
           r15 : in UNSIGNED (bits-1 downto 0);
           r16 : in UNSIGNED (bits-1 downto 0);
           r17 : in UNSIGNED (bits-1 downto 0);
           r18 : in UNSIGNED (bits-1 downto 0);
           r19 : in UNSIGNED (bits-1 downto 0);
           r20 : in UNSIGNED (bits-1 downto 0);
           r21 : in UNSIGNED (bits-1 downto 0);
           r22 : in UNSIGNED (bits-1 downto 0);
           r23 : in UNSIGNED (bits-1 downto 0);
           r24 : in UNSIGNED (bits-1 downto 0);
           r25 : in UNSIGNED (bits-1 downto 0);
           r26 : in UNSIGNED (bits-1 downto 0);
           r27 : in UNSIGNED (bits-1 downto 0);
           r28 : in UNSIGNED (bits-1 downto 0);
           r29 : in UNSIGNED (bits-1 downto 0);
           d0 : out UNSIGNED (bits-1 downto 0);
           d1 : out UNSIGNED (bits-1 downto 0);
           d2 : out UNSIGNED (bits-1 downto 0);
           d3 : out UNSIGNED (bits-1 downto 0));
    end component;

begin

    SB: for i in 0 to 15 generate
        SBs: SBOX_4SHARE Port Map (clk, input_share0(i), input_share1(i), input_share2(i), input_share3(i), randomness(3359-i*210 downto 3353-i*210), randomness(3352-i*210 downto 3346-i*210), randomness(3345-i*210 downto 3339-i*210), randomness(3338-i*210 downto 3332-i*210), randomness(3331-i*210 downto 3325-i*210), randomness(3324-i*210 downto 3318-i*210), randomness(3317-i*210 downto 3311-i*210), randomness(3310-i*210 downto 3304-i*210), randomness(3303-i*210 downto 3297-i*210), randomness(3296-i*210 downto 3290-i*210), randomness(3289-i*210 downto 3283-i*210), randomness(3282-i*210 downto 3276-i*210), randomness(3275-i*210 downto 3269-i*210), randomness(3268-i*210 downto 3262-i*210), randomness(3261-i*210 downto 3255-i*210), randomness(3254-i*210 downto 3248-i*210), randomness(3247-i*210 downto 3241-i*210), randomness(3240-i*210 downto 3234-i*210), randomness(3233-i*210 downto 3227-i*210), randomness(3226-i*210 downto 3220-i*210), randomness(3219-i*210 downto 3213-i*210), randomness(3212-i*210 downto 3206-i*210), randomness(3205-i*210 downto 3199-i*210), randomness(3198-i*210 downto 3192-i*210), randomness(3191-i*210 downto 3185-i*210), randomness(3184-i*210 downto 3178-i*210), randomness(3177-i*210 downto 3171-i*210), randomness(3170-i*210 downto 3164-i*210), randomness(3163-i*210 downto 3157-i*210), randomness(3156-i*210 downto 3150-i*210), output_share0(i), output_share1(i), output_share2(i), output_share3(i));
    end generate;

end Behavioral;