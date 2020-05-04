library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- produces either x or -x. if no input signals are given, produces zero
entity multiplicand_generator is

    port(
        input_val  : in std_logic_vector(7 downto 0);
        output_val : out std_logic_vector(15 downto 0);
        sel_x      : in std_logic;
        sel_neg_x  : in std_logic;
        clock      : in std_logic;
        rd_nsft    : in std_logic;
        enable     : in std_logic
    );

end entity multiplicand_generator;

architecture behav of multiplicand_generator is

    signal input_sign_ext : std_logic_vector(15 downto 0);
    signal reg_output     : std_logic_vector(15 downto 0);

    signal adder_input : std_logic_vector(15 downto 0);
    signal adder_output : std_logic_vector(15 downto 0);

    signal mux_0 : std_logic_vector(15 downto 0);
    signal mux_1 : std_logic_vector(15 downto 0);

    signal mux_select : std_logic;

begin

    se: process(input_val)
        begin
            input_sign_ext(7 downto 0) <= input_val;

            if(input_val(7) = '1') then
                input_sign_ext(15 downto 8) <= "11111111";
            else
                input_sign_ext(15 downto 8) <= "00000000";
            end if;
        end process;

    sh_reg: 
        entity work.shift_register(behav)
        generic map(16)
        port map(
            input_sign_ext,
            reg_output,
            clock,
            rd_nsft,
            enable,
            '0', -- sftin
            open -- sftout
        );

    invbits:
        for i in 0 to 15 generate
            adder_input(i) <= not reg_output(i);
        end generate;

    adder:
        entity work.n_bit_adder(behav)
        generic map(16)
        port map(
            adder_input,
            "0000000000000000",
            adder_output,
            '1', -- carry in
            open -- carry out
        );

    selectline: process(sel_x, sel_neg_x)
    begin
        if (sel_x = '1') and (sel_neg_x = '0') then
            mux_select <= '0';
        elsif (sel_x = '0') and (sel_neg_x = '1') then
            mux_select <= '1';
        else
            mux_select <= 'Z';
        end if;
    end process;

    mux_0 <= reg_output;
    mux_1 <= adder_output;

    mux:
        entity work.multiplexer(behav)
        generic map(16)
        port map(
            mux_0,
            mux_1,
            output_val,
            mux_select,
            '1' -- enable
        );

end architecture behav;
