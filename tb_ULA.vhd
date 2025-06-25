library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_ULA is
end entity;

architecture sim of tb_ULA is
    -- Component declaration
    component ULA
        port(
            RESET_N  : in  std_logic;
            A_IN     : in  std_logic_vector(3 downto 0);
            B_IN     : in  std_logic_vector(3 downto 0);
            SS_IN    : in  std_logic_vector(1 downto 0);
            F_OUT    : out std_logic_vector(3 downto 0);
            C_OUT    : out std_logic;
            OVERFLOW : out std_logic;
            S1_LED   : out std_logic;
            S0_LED   : out std_logic
        );
    end component;

    -- sinais de estímulo
    signal RESET_N_s  : std_logic := '0';
    signal A_IN_s     : std_logic_vector(3 downto 0) := (others => '1');
    signal B_IN_s     : std_logic_vector(3 downto 0) := (others => '1');
    signal SS_IN_s    : std_logic_vector(1 downto 0) := (others => '1');
    signal F_OUT_s    : std_logic_vector(3 downto 0);
    signal C_OUT_s    : std_logic;
    signal OVERFLOW_s : std_logic;
    signal S1_LED_s   : std_logic;
    signal S0_LED_s   : std_logic;

begin
    -- instancia ULA
    uut: ULA
        port map (
            RESET_N  => RESET_N_s,
            A_IN     => A_IN_s,
            B_IN     => B_IN_s,
            SS_IN    => SS_IN_s,
            F_OUT    => F_OUT_s,
            C_OUT    => C_OUT_s,
            OVERFLOW => OVERFLOW_s,
            S1_LED   => S1_LED_s,
            S0_LED   => S0_LED_s
        );

    -- processo de estímulos
    stim_proc: process
    begin
        -- reset ativo
        RESET_N_s <= '0';
        wait for 20 ns;
        RESET_N_s <= '1';
        wait for 20 ns;

        -- soma: 3 + 5 = 8
        A_IN_s  <= not std_logic_vector(to_unsigned(3,4));
        B_IN_s  <= not std_logic_vector(to_unsigned(5,4));
        SS_IN_s <= not "00";
        wait for 40 ns;

        -- subtração: 2 - 7 = -5 (overflow)
        A_IN_s  <= not std_logic_vector(to_unsigned(2,4));
        B_IN_s  <= not std_logic_vector(to_unsigned(7,4));
        SS_IN_s <= not "01";
        wait for 40 ns;

        -- AND: 6 and 3 = 2
        A_IN_s  <= not std_logic_vector(to_unsigned(6,4));
        B_IN_s  <= not std_logic_vector(to_unsigned(3,4));
        SS_IN_s <= not "10";
        wait for 40 ns;

        -- OR: 9 or 4 = 13
        A_IN_s  <= not std_logic_vector(to_unsigned(9,4));
        B_IN_s  <= not std_logic_vector(to_unsigned(4,4));
        SS_IN_s <= not "11";
        wait for 40 ns;

        -- fim
        wait;
    end process;
end architecture;
