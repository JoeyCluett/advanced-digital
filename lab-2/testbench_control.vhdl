library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_control is
end entity testbench_control;

architecture behav of testbench_control is

    signal be_clk    : std_logic;
    signal be_rdnsft : std_logic;
    signal be_enable : std_logic;
    signal mg_clk    : std_logic;
    signal mg_rdnsft : std_logic;
    signal mg_enable : std_logic;
    signal acc_clear : std_logic;
    signal acc_clock : std_logic;
    signal clock : std_logic;
    signal reset : std_logic;
    signal start : std_logic;
    signal done  : std_logic;

begin

    ent:
        entity work.toplevel_control(behav)
        port map(
            be_clk, be_rdnsft, be_enable,
            mg_clk, mg_rdnsft, mg_enable,
            acc_clear, acc_clock,
            clock,
            reset,
            start,
            done
        );

    proc: process
    begin

        reset <= '1';
        start <= '0';
        
        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;

        reset <= '0';
        --start <= '1';

        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;
        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;
        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;
        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;

        start <= '1';

        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;

        start <= '0';

        for i in 0 to 9 loop
            clock <= '0'; wait for 5 ns;
            clock <= '1'; wait for 5 ns;    
        end loop;

        -- start of second multiply

        start <= '1';

        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;
        
        start <= '0';

        for i in 0 to 10 loop
            clock <= '0'; wait for 5 ns;
            clock <= '1'; wait for 5 ns;    
        end loop;

        wait;
    end process;

end architecture behav;
