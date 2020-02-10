library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity freq_divider is

    port(
        config : in std_logic_vector(31 downto 0); 
        inclk  : in std_logic; 
        outclk : out std_logic;
        nReset  : in std_logic -- active low signal
    );

end entity freq_divider;

architecture behav of freq_divider is

    signal val : integer;

begin

    proc: process
    begin
        wait until inclk='1';
        if nReset='0' then
        
            val <= 0;
            outclk <= '0';
        
        else
            -- someday ill need to figure out how all these BS conversions work...
            if to_integer(unsigned(config)) = val then
                outclk <= '1';
                val <= 0;
            else
                outclk <= '0';
                val <= val + 1;
            end if;

        end if;
    end process;

end architecture behav;
