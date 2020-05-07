library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity negate is

    generic(buswidth : integer);
    port(
        A    : in  std_logic_vector(buswidth-1 downto 0);
        negA : out std_logic_vector(buswidth-1 downto 0));
end entity negate;

architecture behav of negate is

    signal Ainv : std_logic_vector(buswidth-1 downto 0);

begin

    inverta:
        for i in 0 to buswidth-1 generate
            Ainv(i) <= not A(i);
        end generate;

    add: 
        entity work.incrementer(behav)
        generic map(buswidth)
        port map(Ainv, negA);

end architecture behav;
