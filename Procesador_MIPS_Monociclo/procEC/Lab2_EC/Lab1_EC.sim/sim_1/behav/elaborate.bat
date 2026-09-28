@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.1\\bin
call %xv_path%/xelab  -wto c63be9982a7a4831ac374719b729e0b5 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot TB_registro_PC_behav xil_defaultlib.TB_registro_PC -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
