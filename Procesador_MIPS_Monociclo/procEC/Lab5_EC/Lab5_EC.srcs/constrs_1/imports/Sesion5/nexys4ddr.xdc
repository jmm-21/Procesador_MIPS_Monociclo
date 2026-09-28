#nexys4ddr.xdc

#Reloj
set_property -dict { PACKAGE_PIN E3   IOSTANDARD LVCMOS33 } [get_ports { clk100Mhz }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk100Mhz}]; #CLOCK100MHZ

#Conmutador para habilitar reloj
set_property -dict { PACKAGE_PIN V10  IOSTANDARD LVCMOS33 } [get_ports { clock_en }];   #SW15

#Conmutadores para seleccion de entradas
set_property -dict { PACKAGE_PIN J15  IOSTANDARD LVCMOS33 } [get_ports { selREG[0] }];  #SW0
set_property -dict { PACKAGE_PIN L16  IOSTANDARD LVCMOS33 } [get_ports { selREG[1] }];  #SW1
set_property -dict { PACKAGE_PIN M13  IOSTANDARD LVCMOS33 } [get_ports { selREG[2] }];  #SW2
set_property -dict { PACKAGE_PIN R15  IOSTANDARD LVCMOS33 } [get_ports { selREG[3] }];  #SW3

#Anodos para posicion digito
set_property -dict { PACKAGE_PIN J17  IOSTANDARD LVCMOS33 } [get_ports { anodos[0] }];  #AN0
set_property -dict { PACKAGE_PIN J18  IOSTANDARD LVCMOS33 } [get_ports { anodos[1] }];  #AN1
set_property -dict { PACKAGE_PIN T9   IOSTANDARD LVCMOS33 } [get_ports { anodos[2] }];  #AN2
set_property -dict { PACKAGE_PIN J14  IOSTANDARD LVCMOS33 } [get_ports { anodos[3] }];  #AN3

#Catodos para 7 segmentos
set_property -dict { PACKAGE_PIN H15  IOSTANDARD LVCMOS33 } [get_ports { HEXleds[0] }]; #dp
set_property -dict { PACKAGE_PIN T10  IOSTANDARD LVCMOS33 } [get_ports { HEXleds[1] }]; #ca
set_property -dict { PACKAGE_PIN R10  IOSTANDARD LVCMOS33 } [get_ports { HEXleds[2] }]; #cb
set_property -dict { PACKAGE_PIN K16  IOSTANDARD LVCMOS33 } [get_ports { HEXleds[3] }]; #cc
set_property -dict { PACKAGE_PIN K13  IOSTANDARD LVCMOS33 } [get_ports { HEXleds[4] }]; #cd
set_property -dict { PACKAGE_PIN P15  IOSTANDARD LVCMOS33 } [get_ports { HEXleds[5] }]; #ce
set_property -dict { PACKAGE_PIN T11  IOSTANDARD LVCMOS33 } [get_ports { HEXleds[6] }]; #cf
set_property -dict { PACKAGE_PIN L18  IOSTANDARD LVCMOS33 } [get_ports { HEXleds[7] }]; #cg

# LEDs
set_property -dict { PACKAGE_PIN H17  IOSTANDARD LVCMOS33 } [get_ports { pc_LSB[0] }];  #led[0]
set_property -dict { PACKAGE_PIN K15  IOSTANDARD LVCMOS33 } [get_ports { pc_LSB[1] }];  #led[1]
set_property -dict { PACKAGE_PIN J13  IOSTANDARD LVCMOS33 } [get_ports { pc_LSB[2] }];  #led[2]
set_property -dict { PACKAGE_PIN N14  IOSTANDARD LVCMOS33 } [get_ports { pc_LSB[3] }];  #led[3]
set_property -dict { PACKAGE_PIN R18  IOSTANDARD LVCMOS33 } [get_ports { pc_LSB[4] }];  #led[4]
set_property -dict { PACKAGE_PIN V17  IOSTANDARD LVCMOS33 } [get_ports { pc_LSB[5] }];  #led[5]
set_property -dict { PACKAGE_PIN U17  IOSTANDARD LVCMOS33 } [get_ports { pc_LSB[6] }];  #led[6]
set_property -dict { PACKAGE_PIN U16  IOSTANDARD LVCMOS33 } [get_ports { pc_LSB[7] }];  #led[7]
