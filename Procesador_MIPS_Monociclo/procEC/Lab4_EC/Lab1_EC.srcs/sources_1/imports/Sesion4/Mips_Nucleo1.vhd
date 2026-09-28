library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL; 

ENTITY MIPS_nucleo1 IS
	 PORT(
		 clock : IN STD_LOGIC;
		 pcout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 selreg : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 salreg : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	     );
END entity;

-- La descripción de la arquitectura está inacabada

ARCHITECTURE estructural OF MIPS_nucleo1 IS	

-- asocia la constante ra al registro 31 (return address)
constant ra: std_logic_vector(4 downto 0):="11111";
-- 
signal	nextpc: STD_LOGIC_VECTOR(15 DOWNTO 0):= X"0000";	
--------------------------------------------------------
-- pc4 representa a pc +4
signal	salpc, pc4: STD_LOGIC_VECTOR(15 DOWNTO 0);

-- declaración de la instrucción
signal instr: STD_LOGIC_VECTOR(31 DOWNTO 0); 

signal F: STD_LOGIC; 	
signal zero, nozero, condicion, sel2: STD_LOGIC; 	
signal dirWreg: STD_LOGIC_VECTOR(4 DOWNTO 0);					   
signal shl_dir_inm, dir_rel, sec_branch: STD_LOGIC_VECTOR(15 DOWNTO 0);

-- entrada de datos para escritura en registro
signal datoareg: STD_LOGIC_VECTOR(15 DOWNTO 0); 
-- señales de control reprentadas por un vector de 13 bits
signal vector_control: STD_LOGIC_VECTOR(12 DOWNTO 0); 
-- señal de salida de la memoria de datos (16 bits)
signal salmemdat: STD_LOGIC_VECTOR(15 DOWNTO 0); 


-- RELLENAR------------------------------------------------
-- declarar el resto de señales que sean necesarias
-- 1) definir la señal correspondiente al contenido de rs leido del banco de registros, de nombre "RSData" (16 bits)
-- 2) definir la señal correspondiente al contenido de rt leido del banco de registros, de nombre "RTData" (16 bits) 
-- 3) definir la señal para la segunda entrada de la ALU, de nombre "RTData_inm" (16 bits)
-- 4) definir la señal de salida de la ALU, de nombre "ALURes" (16 bits)
-- 5) definir la señal salida del control de la ALU que define la operación aritmetico-logica a realizar, de nombre "ALUControl" (3 bits)
-- --------------------------------------------------------
signal RSData: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal RTData: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal RTData_inm: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal ALURes: STD_LOGIC_VECTOR (15 DOWNTO 0);
signal ALUControl: STD_LOGIC_VECTOR (2 DOWNTO 0);

-- declaraciones de ALIAS asociados a señales ya declaradas
alias MI_dir: std_logic_vector(6 downto 0) is salpc(6 downto 0);
alias MI_dir2: std_logic_vector(7 downto 0) is salpc(7 downto 0);
alias codop: std_logic_vector(5 downto 0) is instr(31 downto 26); 
alias rs: std_logic_vector(4 downto 0) is instr(25 downto 21); 	
alias rt: std_logic_vector(4 downto 0) is instr(20 downto 16); 
alias rd: std_logic_vector(4 downto 0) is instr(15 downto 11);
alias funcion: std_logic_vector(5 downto 0) is instr(5 downto 0); 
alias dir_inm: std_logic_vector(15 downto 0) is instr(15 downto 0); 
alias dirMDat: std_logic_vector(7 downto 0) is ALURes(7 downto 0); 


-- alias asociados a las señales de control

alias Regwrite: std_logic is vector_control(12);  
alias Regdst: std_logic_vector(1 downto 0) is vector_control(11 downto 10); 
alias MemtoReg: std_logic_vector(1 downto 0) is vector_control(9 downto 8); 
alias ALUSrc: std_logic is vector_control(7); 
alias ALU_Op: std_logic_vector(1 downto 0) is vector_control(6 downto 5);
-- RELLENAR------------------------------------------------
-- Declarar un ALIAS para la señal de control MemWrite (1 bit), denominada "MemWrite". Es necesario asociar el alias a parte del vector de señales de control (vector_control)
-- MemWrite corresponde al bit 4 de vector_control, es decir, vector_control(4)
-- alias MemWrite:.....etc
-- --------------------------------------------------------
alias MemWrite: std_logic is vector_control (4);

