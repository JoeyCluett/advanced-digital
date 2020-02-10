library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture test_freq_divider of testbench is

    -- component to test
    component freq_divider is
        port(
            config : in std_logic_vector(31 downto 0); 
            inclk  : in std_logic; 
            outclk : out std_logic;
            nReset  : in std_logic -- active low signal
        );
    end component;

    signal sim_config : std_logic_vector(31 downto 0);
    signal sim_inclk  : std_logic;
    signal sim_outclk : std_logic;
    signal sim_nReset : std_logic;

begin

    fd: freq_divider port map(
        sim_config,
        sim_inclk,
        sim_outclk,
        sim_nReset
    );

    -- convert a nice easy integer to the logic_vector needed by freq_divider
    sim_config <= std_logic_vector(to_unsigned(  4  , sim_config'length));

    sim: process
    begin

        -- reset the device
        sim_inclk <= '0'; sim_nReset <= '0'; wait for 5 ns;
        sim_inclk <= '1'; wait for 5 ns;
        sim_inclk <= '0'; wait for 5 ns;
        sim_nReset <= '1'; wait for 5 ns;

        for idx in 0 to 500
        loop

            -- simulate clock cycles internally
            sim_inclk <= '1'; wait for 10 ns;
            sim_inclk <= '0'; wait for 10 ns; --report "output " & std_logic'image(sim_outclk);

        end loop;

        wait;

    end process;

end architecture test_freq_divider;
