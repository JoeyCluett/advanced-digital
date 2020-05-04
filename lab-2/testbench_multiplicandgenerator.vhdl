library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_multiplicandgenerator is
end entity testbench_multiplicandgenerator;

architecture testbench of testbench_multiplicandgenerator is

    signal sim_inputval  : std_logic_vector(7 downto 0); -- input (for setup)
    signal sim_outputval : std_logic_vector(15 downto 0); -- output
    signal sim_sel_x     : std_logic; -- select positive multiplicand
    signal sim_sel_neg_x : std_logic; -- select negative multiplicand
    signal sim_clock     : std_logic; -- clock input for register
    signal sim_rd_nsft   : std_logic; -- 1:read, 0:shift
    signal sim_enable    : std_logic; -- enable generator

begin

    gen: 
        entity work.multiplicand_generator(behav) 
        port map(
            sim_inputval,
            sim_outputval, 
            sim_sel_x,     
            sim_sel_neg_x, 
            sim_clock,
            sim_rd_nsft,
            sim_enable);

    sim: process
    begin

        sim_enable <= '1';
        sim_rd_nsft <= '1';
        sim_inputval <= "11111111";

        sim_clock <= '0'; wait for 1 ns;

        sim_sel_x     <= '1';
        sim_sel_neg_x <= '0';

        sim_clock <= '1'; wait for 5 ns;
        sim_clock <= '0'; wait for 5 ns;

        sim_sel_x     <= '0';
        sim_sel_neg_x <= '1';

        sim_clock <= '1'; wait for 5 ns;
        sim_clock <= '0'; wait for 5 ns;

        sim_rd_nsft <= '0'; -- shift

        sim_clock <= '1'; wait for 5 ns;
        sim_clock <= '0'; wait for 5 ns;

        sim_sel_x     <= '1';
        sim_sel_neg_x <= '0';

        wait for 5 ns;

        wait;
    end process;

end architecture testbench;
