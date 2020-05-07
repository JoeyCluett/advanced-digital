library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity selector is
    generic(buswidth: integer);

    port(
        A  : in std_logic_vector(buswidth-1 downto 0);
        Y  : out std_logic_vector(buswidth-1 downto 0);
        En : in std_logic
    );

end entity selector;

architecture behav of selector is

begin

    andgates:
        for i in 0 to buswidth-1 generate
            Y(i) <= A(i) and En;
        end generate;

end architecture behav;