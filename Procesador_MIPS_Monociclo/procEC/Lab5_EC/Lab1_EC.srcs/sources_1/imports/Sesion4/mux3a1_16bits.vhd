library IEEE;
use IEEE.std_logic_1164.all;

entity mux3a1_16bits is
	port (
		D0 : in std_logic_vector(15 downto 0);
		D1 : in std_logic_vector(15 downto 0);
		D2 : in std_logic_vector(15 downto 0);
		Sel : in std_logic_vector(1 downto 0);
		F : out std_logic_vector(15 downto 0)
	);
end entity;


library IEEE;
use IEEE.std_logic_unsigned.all;

architecture core of mux3a1_16bits is

begin

	process (Sel, D0, D1, D2)
	begin
		case CONV_INTEGER(Sel) is
			when 0 => F <= D0;
			when 1 => F <= D1;
			when 2 => F <= D2;
			when others => F <= (others => '0');
		end case;
	end process;

end architecture;
