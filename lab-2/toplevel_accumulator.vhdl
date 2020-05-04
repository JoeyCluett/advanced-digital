library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity toplevel_accumulator is

    generic (buswidth : integer);

    port(
        D : in  std_logic_vector(buswidth-1 downto 0);
        Q : out std_logic_vector(buswidth-1 downto 0);
        clear : in std_logic;
        clk : in std_logic
    );

end entity toplevel_accumulator;

architecture behav of toplevel_accumulator is

    signal r_in  : std_logic_vector(buswidth-1 downto 0);

begin

    andbit:
        for i in 0 to buswidth-1 generate
            r_in(i) <= D(i) and not clear;
        end generate;

    reg:
        entity work.n_bit_register(behav)
        generic map(buswidth)
        port map(
            r_in,
            Q,
            open,
            clk
        );

end architecture behav;
