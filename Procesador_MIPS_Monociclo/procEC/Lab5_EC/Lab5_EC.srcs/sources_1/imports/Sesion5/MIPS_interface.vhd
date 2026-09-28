library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MIPS_interface is
 PORT(
	      clk100Mhz : IN STD_LOGIC; -- OSCILADOR
	      clock_en: in std_logic; -- SW7
	      selREG: IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- SW3... SW0
	      anodos: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
         HEXleds: OUT STD_LOGIC_VECTOR(7 DOWNTO 0); -- siete segmentos
	      pc_LSB: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	      );		
end MIPS_interface;

architecture Behavioral of MIPS_interface is

 signal reloj1: std_logic;  
 signal reloj2: std_logic; 
 signal Regs: STD_LOGIC_VECTOR(15 DOWNTO 0);
 signal refresco: STD_LOGIC_VECTOR(1 DOWNTO 0);	  
 signal selregint: STD_LOGIC_VECTOR(4 DOWNTO 0);

 COMPONENT cont_div_frec_refresh
     generic (n: natural);
	PORT(
		clk100Mhz : IN std_logic;          
		refresh : OUT std_logic_vector(1 downto 0);
		clk_hercios : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT cont_pausa_gen
	  generic (n: natural); -- valor por defecto
	PORT(
		clock : IN std_logic;
		pausa : IN std_logic;          
		clk_sal : OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT Seldigit_CodLEDS
	PORT(
		regs : IN std_logic_vector(15 downto 0);
		refresh : IN std_logic_vector(1 downto 0);          
		anodos : OUT std_logic_vector(3 downto 0);
		catodos : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	-- MIPs_nucleo1
	COMPONENT MIPs_nucleo1
	PORT(
		clock : IN std_logic;
		selreg : IN std_logic_vector(4 downto 0);          
		pcout : OUT std_logic_vector(7 downto 0);
		salreg : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;
	
begin
selregint <= '0'& selreg;
Inst_Seldigit_CodLEDS: Seldigit_CodLEDS PORT MAP(
		regs => regs,
		refresh => refresco,
		anodos => anodos,
		catodos => HEXleds
	);

Inst_div_frec: cont_div_frec_refresh 
    generic map(n => 3) -- 3 para simulacion; 19 para sintesis
	 PORT MAP(
		clk100Mhz => clk100Mhz,
		refresh => refresco,
		clk_hercios => reloj1
	);

Inst_MIPs_nucleo1: MIPs_nucleo1 PORT MAP(
		clock => reloj2,
		pcout => pc_LSB,
		selreg => selregint,
		salreg => regs
	);

Inst_cont_pausa_gen: cont_pausa_gen 
    GENERIC MAP (n => 2) -- 2 para simulacion ; 7 para sintesis
    PORT MAP(
		       clock => reloj1,
		       pausa =>  clock_en,
		       clk_sal => reloj2
	         );	
end Behavioral;

