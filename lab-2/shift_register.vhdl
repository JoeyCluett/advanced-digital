library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_register is

    generic(buswidth: integer := 8);

    port(
        D   : in  std_logic_vector(buswidth-1 downto 0);
        Q   : out std_logic_vector(buswidth-1 downto 0);
        clk : in std_logic;
        rd_nsft : in std_logic; -- 1:read, 0:shft
        enable  : in std_logic;
        Dsftin  : in std_logic;
        Dsftout : out std_logic
    );

end entity shift_register;

architecture behav of shift_register is
    signal din  : std_logic_vector(buswidth-1 downto 0);
    signal qout : std_logic_vector(buswidth-1 downto 0);
    signal clockand : std_logic;

begin

    clockand <= clk and enable;
    din(0) <= (Dsftin and not rd_nsft) or (D(0) and rd_nsft);

    Q <= qout;

    sr:
        for i in 0 to buswidth-1 generate
            sr_i:
                entity work.d_ff(basic_arch)
                port map(din(i), clockand, qout(i), open);
        end generate;

    clogic:
        for i in 1 to buswidth-1 generate
            din(i) <= (qout(i-1) and not rd_nsft) or (D(i) and rd_nsft);
        end generate;

    Dsftout <= qout(buswidth-1);

end architecture behav;