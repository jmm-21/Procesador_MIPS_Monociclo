library IEEE;
use IEEE.std_logic_1164.all;

entity registro_PC is
	port (
		CLK : in std_logic;
		DATA : in std_logic_vector(15 downto 0);
		Q : out std_logic_vector(15 downto 0)
	);
end entity;

architecture definitiva of registro_PC is
 signal	  Qint: std_logic_vector(15 downto 0):= (others => '0');
begin											    

	process (CLK)
	begin
      if rising_edge(CLK) then
			   Qint <= DATA;
		end if;

	end process; 
	 Q <= Qint;

end definitiva;
