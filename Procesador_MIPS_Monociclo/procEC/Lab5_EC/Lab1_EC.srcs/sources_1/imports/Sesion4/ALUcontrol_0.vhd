library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
---------------------------------------------------------------
-- Unidad de Control para repertorio de instrucciones siguiente:
-- ADD, SUB, SLT, ADDI, AND, OR, XOR, ORI, LW, SW, JR, BEQ, BNE, J, jAL
entity ALUcontrol_0 is
    Port ( ALUop : in  STD_LOGIC_VECTOR (1 downto 0);
           Func :  in STD_LOGIC_VECTOR (5 downto 0);
           cont_ALU : out  STD_LOGIC_VECTOR (2 downto 0)
           );
end ALUcontrol_0;

architecture Behavioral of ALUcontrol_0 is
signal ent: STD_LOGIC_VECTOR (7 downto 0);
begin
  ent <= ALUop & Func;
  cont_ALU <= "010" when ent(7 downto 6) = "00" else
    	      "110" when ent(7 downto 6) = "01" else
     	      "010" when ent = "10100000" else  -- add
     	      "110" when ent = "10100010" else  -- sub
     	      "111" when ent = "10101010" else  -- slt
            "000" when ent = "10100100" else  -- and
     	      "001" when ent = "10100101" else  -- or
     	      "011" when ent = "10100110" else  -- xor
      	   "010" when ent = "10001000" else  -- jr
     	      "100" when ent = "10100111" else -- nor
     	      "001" when ent(7 downto 6) = "11" else
            "000";
end Behavioral;

