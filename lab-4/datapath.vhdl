library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is

    port(
        divisor   : in  std_logic_vector(3 downto 0);
        dividend  : in  std_logic_vector(7 downto 0);
        quotient  : out std_logic_vector(7 downto 0);
        remainder : out std_logic_vector(7 downto 0);
        
        m_clock   : in std_logic;
        a_clock   : in std_logic;
        q_clock   : in std_logic;
        fb_enable : in std_logic; -- feedback loop enable (goes to A input)
        
        A_rdnsft  : in std_logic;
        A_enable  : in std_logic;

        Q_shreg_rdnsft : in std_logic;
        Q_lsb_sel : in std_logic;
        Q_shreg_en : in std_logic;
        
        add_msb : out std_logic);

end entity;

architecture behav of datapath is

    signal divisor_se : std_logic_vector(7 downto 0);
    signal M_q : std_logic_vector(7 downto 0);
    signal M_out : std_logic_vector(7 downto 0);
    signal A_out : std_logic_vector(7 downto 0);

    signal feedback    : std_logic_vector(7 downto 0);
    signal feedback_en : std_logic_vector(7 downto 0);

    signal q_sftout   : std_logic;
    signal fbloop_msb : std_logic;

begin

    d_ze: entity work.zero_extender(behav) generic map(4, 8) port map(divisor, divisor_se);
    M:    entity work.reg(behav) generic map(8) port map(divisor_se, M_q, open, m_clock);
    Mneg: entity work.negate(behav) generic map(8) port map(divisor_se, M_out);

    fben: entity work.selector(behav) generic map(8) port map(feedback, feedback_en, fb_enable);

    A: 
        entity work.shift_register(behav) 
        generic map(8) 
        port map(
            feedback_en, A_out, a_clock, A_rdnsft, A_enable, q_sftout, open);

    remainder <= feedback;
    add_msb <= feedback(7);

    Q: 
        entity work.q_register(behav)
        port map(
            dividend,
            quotient,
            q_clock,
            feedback(7), -- Amsb
            Q_shreg_rdnsft,
            Q_shreg_en,
            Q_lsb_sel,
            q_sftout);

    fbloop_msb <= not feedback(7);

    add: entity work.adder(behav) generic map(8) port map(M_out, A_out, feedback, '0', open);

end architecture behav;
