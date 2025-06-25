library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ULA is
    port(
        -- sinais de entrada externos (ativos em 0)
        RESET_N  : in  std_logic;                       -- reset ativo baixo
        A_IN     : in  std_logic_vector(3 downto 0);    -- operando A (ativos em 0)
        B_IN     : in  std_logic_vector(3 downto 0);    -- operando B (ativos em 0)
        SS_IN    : in  std_logic_vector(1 downto 0);    -- seleção de operação (ativos em 0)
        -- saídas
        F_OUT    : out std_logic_vector(3 downto 0);    -- resultado F
        C_OUT    : out std_logic;                       -- carry out
        OVERFLOW : out std_logic;                       -- detecção de overflow
        S1_LED   : out std_logic;                       -- icone de seleção S1
        S0_LED   : out std_logic                        -- icone de seleção S0
    );
end entity;

architecture Behavioral of ULA is
    -- sinais internos (lógica positiva)
    signal A, B    : signed(3 downto 0);
    signal SS      : std_logic_vector(1 downto 0);
    signal reset_i : std_logic;
    signal sum5    : signed(4 downto 0);
    signal diff5   : signed(4 downto 0);
begin
    -- inverter entradas ativas em 0
    reset_i <= not RESET_N;
    A       <= signed(not A_IN);
    B       <= signed(not B_IN);
    SS      <= not SS_IN;

    -- indicar seleção nas LEDs
    S1_LED <= SS(1);
    S0_LED <= SS(0);

    alu_proc: process(reset_i, A, B, SS)
    begin
        if reset_i = '1' then
            F_OUT    <= (others => '0');
            C_OUT    <= '0';
            OVERFLOW <= '0';

        else
            case SS is
                -- soma A + B
                when "00" =>
                    sum5      <= signed('0' & A) + signed('0' & B);
                    F_OUT     <= std_logic_vector(sum5(3 downto 0));
                    C_OUT     <= sum5(4);
                    OVERFLOW  <= (A(3) and B(3) and not sum5(3))
                               or (not A(3) and not B(3) and sum5(3));

                -- subtração A - B
                when "01" =>
                    diff5     <= signed('0' & A) - signed('0' & B);
                    F_OUT     <= std_logic_vector(diff5(3 downto 0));
                    C_OUT     <= diff5(4);
                    OVERFLOW  <= (A(3) and not B(3) and not diff5(3))
                               or (not A(3) and B(3) and diff5(3));

                -- operação AND
                when "10" =>
                    F_OUT    <= std_logic_vector(A and B);
                    C_OUT    <= '0';
                    OVERFLOW <= '0';

                -- operação OR
                when "11" =>
                    F_OUT    <= std_logic_vector(A or B);
                    C_OUT    <= '0';
                    OVERFLOW <= '0';

                when others =>
                    -- situação não usada
                    F_OUT    <= (others => '0');
                    C_OUT    <= '0';
                    OVERFLOW <= '0';
            end case;
        end if;
    end process;

end architecture;
