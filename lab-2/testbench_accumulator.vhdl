library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_accumulator is
end entity testbench_accumulator;

architecture testbench of testbench_accumulator is

    signal D : std_logic_vector(7 downto 0);
    signal Q : std_logic_vector(7 downto 0);
    signal clear     : std_logic;
    signal clk       : std_logic;

begin

    acc:
        entity work.toplevel_accumulator(behav)
        generic map(8)
        port map(
            D, Q, clear, clk);

    test: process
    begin

        clear <= '1';
        clk <= '0';

        wait for 5 ns;

        clk <= '1'; wait for 5 ns;
        clear <= '0';
        D <= "10101010";
        clk <= '0'; wait for 5 ns;

        clk <= '1'; wait for 5 ns;
        
        clk <= '0'; wait for 5 ns;

        wait;
    end process;

end architecture testbench;
