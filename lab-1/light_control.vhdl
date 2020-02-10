library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity light_control is

    port(
        Reset : in std_logic; -- active high
        Tick  : in std_logic; -- expects a 1Hz signal
        Start : in std_logic;
        cRed, cYel, cGrn : out std_logic;
        done_signal : out std_logic -- tell controlling circuitry that we are done
    );

end entity light_control;

architecture behav of light_control is

    signal state : integer;

begin

    proc: process
    begin
        wait until Tick='1';
        if Reset='1' then
            state <= 0;

            cRed <= '1';
            cYel <= '0';
            cGrn <= '0';
            done_signal <= '0';

        else
            case state is
                when 0 =>

                    cRed <= '1';
                    cYel <= '0';
                    cGrn <= '0';
                    done_signal <= '0';

                    -- default behavior is to stay in state 0
                    if Start='1' then
                        state <= 2;
                    end if;

                when 1 =>
                    state <= 2;
                    cRed <= '1';
                    cYel <= '0';
                    cGrn <= '0';

                when 2 =>
                    state <= 3;
                    cRed <= '0';
                    cYel <= '1';
                    cGrn <= '0';

                when 3 =>
                    state <= 4;
                    cRed <= '0';
                    cYel <= '1';
                    cGrn <= '0';

                when 4 =>
                    state <= 5;
                    cRed <= '0';
                    cYel <= '0';
                    cGrn <= '1';

                when 5 =>
                    state <= 6;
                    cRed <= '0';
                    cYel <= '0';
                    cGrn <= '1';

                when 6 =>
                    state <= 0;
                    cRed <= '0';
                    cYel <= '0';
                    cGrn <= '1';
                    done_signal <= '1';
                
                when others => state <= 7; -- not used by the state machine which means it will wait for a reset
            end case;
        end if;
    end process;

end architecture behav;


