library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ULA is
    port (
        RESET_N  : in  std_logic;                           -- ativo baixo
        A_IN     : in  std_logic_vector(3 downto 0);        -- operando A (já invertido externamente, se necessário)
        B_IN     : in  std_logic_vector(3 downto 0);        -- operando B
        SS_IN    : in  std_logic_vector(1 downto 0);        -- seletor de operação ("00"=AND, "01"=OR, "10"=ADD, "11"=SUB)
        F_OUT    : out std_logic_vector(3 downto 0);        -- resultado
        C_OUT    : out std_logic;                           -- carry out
        OVERFLOW : out std_logic;                           -- overflow
        S1_LED   : out std_logic;                           -- indica SS_IN(1) ativo
        S0_LED   : out std_logic                            -- indica SS_IN(0) ativo
    );
end entity ULA;

architecture rtl of ULA is
    signal a, b    : signed(3 downto 0);
    signal sum     : signed(4 downto 0);
    signal result  : signed(3 downto 0);
    signal carry   : std_logic;
    signal ovf     : std_logic;
begin
    -- registros de reset síncrono
    process(CLK: std_logic) is  -- se seu ULA usar clock interno, caso contrário remova este processo
    begin
        if rising_edge(CLK) then
            if RESET_N = '0' then
                F_OUT    <= (others => '0');
                C_OUT    <= '0';
                OVERFLOW <= '0';
                S1_LED   <= '1';
                S0_LED   <= '1';
            else
                -- mapear entradas ao tipo signed (inverte bit a bit se necessário fora daqui)
                a <= signed(A_IN);
                b <= signed(B_IN);

                -- operação selecionada
                case SS_IN is
                    when "00" =>
                        result <= a and b;
                        carry  <= '0';
                        ovf    <= '0';
                    when "01" =>
                        result <= a or b;
                        carry  <= '0';
                        ovf    <= '0';
                    when "10" =>  -- soma
                        sum    <= ('0' & a) + ('0' & b);
                        result <= sum(3 downto 0);
                        carry  <= sum(4);
                        -- overflow: sinais de carry nos bits 2 e 3 diferem
                        ovf    <= sum(3) xor sum(4);
                    when "11" =>  -- subtração A - B = A + (-B)
                        sum    <= ('0' & a) + ('0' & not b) + 1;
                        result <= sum(3 downto 0);
                        carry  <= sum(4);
                        ovf    <= sum(3) xor sum(4);
                    when others =>
                        result <= (others => '0');
                        carry  <= '0';
                        ovf    <= '0';
                end case;

                -- sinais de saída
                F_OUT    <= std_logic_vector(result);
                C_OUT    <= carry;
                OVERFLOW <= ovf;
                S1_LED   <= SS_IN(1);
                S0_LED   <= SS_IN(0);
            end if;
        end if;
    end process;
end architecture rtl;
