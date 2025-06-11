
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY TB_alarme25 IS 
END TB_alarme25;


architecture behavior of TB_alarme25 is

	--designacao de entradas e saidas 
	COMPONENT ALARMEE25
		 Port ( porta : in STD_LOGIC;
				  ignicao : in STD_LOGIC;
				  farol : in STD_LOGIC;
				  alarmeSom : out STD_LOGIC);
	END COMPONENT;

		--sinais de estimulo
		
		--entradas
		SIGNAL porta : STD_LOGIC := '0';
		SIGNAL ignicao : STD_LOGIC := '0';
		SIGNAL farol : STD_LOGIC := '0';
		
		--saidas 
		SIGNAL alarmeSom : STD_LOGIC;

	begin
		uut: ALARMEE25 PORT MAP (
		porta => porta,
		ignicao => ignicao,
		farol => farol,
		alarmeSom => alarmeSom
		);
		
		stim_proc: PROCESS 
		BEGiN
			
			porta <= '0'; ignicao <= '0'; farol <= '0';
			WAIT FOR 10 ns;
			
			porta <= '0'; ignicao <= '0'; farol <= '1';
			WAIT FOR 10 ns;
			
			porta <= '0'; ignicao <= '1'; farol <= '0';
			WAIT FOR 10 ns;
			
			porta <= '0'; ignicao <= '1'; farol <= '1';
			WAIT FOR 10 ns;
			
			porta <= '1'; ignicao <= '0'; farol <= '0';
			WAIT FOR 10 ns;
			
			porta <= '1'; ignicao <= '0'; farol <= '1';
			WAIT FOR 10 ns;
			
			porta <= '1'; ignicao <= '1'; farol <= '0';
			WAIT FOR 10 ns;
			
			porta <= '1'; ignicao <= '1'; farol <= '1';
			WAIT FOR 10 ns;
			
		
		
		
		
		WAIT;
	END PROCESS;
END behavior;