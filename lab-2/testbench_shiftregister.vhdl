library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_shiftregister is
end entity testbench_shiftregister;

architecture testbench of testbench_shiftregister is

    signal D   : std_logic_vector(7 downto 0);
    signal Q   : std_logic_vector(7 downto 0);
    signal clk : std_logic;
    signal rd_nsft : std_logic; -- 1:read, 0:shft
    signal enable  : std_logic;
    signal Dsftin  : std_logic;
    signal Dsftout : std_logic;

begin

    reg: 
        entity work.shift_register(behav) 
        generic map(8)
        port map(D, Q, clk, rd_nsft, enable, Dsftin, Dsftout);

    sim: process
    begin

        enable  <= '0';
        clk     <= '0'; 
        Dsftin  <= '0';
        rd_nsft <= '1';
        wait for 5 ns;

        enable <= '1';
        D <= "11110000";
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;

        rd_nsft <= '0';
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;

        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;

        Dsftin <= '1';
        for i in 0 to 7 loop
            clk <= '1'; wait for 5 ns;
            clk <= '0'; wait for 5 ns;    
        end loop;

        Dsftin <= '0';
        for i in 0 to 7 loop
            clk <= '1'; wait for 5 ns;
            clk <= '0'; wait for 5 ns;    
        end loop;

        D <= "00001111";
        rd_nsft <= '1';
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;

        enable <= '0';
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
        clk <= '0'; wait for 5 ns;

        wait;

    end process;

end architecture testbench;
