library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity zero_extender is
    generic(inwidth : integer; outwidth : integer);
    port(
        A : in  std_logic_vector(inwidth-1 downto 0);
        Y : out std_logic_vector(outwidth-1 downto 0));
end entity zero_extender;

architecture behav of zero_extender is

begin

    Y(inwidth-1 downto 0) <= A;
    Y(outwidth-1 downto inwidth) <= (others => '0');

end architecture behav;
