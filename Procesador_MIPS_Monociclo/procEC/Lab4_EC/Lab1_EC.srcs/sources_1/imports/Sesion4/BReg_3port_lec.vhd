--  SE HA AÑADIDO UN PUERTO ADICIONAL DE LECTURA PARA VISUALIZAR UNA
--  POSICION DE MEMORIA Y MOSTRARLA EN LOS LEDS DE LA TARJETA
------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;  
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BReg_3port is
port (
clk : in std_logic;
-- señal para activar escritura
we: in std_logic;
-- dirección de escritura
Dirw: in std_logic_vector(4 downto 0); 
-- Dato de escritura
Data: in std_logic_vector(15 downto 0);	
-- dirección de lectura puerto A
Dira: in std_logic_vector(4 downto 0);
-- dirección de lectura puerto B
Dirb: in std_logic_vector(4 downto 0);
-- dirección de lectura puerto B
Dirt: in std_logic_vector(4 downto 0);
-- dato leido por puerto para Tarjeta
A: out std_logic_vector(15 downto 0);
-- dato leido por puerto B	
B: out std_logic_vector(15 downto 0); 
-- dato leido por puerto salida para tarjeta	
T: out std_logic_vector(15 downto 0)
 );
end entity;

architecture ram_arch of BReg_3port  is
type tipo_ram_2port is array (0 to 31) of std_logic_vector(15 downto 0); 
-- número de registros : 32 
signal banco_reg: tipo_ram_2port:= ( 4 => X"000C", others => X"0000");
	    --  registro 4 puede incicializarse con dirección tabla
begin
	process (CLK)
	begin
		if rising_edge(CLK) then
			if (WE = '1') then
			    if (Dirw /= "00000") then
				  banco_reg(CONV_INTEGER(dirw)) <= DATA(15 downto 0);
			    end if;
			 end if;
		end if;
	end process;

	A <= banco_reg(CONV_INTEGER(DirA));
	B <= banco_reg(CONV_INTEGER(DirB));
	T <= banco_reg(CONV_INTEGER(DirT));	
end architecture;
