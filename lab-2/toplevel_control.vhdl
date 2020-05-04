library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_control is
    port(
        be_clk    : out std_logic;
        be_rdnsft : out std_logic;
        be_enable : out std_logic;

        mg_clk    : out std_logic;
        mg_rdnsft : out std_logic;
        mg_enable : out std_logic;

        acc_clear : out std_logic;
        acc_clock : out std_logic;

        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic
    );
end entity toplevel_control;

architecture behav of toplevel_control is

    signal state: integer;

    signal sel_be_clk    : std_logic;
    signal sel_be_rdnsft : std_logic;
    signal sel_be_enable : std_logic;

    signal sel_mg_clk    : std_logic;
    signal sel_mg_rdnsft : std_logic;
    signal sel_mg_enable : std_logic;

    signal sel_acc_clear : std_logic;
    signal sel_acc_clock : std_logic;

begin

    be_clk    <= sel_be_clk and clock;
    be_rdnsft <= sel_be_rdnsft;
    be_enable <= sel_be_enable;

    mg_clk    <= sel_mg_clk and clock;
    mg_rdnsft <= sel_mg_rdnsft;
    mg_enable <= sel_mg_enable;

    acc_clock <= sel_acc_clock and clock;
    acc_clear <= sel_acc_clear;

    proc: process(clock)
    begin

        if rising_edge(clock) then

            if reset = '1' then 
                state = 0; 

                sel_be_clk    <= '1';
                sel_be_rdnsft <= '1'; -- read A
                sel_be_enable <= '1';

                sel_mg_clk    <= '1';
                sel_mg_rdnsft <= '1'; -- read B
                sel_mg_enable <= '1';

                sel_acc_clear <= '1';
                sel_acc_clock <= '1';

            else
                if state = 0 then

                    -- setup cycle

                    if start='1' then
                        state=1;

                        sel_be_rdnsft <= '0'; -- shift A
                        sel_mg_rdnsft <= '0'; -- shift B
                        sel_acc_clear <= '0'; -- dont need to clear anymore

                    end if;

                elsif state <= 7 then

                    -- 8 computation cycles
                    state := state + 1;

                else
                    -- wait for start signal
                    state = 0;
                end if;
            end if;
        end if;
    end process;

end architecture behav;
