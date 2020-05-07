library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture behav of testbench is

    signal A : std_logic_vector(6 downto 0);
    signal B : std_logic_vector(6 downto 0);
    signal Res : std_logic_vector(13 downto 0);

begin

    ent: 
        entity work.toplevel(behav)
        port map(A, B, Res);

    proc: process
    begin

        A <= "0001111"; -- 15
        B <= "0001111"; -- 15
        wait for 1 ns;

        A <= "0000111"; -- 7
        B <= "0000111"; -- 7
        wait for 1 ns;

        A <= "1010101"; -- 85
        B <= "1010101"; -- 85
        wait for 1 ns;

        A <= "1111111"; -- 127
        B <= "1111111"; -- 127
        wait for 1 ns;

        wait;
    end process;

end architecture behav;
