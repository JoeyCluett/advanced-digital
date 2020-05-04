library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is
end entity toplevel;

architecture behav of toplevel is

    signal A : std_logic_vector(7 downto 0);
    signal B : std_logic_vector(7 downto 0);

    signal be_clk    : std_logic;
    signal be_rdnsft : std_logic;
    signal be_enable : std_logic;

    signal mg_clk    : std_logic;
    signal mg_rdnsft : std_logic;
    signal mg_enable : std_logic;
    
    signal acc_clear : std_logic;
    signal acc_clock : std_logic;
    
    signal result : std_logic_vector(15 downto 0);

begin

    ent:
        entity work.toplevel_datapath(behav)
        port map(
            A, B,
            be_clk, be_rdnsft, be_enable,
            mg_clk, mg_rdnsft, mg_enable,
            acc_clear, acc_clock,
            result
        );

    

    sim: process
    begin

        A <= "01111111";
        B <= "01111111";

        be_enable <= '1';
        be_rdnsft <= '1'; -- read A
        mg_enable <= '1';
        mg_rdnsft <= '1'; -- read B
        acc_clear <= '1';

        be_clk <= '0';
        mg_clk <= '0';
        acc_clock <= '0';
        wait for 5 ns;
        be_clk <= '1';
        mg_clk <= '1';
        acc_clock <= '1';
        wait for 5 ns;

        -- dont need this after the first cycle
        acc_clear <= '0';

        be_rdnsft <= '0'; -- shift A
        mg_rdnsft <= '0'; -- shift B

        -- start of loop
        for i in 0 to 7 loop
            be_clk <= '0';
            mg_clk <= '0';
            acc_clock <= '0';
            wait for 5 ns;
            be_clk <= '1';
            mg_clk <= '1';
            acc_clock <= '1';
            wait for 5 ns;    
        end loop;
        -- end of loop

        wait;
    end process;

end architecture behav;
