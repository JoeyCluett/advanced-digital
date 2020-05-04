library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity booth_encoder is
    generic(buswidth: integer);
    port(
        D       : in std_logic_vector(buswidth-1 downto 0);
        clk     : in std_logic;
        rd_nsft : in std_logic;
        sel_x   : out std_logic;
        sel_nx  : out std_logic;
        enable  : in std_logic
    );
end entity booth_encoder;

architecture behav of booth_encoder is
    signal regout : std_logic_vector(buswidth downto 0);
    signal regin  : std_logic_vector(buswidth downto 0);
    signal tb0 : std_logic;
    signal tb1 : std_logic;
begin

    reginprep:
        for i in 0 to buswidth-1 generate
            regin(buswidth-1-i) <= D(i);
        end generate;

    regin(buswidth) <= '0';

    reg:
        entity work.shift_register(behav)
        generic map(buswidth + 1)
        port map(
            regin,
            regout,
            clk,
            rd_nsft,
            enable,
            '0', -- sftin
            open -- sftout
        );

    tb0 <= regout(buswidth);
    tb1 <= regout(buswidth-1);

    calc_b: process(tb0, tb1)
    begin
        if (tb0 = '1') and (tb1 = '0') then
            -- +M
            sel_x  <= '1';
            sel_nx <= '0';

        elsif (tb0 = '0') and (tb1 = '1') then
            -- -M
            sel_x  <= '0';
            sel_nx <= '1';
        else
            sel_x <= '0';
            sel_nx <= '0';
        end if;
    end process;

end architecture behav;
