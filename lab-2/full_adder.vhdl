library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- full 1-bit adder
entity full_adder is
    port(
        A    : in std_logic;
        B    : in std_logic;
        Sum  : out std_logic;
        Cin  : in std_logic;
        Cout : out std_logic
    );
end entity full_adder;

architecture behav of full_adder is
begin
    Sum <= A xor B xor Cin;
    Cout <= (A and B) or ((A xor B) and Cin);

end architecture behav;
