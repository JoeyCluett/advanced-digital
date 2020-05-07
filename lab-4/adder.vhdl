library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is

    generic(buswidth: integer := 8);

    port(
        A    : in  std_logic_vector(buswidth-1 downto 0);
        B    : in  std_logic_vector(buswidth-1 downto 0);
        Sum  : out std_logic_vector(buswidth-1 downto 0);
        Cin  : in  std_logic;
        Cout : out std_logic
    );

end entity adder;

architecture behav of adder is
    -- temporary holding place for carries
    signal c : std_logic_vector(buswidth downto 0);
begin

    fa_all:
        for i in 0 to buswidth-1 generate
            fa:
                entity work.full_adder_rc(behav)
                port map(A(i), B(i), Sum(i), c(i), c(i+1));
        end generate;

    c(0) <= Cin;
    Cout <= c(buswidth);

end architecture behav;
