
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--designacao de entradas e saidas 
entity alarme is
    Port ( porta : in STD_LOGIC;
           ignicao : in STD_LOGIC;
           farol : in STD_LOGIC;
           alarmeSom : out STD_LOGIC);
end alarme;

architecture Behavioral of alarme is

begin
alarmeSom <= (farol AND NOT(ignicao)) or (porta AND ignicao);

end Behavioral;