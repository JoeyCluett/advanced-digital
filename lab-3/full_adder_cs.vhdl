library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder_cs is
    port(
        A : in std_logic;
        B : in std_logic;
        Cin : in std_logic;
        PartSum : out std_logic;
        ShftCarry : out std_logic
    );
end entity full_adder_cs;

architecture behav of full_adder_cs is
begin

    -- carry save full adder is just a regular full adder with different port names
    fa:
        entity work.full_adder_rc(behav)
        port map(
            A, B, PartSum, Cin, ShftCarry
        );

end architecture behav;