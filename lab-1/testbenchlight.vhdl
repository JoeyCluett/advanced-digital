library ieee;
use ieee.std_logic_1164.all;

entity testbenchlight is
end entity testbenchlight;

architecture test_light_control of testbenchlight is

    signal sim_Reset, sim_Tick, sim_Start : std_logic;
    signal sim_cRed, sim_cYel, sim_cGrn : std_logic;
    signal sim_done : std_logic;

begin

    lc: entity work.light_control(behav) port map(
        sim_Reset, sim_Tick, sim_Start, sim_cRed, sim_cYel, sim_cGrn, sim_done);

    sim: process
    begin

        sim_Tick <= '0'; wait for 5 ns;

        sim_Start <= '0';
        sim_Reset <= '1';
        sim_Tick <= '1'; wait for 5 ns;
        sim_Tick <= '0'; wait for 5 ns;
        
        sim_Reset <= '0';
        sim_Start <= '1';
        sim_Tick <= '1'; wait for 5 ns;
        sim_Tick <= '0'; wait for 5 ns;
        sim_Start <= '0';

        for cyclecount in 0 to 8 loop

            sim_Tick <= '1'; wait for 5 ns;
            sim_Tick <= '0'; wait for 5 ns;

        end loop;

        sim_Start <= '1';
        sim_Tick <= '1'; wait for 5 ns;
        sim_Tick <= '0'; wait for 5 ns;
        sim_Start <= '0';

        for cyclecount in 0 to 8 loop

            sim_Tick <= '1'; wait for 5 ns;
            sim_Tick <= '0'; wait for 5 ns;

        end loop;


        wait;

    end process;

end architecture test_light_control;
