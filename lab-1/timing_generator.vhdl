library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timing_generator is

    port(
        config : in std_logic_vector(31 downto 0); -- how many clk cycles is 1 second
        Start  : in std_logic;    -- active high
        clk    : in std_logic;
        reset  : in std_logic;    -- light_control and timing_generator are reset indepenently
        LC_Start : out std_logic; -- signal light control to start
        LC_Tick  : out std_logic;  -- divides base frequency down to 1 Hz for light control
        LC_DoneFeedBack : in std_logic
    );

end entity timing_generator;

architecture behav of timing_generator is

    signal state : integer := 0;
    signal freqreset: std_logic;

begin

    -- config, inclk, outclk, nReset
    freqdiv: entity work.freq_divider(behav) 
        port map(config, clk, LC_Tick, freqreset);

    freqreset <= not reset;
    LC_Start <= Start;

    proc: process
    begin
        wait until clk='1';
        
        if reset='1' then
            state <= 0;
        else

            case state is

                when 0 => -- reset state

                    if Start='1' then
                        --LC_Start <='1';
                        --freqreset <= '1';
                        state <= 1;
                    else
                        --LC_Start <='0';
                        --freqreset <= '0';
                    end if;

                when 1 => -- wait for slave to finish

                    --LC_Start <= '0';-- should never last more than 1 (regular) clock cycle

                    if LC_DoneFeedBack='1' then
                        state <= 0;
                        --freqreset <= '0';
                    end if;

                when others =>
                    state <= 11; -- unused by rest of FSM

            end case;

        end if;
    end process;

end architecture behav;

