library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity dec2a4 is
    Port ( d : in  STD_LOGIC_VECTOR (1 downto 0);
             y : out  STD_LOGIC_VECTOR (0 to 3));
end dec2a4;

architecture Behavioral of dec2a4 is
begin
 with d select
 y <= "0111" when "00",
      "1011" when "01",
      "1101" when "10",
      "1110" when "11",
      "1111" when others;
end Behavioral;

