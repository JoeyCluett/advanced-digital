library ieee;
use ieee.std_logic_1164.all;

entity testbenchdff is
end entity testbenchdff;

architecture tb_dff of testbenchdff is

    signal sim_d, sim_clk: std_logic;
    signal sim_q, sim_nq: std_logic;

begin

    ff: entity work.d_ff(basic_arch) port map(sim_d, sim_clk, sim_q, sim_nq);

    simproc: process
    begin

        sim_clk <= '0'; wait for 5 ns;

        -- 00101100010110

        sim_d <= '0';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '0';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '1';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '0';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '1';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '1';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '0';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '0';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '0';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '1';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '0';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '1';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '1';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        sim_d <= '0';
        sim_clk <= '1'; wait for 5 ns;
        sim_clk <= '0'; wait for 5 ns; report "q:nq " & std_logic'image(sim_q) & std_logic'image(sim_nq);

        wait;

    end process;

end architecture tb_dff;


