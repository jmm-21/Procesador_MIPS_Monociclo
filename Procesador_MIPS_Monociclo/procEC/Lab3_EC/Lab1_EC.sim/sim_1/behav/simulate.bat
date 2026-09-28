@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.1\\bin
call %xv_path%/xsim TB_Mem_Ia_256x8_behav -key {Behavioral:sim_1:Functional:TB_Mem_Ia_256x8} -tclbatch TB_Mem_Ia_256x8.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
