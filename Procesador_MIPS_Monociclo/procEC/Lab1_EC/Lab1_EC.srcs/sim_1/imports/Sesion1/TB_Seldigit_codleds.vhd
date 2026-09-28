LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_arith.ALL;
 
ENTITY TB_Seldigit_codleds IS
END TB_Seldigit_codleds;
 
ARCHITECTURE behavior OF TB_Seldigit_codleds IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Seldigit_CodLEDS
    PORT(
         regs : IN  std_logic_vector(15 downto 0);
         refresh : IN  std_logic_vector(1 downto 0);
         anodos : OUT  std_logic_vector(3 downto 0);
         catodos : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal regs : std_logic_vector(15 downto 0) := (others => '0');
   signal refresh : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal anodos : std_logic_vector(3 downto 0);
   signal catodos : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Seldigit_CodLEDS PORT MAP (
          regs => regs,
          refresh => refresh,
          anodos => anodos,
          catodos => catodos
        );
 
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state 
      wait for 40 ns;
		regs <= X"0189";
	    for i in 0 to 3 loop
		  refresh <= conv_std_logic_vector(i,2);
	      wait for 20 ns;
	    end loop;
        regs <= X"2346";
	    for i in 0 to 3 loop
		  refresh <= conv_std_logic_vector(i,2);
		  wait for 20 ns;
	    end loop;
		regs <= X"5CAB";
		for i in 0 to 3 loop
		  refresh <= conv_std_logic_vector(i,2);
		  wait for 20 ns;
	    end loop;
		regs <= X"7FED";
		for i in 0 to 3 loop
		  refresh <= conv_std_logic_vector(i,2);
		  wait for 20 ns;
		end loop;	
		  regs <= X"185A";
                  for i in 0 to 3 loop
                    refresh <= conv_std_logic_vector(i,2);
                    wait for 20 ns;     
	    end loop;		
      wait for 40 ns;
      wait;
   end process;

END;
