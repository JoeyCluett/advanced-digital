library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_nbitadder is
end entity testbench_nbitadder;

architecture testbench of testbench_nbitadder is

    signal sim_A    : std_logic_vector(7 downto 0); -- A input
    signal sim_B    : std_logic_vector(7 downto 0); -- B input
    signal sim_Sum  : std_logic_vector(7 downto 0); -- Sum output
    signal sim_Cin  : std_logic; -- Carry in bit
    signal sim_Cout : std_logic; -- Carry out bit

begin

    adder: 
        entity work.n_bit_adder(behav) 
        generic map(8)
        port map(sim_A, sim_B, sim_Sum, sim_Cin, sim_Cout);

    sim: process
    begin

        sim_A <= "00000000";
        sim_B <= "00000000";
        sim_Cin <= '0';
        wait for 5 ns;

        sim_A <= "00000000";
        sim_B <= "00000000";
        sim_Cin <= '1';
        wait for 5 ns;

        sim_A <= "01010101";
        sim_B <= "10101010";
        sim_Cin <= '0';
        wait for 5 ns;

        sim_A <= "01010101";
        sim_B <= "10101010";
        sim_Cin <= '1';
        wait for 5 ns;


        sim_A <= "00001111";
        sim_B <= "00001111";
        sim_Cin <= '0';
        wait for 5 ns;

        sim_A <= "00001111";
        sim_B <= "00000000";
        sim_Cin <= '1';
        wait for 5 ns;

        wait;

    end process;

end architecture testbench;