alias Branch: std_logic is vector_control(3);  
alias sel: std_logic is vector_control(2); 
alias PCSrc: std_logic_vector(1 downto 0) is vector_control(1 downto 0);  


-- DECLARACIÓN DE COMPONENTES
-- RELLENAR------------------------------------------------
-- 1) Declaración del componente ALU16bits (ver la declaración de la entidad en ALU16bits.vhd)
-- 2) Declaración del componente ALUcontrol_0 (ver la declaración de la entidad en ALUcontrol_0.vhd)
-- 3) Declaración del componente ram_datos (ver la declaración de la entidad en ram_datos.vhd)
-- --------------------------------------------------------
    COMPONENT ALU16bits
	port (		
		A : in std_logic_vector (15 downto 0);
        B : in std_logic_vector (15 downto 0);
        con : in std_logic_vector (2 downto 0);
        Z : out std_logic;
        res : out std_logic_vector (15 downto 0)
	);
	end COMPONENT;

    COMPONENT ALUcontrol_0
	port (
		ALUop: in  std_logic_vector (1 downto 0);
        Func :  in std_logic_vector (5 downto 0);
        cont_ALU : out  std_logic_vector (2 downto 0)
               
	);
	end COMPONENT;
	
	COMPONENT ram_datos
    port (        
        WE : in std_logic;
        CLK : in std_logic;
        ADDR : in std_logic_vector(7 downto 0);
        DATAin : in std_logic_vector(15 downto 0);
        DATAOUT : out std_logic_vector(15 downto 0)
    );
    end COMPONENT;

	COMPONENT BReg_3port
	port (
		clk : in std_logic;
        we: in std_logic;
        Dirw: in std_logic_vector(4 downto 0); 
        Data: in std_logic_vector(15 downto 0);    
        Dira: in std_logic_vector(4 downto 0);
        Dirb: in std_logic_vector(4 downto 0);
        Dirt: in std_logic_vector(4 downto 0);
        A: out std_logic_vector(15 downto 0);
        B: out std_logic_vector(15 downto 0); 
        T: out std_logic_vector(15 downto 0)
	);
	end COMPONENT;
	
	
    COMPONENT mux3a1_16bits
	port (
		D0 : in std_logic_vector(15 downto 0);
		D1 : in std_logic_vector(15 downto 0);
		D2 : in std_logic_vector(15 downto 0);
		Sel : in std_logic_vector(1 downto 0);
		F : out std_logic_vector(15 downto 0)
	);
	END COMPONENT;	

	COMPONENT Mem_Ia_256x8
	PORT(
		dir : IN std_logic_vector(7 downto 0);          
		dout : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT mux2A1_16bits
	PORT(
		D0 : IN std_logic_vector(15 downto 0);
		D1 : IN std_logic_vector(15 downto 0);
		S : IN std_logic;          
		F : OUT std_logic_vector(15 downto 0)
		);
	END COMPONENT;		

	COMPONENT mux3a1_5bits
	PORT(
		D0 : IN std_logic_vector(4 downto 0);
		D1 : IN std_logic_vector(4 downto 0);
		D2 : IN std_logic_vector(4 downto 0);
		Sel : IN std_logic_vector(1 downto 0);          
		F : OUT std_logic_vector(4 downto 0)
		);
	END COMPONENT;

	COMPONENT registro_PC 
	port (
		CLK : in std_logic;
		DATA : in std_logic_vector(15 downto 0);
		Q : out std_logic_vector(15 downto 0)
	);	
	END COMPONENT ;

	COMPONENT unicontrol_rel1
	PORT(
		d : IN std_logic_vector(5 downto 0);
		f : IN std_logic;          
		vec_control : OUT std_logic_vector(12 downto 0)
		);
	END COMPONENT;
	

 BEGIN 
 pinesFPGA1: pcout <= salpc(7 downto 0);
 sum1: pc4 <= salpc + 4;
 sum2: dir_rel <= shl_dir_inm + pc4; 
 desp: shl_dir_inm <= dir_inm(13 downto 0)& "00";
 pand: sel2 <= branch and condicion;	
 checktipoR: F <= '1' when funcion = "001000" else '0';	
 inv1: nozero <= not zero;	
 mux2a1_1bit: condicion <= zero when sel ='0' else nozero;	
 
		
 Mux_branchPC4: mux2A1_16bits
	PORT MAP(
		D0 => pc4,
		D1 => dir_rel,
		S => sel2,
		F => sec_branch 
	); 	 
	
  INS_mux3a1_5bits: mux3a1_5bits 
	PORT MAP(
		D0 => rt,
		D1 => ra,
		D2 => rd,
		Sel => Regdst,
		F => dirWreg
	); 	

  contaprog: registro_Pc 
	PORT MAP (
		   CLK => clock,
		   DATA => nextpc,
		   Q => salpc);  
				  

  mem_instruc: Mem_Ia_256x8 
	PORT MAP(
		dir => MI_dir2,
		dout => instr
	);
		  
  Inst_unicontrol_rel1: unicontrol_rel1 
	PORT MAP(
		d => codop,
		f => f,
		vec_control => vector_control
	);
	

  mux_saltos: mux3a1_16bits 
    PORT MAP(
        D0 => dir_inm, 
        D1 => sec_branch,
        D2 => ALURes,
        Sel => PCSrc,
        F => nextpc
    ); 
	
  muxMemdat: mux3a1_16bits 
    PORT MAP(
        D0 => salmemdat,
        D1 => pc4,
        D2 => ALURes,
        Sel => MemtoReg,
        F => datoareg
     ); 
	 
  Inst_BReg_3port: BReg_3port 
	PORT MAP(
	   clk => clock, 
	   we => regwrite, 
	   Dirw => dirWreg, 
	   Data => datoareg, 
	   Dira => rs, 
	   Dirb => rt, 
	   Dirt => selreg, 
	   A => RSData, 
	   B => RTData, 
	   T => salreg
	);

	
-- ------------------------------------------------------------------
-- INSTANCIAR Los componentes restantes del procesador a continuación
-- ------------------------------------------------------------------
-- RELLENAR------------------------------------------------
-- 1) Instanciar el componente mux2A1_16bits utilizado para decidir el segundo operando de la ALU (nombre de instancia "Mux_sourceB_ALU")
		-- El mapeo debe realizarse D0 => RTData, D1 => dir_inm, S => ALUsrc, F => RTData_inm
