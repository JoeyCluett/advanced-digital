library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity n_bit_adder is

    generic(buswidth: integer := 8);

    port(
        A    : in  std_logic_vector(buswidth-1 downto 0);
        B    : in  std_logic_vector(buswidth-1 downto 0);
        Sum  : out std_logic_vector(buswidth-1 downto 0);
        Cin  : in  std_logic;
        Cout : out std_logic
    );

end entity n_bit_adder;

architecture behav of n_bit_adder is
    -- temporary holding place for carries
    signal c : std_logic_vector(buswidth downto 0);
begin

    fa_start: 
        entity work.full_adder(behav) 
        port map(A(0), B(0), Sum(0), Cin, c(0));

    fa_intermediate:
        for i in 1 to buswidth-1 generate
            fa: 
                entity work.full_adder(behav) 
                port map(A(i), B(i), Sum(i), c(i-1), c(i));
        end generate;

    Cout <= c(buswidth);

end architecture behav;
