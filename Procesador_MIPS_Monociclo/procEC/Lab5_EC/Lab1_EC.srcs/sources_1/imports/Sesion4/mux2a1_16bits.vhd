library IEEE;
use IEEE.std_logic_1164.all;

entity mux2a1_16bits is
	port (
		D0 : in std_logic_vector(15 downto 0);
		D1 : in std_logic_vector(15 downto 0);
		S : in std_logic;
		F : out std_logic_vector(15 downto 0)
	);
end entity;


library IEEE;
use IEEE.std_logic_unsigned.all;

architecture mux_arch of mux2a1_16bits is
begin

	process (S, D0, D1)
	begin
		if S = '0' then
			 F <= D0;
		else
			 F <= D1;
		end if;
	end process;

end architecture;
