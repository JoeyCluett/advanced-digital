library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench_datapath is
end entity testbench_datapath;

architecture behav of testbench_datapath is

    signal divisor   : std_logic_vector(3 downto 0);
    signal dividend  : std_logic_vector(7 downto 0);
    signal quotient  : std_logic_vector(7 downto 0);
    signal remainder : std_logic_vector(7 downto 0);
    
    signal m_clock   : std_logic;
    signal a_clock   : std_logic;
    signal q_clock   : std_logic;
    signal fb_enable : std_logic; -- feedback loop enable (goes to A input) also helps clear A
    
    signal A_rdnsft : std_logic; -- 1:read 0:shift
    signal A_enable : std_logic;

    signal Q_shreg_rdnsft : std_logic;
    signal Q_lsb_sel  : std_logic;
    signal Q_shreg_en : std_logic;

    signal add_msb : std_logic;

begin

    ent:
        entity work.datapath(behav)
        port map(
            divisor, dividend, quotient, remainder,
            m_clock, a_clock, q_clock, fb_enable,
            A_rdnsft, A_enable,
            Q_shreg_rdnsft, Q_lsb_sel, Q_shreg_en);

    proc: process
    begin

        dividend <= "00001011"; --  11
        divisor  <= "0011";     -- / 3

        A_enable <= '1';
        A_rdnsft <= '1'; -- read
        fb_enable <= '0'; -- A needs zero-init
        Q_shreg_en <= '1';
        Q_shreg_rdnsft <= '1'; -- read Q        
        Q_lsb_sel <= '0'; -- read D(0)

        m_clock <= '0';
        a_clock <= '0';
        q_clock <= '0';
        wait for 5 ns;
        m_clock <= '1';
        a_clock <= '1';
        q_clock <= '1';
        wait for 5 ns;

        for i in 0 to 7 loop

            -- shift AQ
            A_rdnsft <= '0';       -- shift A
            Q_shreg_rdnsft <= '0'; -- shift Q      

            m_clock <= '0';
            a_clock <= '0';
            q_clock <= '0';
            wait for 5 ns;
            m_clock <= '1';
            a_clock <= '1';
            q_clock <= '1';
            wait for 5 ns;

            if add_msb = '1' then
                
            else
                
            end if;

        end loop;

        wait;
    end process;

end architecture behav;
