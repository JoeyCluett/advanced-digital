library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbenchtimegen is
end entity testbenchtimegen;

architecture test_time_gen of testbenchtimegen is

    signal config : std_logic_vector(31 downto 0);
    signal Start, clk, reset, LC_Start, LC_Tick, LC_DoneFeedback : std_logic;

begin

    -- config, Start, clk, reset, LC_Start, LC_Tick, LC_DoneFeedback
    tg: entity work.timing_generator(behav) 
        port map(
            config, 
            Start, clk, reset, LC_Start, LC_Tick, LC_DoneFeedBack);

    -- dictates how many cycles a second is
    config <= std_logic_vector(to_unsigned(  3  , 32));

    sim: process
    begin

        -- reset the device
        clk <= '0'; wait for 5 ns;
        start <= '0';

        -- timing generator requires two cycles to fully reset
        reset <= '1';
        clk <= '1'; wait for 2 ns;
        clk <= '0'; wait for 3 ns;
        clk <= '1'; wait for 2 ns;
        clk <= '0'; wait for 3 ns;
        reset <= '0';

        -- start the device
        start <= '1';
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
        start <= '0';

        for idx in 0 to 100 loop
            clk <= '1'; wait for 5 ns;
            clk <= '0'; wait for 5 ns;    
        end loop;

        wait;

    end process;

end architecture test_time_gen;
