library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity exp5 is
    Port (
        p0  : in  STD_LOGIC;   -- Maior prioridade (ativo em '0')
        p1  : in  STD_LOGIC;
        p2  : in  STD_LOGIC;
        p3  : in  STD_LOGIC;   -- Menor prioridade
        x1  : out STD_LOGIC;   -- Saída codificada (bit mais significativo)
        x0  : out STD_LOGIC;   -- Saída codificada (bit menos significativo)
        int : out STD_LOGIC    -- Sinal de interrupção (1 se qualquer entrada estiver ativa)
    );
end exp5;

architecture Behavioral of exp5 is
begin
    process(p0, p1, p2, p3)
    begin
        -- Sinal de interrupção (ativo se qualquer entrada for '0')
        if (p0 = '0' or p1 = '0' or p2 = '0' or p3 = '0') then
            int <= '1';
        else
            int <= '0';
        end if;

        -- Codificação de prioridade (prioridade da menor entrada numérica)
        if (p0 = '0') then
            x1 <= '0';
            x0 <= '0';
        elsif (p1 = '0') then
            x1 <= '0';
            x0 <= '1';
        elsif (p2 = '0') then
            x1 <= '1';
            x0 <= '0';
        elsif (p3 = '0') then
            x1 <= '1';
            x0 <= '1';
        else
            x1 <= '1';
            x0 <= '1';
        end if;
    end process;
end Behavioral;
