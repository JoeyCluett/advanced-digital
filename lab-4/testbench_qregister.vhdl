library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_qregister is
end entity;

architecture behav of testbench_qregister is

    signal D    : std_logic_vector(7 downto 0);
    signal Q    : std_logic_vector(7 downto 0);
    signal clk  : std_logic;
    signal Amsb : std_logic;
    signal sh_rdnsft : std_logic;
    signal sh_en   : std_logic;
    signal lsb_sel : std_logic; -- 0:D0 1:Amsb
    signal sh_out  : std_logic;

begin

    ent: 
        entity work.q_register(behav)
        port map(D, Q, clk, Amsb, sh_rdnsft, sh_en, lsb_sel, sh_out);

    proc: process
    begin

        D <= "11110000";
        sh_rdnsft <= '1'; -- read
        sh_en <= '1';
        lsb_sel <= '0'; -- D(0)
        --Amsb <= '0';

        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;

        sh_rdnsft <= '0'; -- shift
        lsb_sel <= '1'; -- Amsb

        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;

        Amsb <= '1';

        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;

        Amsb <= '0';

        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;

        wait;
    end process;

end architecture behav;
