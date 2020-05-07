library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity toplevel is

    port(
        A : in std_logic_vector(6 downto 0);
        B : in std_logic_vector(6 downto 0);
        Result : out std_logic_vector(13 downto 0)
    );

end entity toplevel;

architecture behav of toplevel is

    signal a0 : std_logic_vector(6 downto 0);
    signal a1 : std_logic_vector(6 downto 0);
    signal a2 : std_logic_vector(6 downto 0);
    signal a3 : std_logic_vector(6 downto 0);
    signal a4 : std_logic_vector(6 downto 0);
    signal a5 : std_logic_vector(6 downto 0);
    signal a6 : std_logic_vector(6 downto 0);

    signal a0_m : std_logic_vector(13 downto 0);
    signal a1_m : std_logic_vector(13 downto 0);
    signal a2_m : std_logic_vector(13 downto 0);
    signal a3_m : std_logic_vector(13 downto 0);
    signal a4_m : std_logic_vector(13 downto 0);
    signal a5_m : std_logic_vector(13 downto 0);
    signal a6_m : std_logic_vector(13 downto 0);

    signal level_0_sum : std_logic_vector(13 downto 0);
    signal level_0_car : std_logic_vector(14 downto 0);

    signal level_1_sum : std_logic_vector(13 downto 0);
    signal level_1_car : std_logic_vector(14 downto 0);

    signal level_2_sum : std_logic_vector(13 downto 0);
    signal level_2_car : std_logic_vector(14 downto 0);

    signal level_3_sum : std_logic_vector(13 downto 0);
    signal level_3_car : std_logic_vector(14 downto 0);

    signal level_4_sum : std_logic_vector(13 downto 0);
    signal level_4_car : std_logic_vector(14 downto 0);

begin

    level_0_car(0) <= '0';
    level_1_car(0) <= '0';
    level_2_car(0) <= '0';
    level_3_car(0) <= '0';
    level_4_car(0) <= '0';

    level0: entity work.carry_save_adder(behav) generic map(14)
    port map(
        a0_m, a1_m, a2_m, 
        level_0_sum, level_0_car(14 downto 1));

    level1: entity work.carry_save_adder(behav) generic map(14)
    port map(
        a3_m, a4_m, a5_m, 
        level_1_sum, level_1_car(14 downto 1));

    level2: entity work.carry_save_adder(behav) generic map(14)
    port map(
        level_0_sum, level_0_car(13 downto 0), level_1_sum(13 downto 0),
        level_2_sum, level_2_car(14 downto 1));

    level3: entity work.carry_save_adder(behav) generic map(14)
    port map(
        level_2_sum, level_2_car(13 downto 0), level_1_car(13 downto 0),
        level_3_sum, level_3_car(14 downto 1));

    level4: entity work.carry_save_adder(behav) generic map(14)
    port map(
        level_3_sum, level_3_car(13 downto 0), a6_m,
        level_4_sum, level_4_car(14 downto 1));

    -- regular adder
    levelfinal: entity work.adder(behav) generic map(14)
    port map(
        level_4_sum, level_4_car(13 downto 0), 
        Result(13 downto 0), '0', open);

    a0_m <= "0000000" & a0 & "";
    a1_m <= "000000" & a1 & "0";
    a2_m <= "00000" & a2 & "00";
    a3_m <= "0000" & a3 & "000";
    a4_m <= "000" & a4 & "0000";
    a5_m <= "00" & a5 & "00000";
    a6_m <= "0" & a6 & "000000";

    -- generate partial products
    c_a0: entity work.selector(behav) generic map(7) port map(A, a0, B(0));
    c_a1: entity work.selector(behav) generic map(7) port map(A, a1, B(1));
    c_a2: entity work.selector(behav) generic map(7) port map(A, a2, B(2));
    c_a3: entity work.selector(behav) generic map(7) port map(A, a3, B(3));
    c_a4: entity work.selector(behav) generic map(7) port map(A, a4, B(4));
    c_a5: entity work.selector(behav) generic map(7) port map(A, a5, B(5));
    c_a6: entity work.selector(behav) generic map(7) port map(A, a6, B(6));

end architecture behav;
