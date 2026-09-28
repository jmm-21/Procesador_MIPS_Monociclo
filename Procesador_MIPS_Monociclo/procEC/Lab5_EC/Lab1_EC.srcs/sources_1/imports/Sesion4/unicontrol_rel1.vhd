library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unicontrol_rel1 is
    Port ( d : in  STD_LOGIC_VECTOR (5 downto 0);
	        f : in std_logic;
           vec_control : out  STD_LOGIC_VECTOR (12 downto 0));
end unicontrol_rel1;

architecture Behavioral of unicontrol_rel1 is   
signal TipoR:  STD_LOGIC_VECTOR (12 downto 0);
begin	 
  tipoR <=
     "1101001000001" when f = '0' else
     "0000001000010";
 with d select
  vec_control <=  tipoR     when "000000", -- tipo R 
      		"1001010000001" when "001000", --  addi
				"1001011100001" when "001101", --  ori
				"1000010000001" when "100011", --  lw
				"0000010010001" when "101011", --  sw  
				"0000000101001" when "000100", --  beq  
				"0000000101101" when "000101", --  bne 
				"0000000000000" when "000010", --  j 
				"1010100000000" when "000011", --  jal 
      		"0000000000000" when others;
end Behavioral;
