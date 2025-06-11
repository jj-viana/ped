library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Designação de entradas e saídas 
entity ALARMEE25 is
    Port ( porta : in STD_LOGIC;
           ignicao : in STD_LOGIC;
           farol : in STD_LOGIC;
           alarmeSom : out STD_LOGIC);
end ALARMEE25;

architecture Behavioral of ALARMEE25 is
    -- Sinais internos para as versões invertidas das entradas
    signal porta_inv, ignicao_inv, farol_inv : STD_LOGIC;
begin

    -- Inversão lógica das entradas
    porta_inv <= NOT porta;
    ignicao_inv <= NOT ignicao;
    farol_inv <= NOT farol;

    -- Nova lógica com as entradas invertidas
    alarmeSom <= NOT ((farol_inv AND NOT(ignicao_inv)) or (porta_inv AND ignicao_inv));

end Behavioral;
