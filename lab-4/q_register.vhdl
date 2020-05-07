library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity q_register is
    port(
        D    : in std_logic_vector(7 downto 0);
        Q    : out std_logic_vector(7 downto 0);
        clk  : in std_logic;
        Amsb : in std_logic;
        sh_rdnsft : in std_logic; -- 0:shift 1:read
        sh_en  : in std_logic;
        lsb_sel : in std_logic; -- 0:D0 1:Amsb
        sh_out  : out std_logic);
end entity q_register;

architecture behav of q_register is

    signal dff_out : std_logic;
    signal mux_out : std_logic;

begin

    Q(0) <= dff_out;

    mux_out <= (D(0) and not lsb_sel) or (Amsb and lsb_sel);

    dff: entity work.d_ff(basic_arch) port map(mux_out, clk, dff_out, open);

    shreg: entity work.shift_register(behav) generic map(7) 
    port map(
        D(7 downto 1),
        Q(7 downto 1),
        clk,
        sh_rdnsft,
        sh_en,
        dff_out,
        sh_out);

end architecture behav;
