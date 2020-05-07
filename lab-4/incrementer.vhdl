library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity incrementer is
    generic(buswidth : integer);
    port(
        A    : in std_logic_vector(buswidth-1 downto 0);
        Ainc : out std_logic_vector(buswidth-1 downto 0));
end entity incrementer;

architecture behav of incrementer is

    signal Binput : std_logic_vector(buswidth-1 downto 0);

begin

    Binput(0) <= '1';
    gen1:
        for i in 1 to buswidth-1 generate
            Binput(i) <= '0';
        end generate;

    add:
        entity work.adder(behav)
        generic map(buswidth)
        port map(A, Binput, Ainc, '0', open);

end architecture behav;
