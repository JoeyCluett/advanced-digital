library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity testbenchlab1 is
    constant cyclespersecond : integer := 10;
end entity testbenchlab1;

architecture test_lab_1 of testbenchlab1 is

    signal sim_cRed, sim_cYel, sim_cGrn : std_logic;
    signal lc_done  : std_logic; -- light control -> timing gen
    signal lc_start : std_logic; -- timing gen -> light control
    signal lc_tick  : std_logic; -- timing gen -> light control
    signal reset    : std_logic; -- global reset
    signal start    : std_logic; -- -> timing gen
    signal clk      : std_logic; -- -> timing gen

    signal lc_tick_tmp : std_logic;

begin

    lc: entity work.light_control(behav) port map(
        reset, lc_tick, lc_start, sim_cRed, sim_cYel, sim_cGrn, lc_done);

    -- config, Start, clk, reset, LC_Start, LC_Tick, LC_DoneFeedback
    tg: entity work.timing_generator(behav) port map(
        std_logic_vector(to_unsigned(  cyclespersecond-1  , 32)),
        start, clk, reset,
        lc_start, lc_tick_tmp, lc_done);

    lc_tick <= reset or lc_tick_tmp;

    sim: process
    begin

        start <= '0';
        clk <= '0';

        -- reset everything (2 full cycles)
        reset <= '1';
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
        reset <= '0';

        for idk in 1 to 10 loop
            clk <= '1'; wait for 5 ns;
            clk <= '0'; wait for 5 ns;
        end loop;

        -- send the start signal for full tick cycles
        start <= '1';
        for idk in 1 to cyclespersecond loop
            clk <= '1'; wait for 5 ns;
            clk <= '0'; wait for 5 ns;    
        end loop;        
        start <= '0';

        -- wait for light control to finish
        for idx in 1 to 60 loop
            clk <= '1'; wait for 5 ns;
            clk <= '0'; wait for 5 ns;
        end loop;

        -- send the start signal
        start <= '1';
        for idk in 1 to cyclespersecond loop
            clk <= '1'; wait for 5 ns;
            clk <= '0'; wait for 5 ns;    
        end loop;        
        start <= '0';

        for idx in 1 to 60 loop
            clk <= '1'; wait for 5 ns;
            clk <= '0'; wait for 5 ns;
        end loop;

        wait;
    end process;

end architecture test_lab_1;
