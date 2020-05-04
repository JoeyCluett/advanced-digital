library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_nbitreg is
end entity testbench_nbitreg;

architecture testbench of testbench_nbitreg is

    signal sim_D  : std_logic_vector(7 downto 0); -- Data In
    signal sim_Q  : std_logic_vector(7 downto 0); -- Data Out
    signal sim_nQ : std_logic_vector(7 downto 0); -- Data Out (inverted)
    signal clock  : std_logic;

begin

    reg: 
        entity work.n_bit_register(behav) 
        generic map(8)
        port map(sim_D, sim_Q, sim_nQ, clock);

    sim: process
    begin

        clock <= '0'; wait for 5 ns;

        for cyclen in 0 to 255 loop
            --sim_D <= to_integer(unsigned(cyclen));
            sim_D <= std_logic_vector(to_unsigned(cyclen, 8));
            clock <= '1'; wait for 5 ns;
            clock <= '0'; wait for 5 ns;
        end loop;

--        sim_Tick <= '0'; wait for 5 ns;
--        for cyclecount in 0 to 8 loop
--            sim_Tick <= '1'; wait for 5 ns;
--            sim_Tick <= '0'; wait for 5 ns;
--        end loop;

        wait;

    end process;

end architecture testbench;
