library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel_datapath is
    port(
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);

        be_clk    : in std_logic;
        be_rdnsft : in std_logic;
        be_enable : in std_logic;

        mg_clk    : in std_logic;
        mg_rdnsft : in std_logic;
        mg_enable : in std_logic;

        acc_clear : in std_logic;
        acc_clock : in std_logic;

        result : out std_logic_vector(15 downto 0)
    );
end entity toplevel_datapath;

architecture behav of toplevel_datapath is
    signal sel_x  : std_logic;
    signal sel_nx : std_logic;
    signal mg_output : std_logic_vector(15 downto 0);
    signal adder_out : std_logic_vector(15 downto 0);
    signal feedback  : std_logic_vector(15 downto 0);
begin

    boothenc:
        entity work.booth_encoder(behav)
        generic map(8)
        port map(
            A,
            be_clk,
            be_rdnsft,
            sel_x,
            sel_nx,
            be_enable
        );

    mgen:
        entity work.multiplicand_generator(behav)
        port map(
            B,
            mg_output,
            sel_x,
            sel_nx,
            mg_clk,
            mg_rdnsft,
            mg_enable
        );

    adder:
        entity work.n_bit_adder(behav)
        generic map(16)
        port map(
            mg_output,
            feedback,
            adder_out,
            '0', -- carry in
            open -- carry out
        );

    acc:
        entity work.toplevel_accumulator(behav)
        generic map(16)
        port map(
            adder_out,
            feedback,
            acc_clear,
            acc_clock
        );

    result <= feedback;

end architecture behav;
