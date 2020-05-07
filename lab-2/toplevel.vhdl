library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is

    port(
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        result : out std_logic_vector(15 downto 0);
        clock : in std_logic;
        reset : in std_logic;
        start : in std_logic;
        done  : out std_logic
    );

end entity toplevel;

architecture behav of toplevel is

    -- series of signals connecting the two toplevel entities

    signal be_clk    : std_logic;
    signal be_rdnsft : std_logic;
    signal be_enable : std_logic;

    signal mg_clk    : std_logic;
    signal mg_rdnsft : std_logic;
    signal mg_enable : std_logic;
    
    signal acc_clear : std_logic;
    signal acc_clock : std_logic;

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

    cnt:
        entity work.toplevel_control(behav)
        port map(
            be_clk, be_rdnsft, be_enable,
            mg_clk, mg_rdnsft, mg_enable,
            acc_clear, acc_clock,
            clock,
            reset,
            start,
            done
        );

end architecture behav;
