library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- divide la frecuencia por 2, 4,  2 elevado a n
entity cont_div_frec_refresh is
    generic (n: natural:=3); -- valor por defecto
    -- al instanciar el componente, poner n a 3 para simulacion y 19 para sintesis
    Port ( clk100Mhz : in  STD_LOGIC;
	        refresh: out STD_LOGIC_VECTOR (1 downto 0);
           clk_hercios : out  STD_LOGIC);
end cont_div_frec_refresh;

architecture Behavioral of cont_div_frec_refresh is	 
signal clk: std_logic;
signal count: std_logic_vector(n - 1 downto 0):= (others => '0'); 

begin

process (clk) 
begin
   if clk='1' and clk'event then
        count <= count + 1;
   end if;
end process;
clk_hercios <= count(n -1); 
refresh <= count(n-2 downto n-3); 
clk <= clk100Mhz;
 
end Behavioral;


