library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_registro_PC is
end TB_registro_PC;

architecture Behavioral of TB_registro_PC is

COMPONENT registro_PC
	port (
		CLK : in std_logic;
		DATA : in std_logic_vector(15 downto 0);
		Q : out std_logic_vector(15 downto 0)
	);
END COMPONENT;

--inputs 
signal CLK : std_logic := '0';
signal DATA : std_logic_vector(15 downto 0) := (others => '0');

--output
signal Q: std_logic_vector(15 downto 0);

--constantes
constant CLK_PERIOD: time:= 10 ns;

begin

uut: registro_PC PORT MAP(
    CLK => CLK,
    DATA => DATA,
    Q => Q
    );

   -- Clock process definitions
   CLK_process: process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

    -- Stimilus process definitions
    stim_proc: process
    begin
        wait for CLK_period*2;
        DATA <= (others => '1');
        wait for CLK_period*2;
        DATA <= X"BBCF";
        wait for CLK_period*2;
        DATA <= X"AACC";
        wait for CLK_period*2;
        DATA <= X"2468";       
        
        wait for CLK_period*2;
        DATA <= X"AC13";
        wait for CLK_period*2;
        DATA <= X"FDBB"; 
             
        wait;
    end process;
end Behavioral;
