library IEEE;
use IEEE.std_logic_1164.all;

entity TB_Mips_interface is
end TB_Mips_interface;	 


architecture Struct of TB_Mips_interface is

	signal wclk :STD_LOGIC:='0';
	signal wclock_en :STD_LOGIC:= '1';	
	signal wselREG : STD_LOGIC_VECTOR (3 downto 0):=(1 =>'1', others => '0');
	signal wanodos : STD_LOGIC_VECTOR (3 downto 0);
	signal wHEXleds: STD_LOGIC_VECTOR(7 DOWNTO 0);	 
	signal wpc_LSB:  STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	component mips_interface 
		port (
		  clk100Mhz : IN STD_LOGIC; -- OSCILADOR
	      clock_en: in std_logic; -- SW7
	      selREG: IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- SW3,SW2,SW1,SW0
	      anodos: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
          HEXleds: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- siete segmentos
	      pc_LSB: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		); 
	end component;
	
	constant CLK_period: time:= 100 ns;

begin

 Project: mips_interface
	port map(wclk, wclock_en, wselREG, wanodos,
	         wHEXleds, wpc_LSB);
	
	process
	begin
		wclk <= '0';
		wait for CLK_period/2;
		wclk <= '1';
		wait for CLK_period/2;
	end process;

	process
	begin
		wait for 20000 ns;
		wclock_en <='0';
		wait for 5000 ns; 
	   wclock_en <='1'; 
		wait for 170 us;
		wclock_en <='0';
		wait for 8000 ns; 
	   wclock_en <='1'; 
		wait;
	end process;

end struct;
