----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.02.2024 11:18:14
-- Design Name: 
-- Module Name: ALU16bits - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity ALU16bits is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           con : in STD_LOGIC_VECTOR (2 downto 0);
           Z : out STD_LOGIC;
           res : out STD_LOGIC_VECTOR (15 downto 0));
end ALU16bits;

architecture Behavioral of ALU16bits is
    signal R: std_logic_vector (15 downto 0);
begin
    
    process (A, B, con)
    begin
        case con is
           when "000"=>
              R <= (A and B); 
           when "001" =>
              R <= (A or B);
           when "010" =>
               R <= (A + B);
           when "011" =>
               R <= (A xor B); 
           when "100" =>
               R <= (A nor B);
           when "110" =>
               R <= (A - B); 
           when "111" =>
               if (A < B)   then
                    R <= X"0001";
               else 
                    R <= X"0000";   
               end if;
           when others => null;
        end case;     
    end process; 
    res <= R;  
    Z <= '1' when R = X"0000" else '0';
end Behavioral;
    