library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Importante para conversões

entity test is
end entity;

architecture Testbench of test is
    -- Sinais para interligar com o componente
    signal p0, p1, p2, p3 : STD_LOGIC := '0';
    signal x1, x0, int    : STD_LOGIC;
begin

    -- Instância do codificador de prioridade
    DUT: entity work.exp5(Behavioral)
        port map (
            p0  => p0,
            p1  => p1,
            p2  => p2,
            p3  => p3,
            x1  => x1,
            x0  => x0,
            int => int
        );

    -- Processo de estímulo
    stimulus: process
        variable bin : std_logic_vector(3 downto 0);
    begin
        -- Varre todas as combinações possíveis de entradas (de 0000 até 1111)
        for i in 0 to 15 loop

            -- Converte o inteiro i para vetor de 4 bits
            bin := std_logic_vector(to_unsigned(i, 4));

            -- Atribui os bits aos sinais
            p0 <= bin(3); -- bit mais significativo
            p1 <= bin(2);
            p2 <= bin(1);
            p3 <= bin(0); -- bit menos significativo

            wait for 10 ns;
        end loop;

        wait;
    end process;
end architecture;