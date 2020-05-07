library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_toplevel is
end entity testbench_toplevel;

architecture behav of testbench_toplevel is

    signal A : std_logic_vector(7 downto 0);
    signal B : std_logic_vector(7 downto 0);
    
    signal result : std_logic_vector(15 downto 0);

    signal clock : std_logic;
    signal reset : std_logic;
    signal start : std_logic;
    signal done  : std_logic;

begin

    ent:
        entity work.toplevel(behav)
        port map(
            A, B, result,
            clock, reset, start, done
        );

    sim: process
    begin

        A <= "01111111";
        B <= "01111111";


        reset <= '1'; -- reset
        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;
        reset <= '0';
        start <= '1'; -- start
        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;
        start <= '0';

        for i in 0 to 7 loop
            clock <= '0'; wait for 5 ns;
            clock <= '1'; wait for 5 ns;
        end loop;

        A <= "11111111";
        B <= "11111111";

        reset <= '1'; -- reset
        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;
        reset <= '0';
        start <= '1'; -- start
        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;
        start <= '0';

        for i in 0 to 7 loop
            clock <= '0'; wait for 5 ns;
            clock <= '1'; wait for 5 ns;
        end loop;

        A <= "01010101";
        B <= "10101010";

        reset <= '1'; -- reset
        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;
        reset <= '0';
        start <= '1'; -- start
        clock <= '0'; wait for 5 ns;
        clock <= '1'; wait for 5 ns;
        start <= '0';

        for i in 0 to 7 loop
            clock <= '0'; wait for 5 ns;
            clock <= '1'; wait for 5 ns;
        end loop;

        wait;
    end process;

end architecture behav;