library ieee;
use ieee.std_logic_1164.all;


entity d_ff is
    port(d, clk : in std_logic; q, nq : out std_logic);
end d_ff;

architecture basic_arch of d_ff is
begin
    
    ff_behavior: process(clk)
    begin

        if rising_edge(clk) then
            q <= d;
            nq <= not d;
        end if;

        --wait until clk='1';
        --q <= d;
        --nq <= not d;
    end process ff_behavior;

end architecture basic_arch;

