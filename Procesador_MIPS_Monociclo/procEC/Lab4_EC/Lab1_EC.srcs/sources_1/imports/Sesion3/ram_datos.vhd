library IEEE;
use IEEE.std_logic_1164.all;  
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ram_datos is
	port (
		WE : in std_logic;
		CLK : in std_logic;
		ADDR : in std_logic_vector(7 downto 0);
		DATAin : in std_logic_vector(15 downto 0);
		DATAOUT : out std_logic_vector(15 downto 0)
	);
end entity;


architecture ram_arch of ram_datos is

-- type ram_mem_type is array (63 downto 0) of std_logic_vector(7 downto 0); 
-- se ha cambiado a sentido ascendente del tipo
	type ram_mem_type is array (0 to 255) of std_logic_vector(7 downto 0); 

-- número elementos del array : 6 
-- elementos del array:  +1,  +13,  +7, -40, -18, -Ngrup*100
	
	signal ram_mem : ram_mem_type := (
	            6 => X"00",
	            7 => X"0C", -- dir de inicio del array1
	            8 => X"00",
	            9 => X"20", -- dir. de inicio del array2 
	            10 => X"00",
	            11 => X"06",  
	     --  num. de elementos en 10 (ByteH) y 11(ByteL)
         -- DATOS ASOCIADOS AL NOMBRE a partir de la dirección 14
         -- NOMBRE correspondiente a estos datos: ALBERTO B
				12 => X"00",
				13 => X"0E", -- +14
			    14 => X"00",
			    15 => X"32", -- +50
				16 => X"FF", 
        		17 => X"CE", -- -50
				18 => X"FF", 
				19 => X"DE", -- -34
			    20 => X"00",
				21 => X"24", -- +36
				22 => X"FF", 
				23 => X"9C", --  - (1*100) = -100 (para grupo 1)
				others => X"00");	
												 
	signal bytealto, bytebajo: std_logic_vector(7 downto 0);

begin

	process (CLK)
	begin
		if rising_edge(CLK) then
			if (WE = '1') then
				ram_mem(CONV_INTEGER(ADDR)) <= DATAin(15 downto 8);
				ram_mem(CONV_INTEGER(ADDR + 1)) <= DATAin(7 downto 0);
			end if;
		end if;
	end process;

	bytealto <= ram_mem(CONV_INTEGER(ADDR));
	bytebajo  <= ram_mem(CONV_INTEGER(ADDR + 1));
	Dataout <=  bytealto & bytebajo;

end architecture;
