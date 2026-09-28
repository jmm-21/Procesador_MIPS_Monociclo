library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Seldigit_CodLEDS is
    Port ( regs : in  STD_LOGIC_VECTOR (15 downto 0);
           refresh : in  STD_LOGIC_VECTOR (1 downto 0);
           anodos : out  STD_LOGIC_VECTOR (3 downto 0);
           catodos: out  STD_LOGIC_VECTOR (7 downto 0));
end Seldigit_CodLEDS ;

architecture Behavioral of Seldigit_CodLEDS  is
signal HEXled: STD_LOGIC_VECTOR(6 DOWNTO 0); -- para concatenar con punto
signal punto: std_logic:='1'; -- se refiere al 1 rodeado en rojo en el pdf
signal digHEX: STD_LOGIC_VECTOR(3 DOWNTO 0);

alias digit3: STD_LOGIC_VECTOR(3 DOWNTO 0) is REGS(15 DOWNTO 12); --dividimos los 16 bits de 4 en 4
alias digit2: STD_LOGIC_VECTOR(3 DOWNTO 0) is REGS(11 DOWNTO 8);
alias digit1: STD_LOGIC_VECTOR(3 DOWNTO 0) is REGS(7 DOWNTO 4);
alias digit0: STD_LOGIC_VECTOR(3 DOWNTO 0) is REGS(3 DOWNTO 0);

COMPONENT dec2a4
	PORT(
		d : IN std_logic_vector(1 downto 0);          
		y : OUT std_logic_vector(0 to 3)
		);
	END COMPONENT;
	
	COMPONENT mux4a1_4bits
	PORT(
		d0 : IN std_logic_vector(3 downto 0);
		d1 : IN std_logic_vector(3 downto 0);
		d2 : IN std_logic_vector(3 downto 0);
		d3 : IN std_logic_vector(3 downto 0);
		sel : IN std_logic_vector(1 downto 0);          
		S : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT hex2led
	PORT(
		hex : IN std_logic_vector(3 downto 0);          
		led : OUT std_logic_vector(6 downto 0)
		);
	END COMPONENT;
	
begin
  catodos <= HEXled & punto;
  -- Instanciar el decodificador
  Inst_dec2a4: dec2a4 
  PORT MAP(
		  d => refresh,
		  y => anodos
	      );
	 
-- RELLENAR instanciar el componente mux4a1_4bits utilizado 
-- para seleccionar el digito hexadecimal a convertir a led (nombre de instancia Inst_mux4a1_4bits)
-- El mapeo debe realizarse d0 => digit3, d1 => digit2, d2 => digit1, d3 => digit0, sel => refresh, s => digHEX
    
    Inst_mux4a1_4bits: mux4a1_4bits
    PORT MAP(
            d0 => digit3,
            d1 => digit2,
            d2 => digit1,
            d3 => digit0,
            sel => refresh,
            s => digHEX
    );

-- RELLENAR instanciar el componente hex2led utilizado 
-- para convertir el digito hexadecimal recibido en la entrada a valores led (nombre de instancia Inst_hex2led)
-- El mapeo debe realizarse hex => digHEX, led => HEXled

    Inst_hex2led: hex2led
    PORT MAP(
            hex => digHEX,
            led => HEXled
    );

end Behavioral;
