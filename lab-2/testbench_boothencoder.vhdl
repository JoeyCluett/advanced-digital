library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_boothencoder is
end entity testbench_boothencoder;

architecture behav of testbench_boothencoder is

    signal D       : std_logic_vector(7 downto 0);
    signal clk     : std_logic;
    signal rd_nsft : std_logic;
    signal sel_x   : std_logic;
    signal sel_nx  : std_logic;
    signal enable  : std_logic;

begin

    ent:
        entity work.booth_encoder(behav)
        generic map(8)
        port map(
            D,
            clk,
            rd_nsft,
            sel_x,
            sel_nx,
            enable
        );

    sim: process
    begin

        rd_nsft <= '1'; -- read mode
        enable <= '1';
        D <= "11100111";

        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;

        rd_nsft <= '0';
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;

        enable <= '0';
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;

        wait;
    end process;

end architecture behav;

