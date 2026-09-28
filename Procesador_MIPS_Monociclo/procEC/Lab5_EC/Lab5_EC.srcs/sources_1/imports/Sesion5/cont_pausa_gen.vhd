library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- divide por 2**n la frecuencia reloj

entity cont_pausa_gen is
    generic (n: natural:=2); -- valor por defecto: 
    -- al instanciar el componente, poner n a 2 para simulacion y 7 para sintesis
    Port ( clock : in  STD_LOGIC;
           pausa : in  STD_LOGIC;
           clk_sal : out  STD_LOGIC);
end cont_pausa_gen;

architecture Behavioral of cont_pausa_gen is
signal cont: std_logic_vector(n-1 downto 0):= (others => '0'); 
begin
   process(clock)
	begin
    if rising_edge(clock) then
			  if pausa = '1' then
			    cont <= cont + 1;
			  end if;
	 end if;
	end process;
clk_sal <= cont(n-1);
end Behavioral;

