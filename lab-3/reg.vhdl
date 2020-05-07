library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is

    generic(buswidth: integer := 8);

    port(
        D     : in std_logic_vector(buswidth-1 downto 0);
        Q     : out std_logic_vector(buswidth-1 downto 0);
        nQ    : out std_logic_vector(buswidth-1 downto 0);
        clock : in std_logic
    );

end entity reg;

architecture behav of reg is
begin

    proc: process
    begin
        wait until clock='1';

        Q <= D;
        nQ <= not D;

    end process;

end architecture behav;