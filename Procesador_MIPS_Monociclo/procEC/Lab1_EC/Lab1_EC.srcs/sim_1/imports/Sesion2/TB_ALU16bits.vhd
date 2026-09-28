library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_ALU16bits is
end TB_ALU16bits;

architecture Behavioral of TB_ALU16bits is

COMPONENT ALU16bits 
	 port(
		 A : in STD_LOGIC_VECTOR(15 downto 0);
		 B : in STD_LOGIC_VECTOR(15 downto 0);
		 con : in STD_LOGIC_VECTOR(2 downto 0);
		 z : out STD_LOGIC;
		 res : out STD_LOGIC_VECTOR(15 downto 0)
	     );
END COMPONENT;

--input
signal A : STD_LOGIC_VECTOR (15 downto 0) := X"000C";
signal B : STD_LOGIC_VECTOR (15 downto 0) := X"000F";
signal con : STD_LOGIC_VECTOR (2 downto 0) := (others => '1');
--output
signal z : STD_LOGIC;
signal res : STD_LOGIC_VECTOR (15 downto 0);

begin
    uut: ALU16bits PORT MAP(
        A => A,
        B => B,
        con => con,
        z => z,
        res => res
        );

    --stimulus process
    stim_proc: process
    begin
		-- primer set de pruebas, a ordenar de acuerdo a las especificaciones de la práctica
        wait for 20 ns;
        con <= "000";
        wait for 10 ns;
        con <= "010";
        wait for 10 ns;
        con <= "001";
        wait for 10 ns;
        con <= "011";
        wait for 10 ns;
        con <= "100";
        wait for 10 ns;
        con <= "110";
        wait for 10 ns;
        -- segundo set de pruebas, probamos con un valor menor del segundo operando
        B <= X"0004";
        con <= "010";
        wait for 10 ns;
        con <= "110";
        wait for 10 ns;
        con <= "111";
        wait;                           
    end process;

end Behavioral;