-- 2) Instanciar el componente ALU16bits (nombre de instancia "Inst_ALU16bits")
		-- El mapeo puerto-señal debe realizarse: A => RSData, B => RTData_inm, con => ALUControl, z => zero, res => ALURes
-- 3) Instanciar el componente ALUcontrol_0 (nombre de instancia "ALUcontrol_inst")
		-- El mapeo debe realizarse ALUop => ALU_Op, Func => funcion, cont_ALU => ALUControl
-- 4) Instanciar el componente ram_datos (nombre de instancia "Inst_ram_datos")
		-- El mapeo debe realizarse WE => MemWrite, CLK => clock, ADDR => dirMdat, DATAin => RTData, DATAOUT => salmemdat
-- --------------------------------------------------------

Mux_sourceB_ALU: mux2A1_16bits
    PORT MAP(
            D0 => RTData,
            D1 => dir_inm,
            S => ALUsrc,
            F => RTData_inm
    );

Inst_ALU16bits: ALU16bits
    PORT MAP(
            A => RSData,
            B => RTData_inm,
            con => ALUControl,
            z => zero,
            res => ALURes
    );

ALUcontrol_inst: ALUcontrol_0
    PORT MAP(
           ALUop => ALU_Op,
            Func => funcion,
             cont_ALU => ALUControl
    );

Inst_ram_datos: ram_datos
    PORT MAP(
           WE => MemWrite,
           CLK => clock,
           ADDR => dirMdat,
           DATAin => RTData,
           DATAOUT => salmemdat
    );


END estructural;
