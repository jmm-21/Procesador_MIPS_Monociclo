LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL; -- necesario
 
ENTITY TB_ram_datos IS
END TB_ram_datos;
 
ARCHITECTURE behavior OF TB_ram_datos IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ram_datos
    PORT(
         WE : IN  std_logic;
         CLK : IN  std_logic;
         ADDR : IN  std_logic_vector(7 downto 0);
         DATAin : IN  std_logic_vector(15 downto 0);
         DATAOUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal WE : std_logic := '0';
   signal CLK : std_logic := '0';
   signal ADDR : std_logic_vector(7 downto 0) := (others => '0');
   signal DATAin : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal DATAOUT : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ram_datos PORT MAP (
          WE => WE,
          CLK => CLK,
          ADDR => ADDR,
          DATAin => DATAin,
          DATAOUT => DATAOUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
	variable dir_palabra: std_logic_vector(3 downto 0); -- 16 datos
   begin		
      -- hold reset state for 20 ns.
      wait for CLK_period;
      -- COMPROBACIÓN DE ESCRITURA	
		-- primero intentamos escribir un dato cualquiera (ej.:-8)
		-- en la dirección (2,3). 
		addr <= X"02";
		DATAin <= (2 downto 0 => '0', others => '1'); -- -8		
      wait for CLK_period;
        -- ahora intentamos escribir otro dato diferente (ej.:-16)
        -- en esa misma dirección (2,3)
        DATAin <= (3 downto 0 => '0', others => '1'); -- -16 
      	WE <= '1';  -- activamos la señal de habilitación de escritura
      wait for CLK_period;	
        WE <= '0'; -- desactivamos la señal de habilitación de escritura
        -- cambiamos ahora la dirección a una diferente (6,7) 
        addr <= X"06";
        -- si no modificamos DATAin, se intentará escribir el -16 en dicha dirección 	
      wait for CLK_period;
        -- intentamos ahora escribir un dato diferente (ej.: -32) en otra dirección (4,5)
        addr <= X"04";                
        DATAin <= (4 downto 0 => '0', others => '1'); -- -32
        WE <= '1';  -- activamos la señal de habilitación de escritura
	  wait for CLK_period*2;
	    WE <= '0'; -- deshabilitamos escritura
	   	   
		-- COMPROBACION DE LECTURA
		-- Leemos solamente los 32 primeros bytes de memoria
		-- el resto está vacío relleno de ceros.
		-- solamente hay que suministrar direcciones pares
      for i in 0 to 15 loop
		  dir_palabra:= conv_std_logic_vector(i,4);
		  addr <= "000"& dir_palabra & '0' ; -- dirección par de 8 bits
		  wait for CLK_period ;
	   end loop;

      wait;
   end process;

END;
