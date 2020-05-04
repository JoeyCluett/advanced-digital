library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplexer is

    generic(buswidth: integer := 8);

    port(
        A0 : in std_logic_vector(buswidth-1 downto 0);
        A1 : in std_logic_vector(buswidth-1 downto 0);
        Y : out std_logic_vector(buswidth-1 downto 0);
        sel : in std_logic;
        en  : in std_logic
    );

end entity multiplexer;

architecture behav of multiplexer is
begin

    proc: process(en, sel, A0, A1) begin
        if en = '1' then
            if sel = '0' then
                Y <= A0;
            elsif sel = '1' then
                Y <= A1;
            else
                -- otherwise, output all zeros
                Y <= std_logic_vector(to_unsigned(0, buswidth));
            end if;
        else
            Y <= (others=>'Z');
        end if;
    end process;

end architecture behav;
