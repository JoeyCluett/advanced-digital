library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity n_bit_register is

    generic(buswidth: integer := 8);

    port(
        D     : in std_logic_vector(buswidth-1 downto 0);
        Q     : out std_logic_vector(buswidth-1 downto 0);
        nQ    : out std_logic_vector(buswidth-1 downto 0);
        clock : in std_logic
    );

end entity n_bit_register;

architecture behav of n_bit_register is
begin

    proc: process
    begin
        wait until clock='1';

        Q <= D;
        nQ <= not D;

    end process;

end architecture behav;