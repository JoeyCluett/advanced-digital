library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_multiplexer is
end entity testbench_multiplexer;

architecture testbench of testbench_multiplexer is

    signal sim_A0  : std_logic_vector(7 downto 0); -- Data In (0)
    signal sim_A1  : std_logic_vector(7 downto 0); -- Data In (1)
    signal sim_Y   : std_logic_vector(7 downto 0); -- Data Out
    signal sim_sel : std_logic; -- select
    signal sim_en  : std_logic; -- enable

begin

    reg: 
        entity work.multiplexer(behav) 
        generic map(8)
        port map(sim_A0, sim_A1, sim_Y, sim_sel, sim_en);

    sim: process
    begin

        sim_A0 <= "10101010";
        sim_A1 <= "01010101";
        sim_en <= '0';

        for i in 0 to 2 loop
            sim_sel <= '0'; wait for 5 ns;
            sim_sel <= '1'; wait for 5 ns;
        end loop;

        sim_A0 <= "10101010";
        sim_A1 <= "01010101";
        sim_en <= '1';

        for i in 0 to 2 loop
            sim_sel <= '0'; wait for 5 ns;
            sim_sel <= '1'; wait for 5 ns;
        end loop;

        sim_A0 <= "10101010";
        sim_A1 <= "01010101";
        sim_en <= '0';

        for i in 0 to 2 loop
            sim_sel <= '0'; wait for 5 ns;
            sim_sel <= '1'; wait for 5 ns;
        end loop;

        wait;

    end process;

end architecture testbench;
