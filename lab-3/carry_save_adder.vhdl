library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity carry_save_adder is

    generic(buswidth: integer);

    port(
        A : in std_logic_vector(buswidth-1 downto 0);
        B : in std_logic_vector(buswidth-1 downto 0);
        C : in std_logic_vector(buswidth-1 downto 0);

        Sum   : out std_logic_vector(buswidth-1 downto 0);
        Carry : out std_logic_vector(buswidth-1 downto 0)
    );
end entity carry_save_adder;

architecture behav of carry_save_adder is

begin

    csa:
        for i in 0 to buswidth-1 generate

            facs:
                entity work.full_adder_cs(behav)
                port map(
                    A(i), B(i), C(i),
                    Sum(i), Carry(i)
                );

        end generate;

end architecture behav;
