library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity TB_Mem_Ia_256x8 is
--  Port ( );
end TB_Mem_Ia_256x8;

architecture Behavioral of TB_Mem_Ia_256x8 is
    
COMPONENT Mem_Ia_256x8 is
    PORT(
        dir: in std_logic_vector (7 downto 0);
        dout: out std_logic_vector (31 downto 0));
end COMPONENT;

    signal dir: std_logic_vector(7 downto 0):= (others=>'0');
    signal dout: std_logic_vector(31 downto 0); 
    constant retardo: time:= 15 ns;
    
begin
uut: Mem_Ia_256x8 PORT MAP(
     dir => dir,
     dout => dout
 );
 
-- Stimulus process
    stim_proc: process
        variable dir_palabra: std_logic_vector(5 downto 0); -- 63 instrucciones    
        begin
        -- hold reset state for 10 ns.
        wait for 10 ns;
        for i in 0 to 63 loop
         dir_palabra:= conv_std_logic_vector(i,6);
         dir <= dir_palabra & "00";
          wait for retardo;
        end loop;
        wait;    
    end process;  

end Behavioral;
