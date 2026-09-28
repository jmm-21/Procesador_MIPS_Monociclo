library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Mips_Nucleo1 is
--  Port ( );
end TB_Mips_Nucleo1;

architecture Behavioral of TB_Mips_Nucleo1 is

COMPONENT MIPS_nucleo1
	 PORT(
		 clock : IN STD_LOGIC;
		 pcout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 selreg : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 salreg : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	     );
END COMPONENT;

constant CLK_period : time := 10 ns;
signal clk: STD_LOGIC := '0';

signal w_selreg: STD_LOGIC_VECTOR (4 DOWNTO 0):= B"00011";
signal w_salreg: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal w_pcout: STD_LOGIC_VECTOR (7 DOWNTO 0);

begin
    uut: MIPS_nucleo1
    port map(
        clock => clk,
        pcout => w_pcout,
        selreg => w_selreg,
        salreg => w_salreg
    );

    CLK_process: process
    begin
        clk <= '0';
        wait for CLK_period/2;
        clk <= '1';
        wait for CLK_period/2;
    end process;

end Behavioral;
