############################################################################
# Programmable Logic placement constraints                                 #
############################################################################

##### USB interface (bank 13) #####
# USB_VBUS_PWRFAULT_i
set_property PACKAGE_PIN AA19 [get_ports UsbVbusPwrFaultxSI]
set_property IOSTANDARD LVCMOS25 [get_ports UsbVbusPwrFaultxSI]

##### PLL interface (banks 35 and 34) #####
# PLL_2V5_CLKuWire_o
set_property PACKAGE_PIN G8 [get_ports Pll2V5ClkuWirexCO]
set_property IOSTANDARD LVCMOS25 [get_ports Pll2V5ClkuWirexCO]
# PLL_2V5_DATAuWire_o
set_property PACKAGE_PIN G7 [get_ports Pll2V5DatauWirexSO]
set_property IOSTANDARD LVCMOS25 [get_ports Pll2V5DatauWirexSO]
# PLL_2V5_LEuWire_o
set_property PACKAGE_PIN G6 [get_ports Pll2V5LEuWirexSO]
set_property IOSTANDARD LVCMOS25 [get_ports Pll2V5LEuWirexSO]
# PLL_2V5_GOE_o
set_property PACKAGE_PIN F6 [get_ports Pll2V5GOExSO]
set_property IOSTANDARD LVCMOS25 [get_ports Pll2V5GOExSO]
# PLL_2V5_LD_i
set_property PACKAGE_PIN H6 [get_ports Pll2V5LDxSI]
set_property IOSTANDARD LVCMOS25 [get_ports Pll2V5LDxSI]
# PLL_2V5_SYNC_n_o
set_property PACKAGE_PIN H5 [get_ports Pll2V5SyncxSO]
set_property IOSTANDARD LVCMOS25 [get_ports Pll2V5SyncxSO]
# PLL_2V5_CLKIN0_LOS_i (bank 34)
set_property PACKAGE_PIN J3 [get_ports Pll2V5ClkIn0LOSxSI]
set_property IOSTANDARD LVCMOS25 [get_ports Pll2V5ClkIn0LOSxSI]
# PLL_2V5_CLKIN1_LOS_i (bank 34)
set_property PACKAGE_PIN K2 [get_ports Pll2V5ClkIn1LOSxSI]
set_property IOSTANDARD LVCMOS25 [get_ports Pll2V5ClkIn1LOSxSI]

##### GTP interfaces (bank 112) #####
#set_property PACKAGE_PIN U9 [get_ports GTPRefClk0PxCI]
#set_property PACKAGE_PIN V9 [get_ports GTPRefClk0NxCI]
#set_property PACKAGE_PIN "U5" [get_ports "GTPRefClk1PxCI"]
#set_property PACKAGE_PIN "V5" [get_ports "GTPRefClk1NxCI"]
#set_property PACKAGE_PIN Y8 [get_ports GTPFromNorthNxSI]
#set_property PACKAGE_PIN W8 [get_ports GTPFromNorthPxSI]
#set_property PACKAGE_PIN Y4 [get_ports GTPToNorthNxSO]
#set_property PACKAGE_PIN W4 [get_ports GTPToNorthPxSO]
#set_property PACKAGE_PIN AB7 [get_ports GTPFromSouthNxSI]
#set_property PACKAGE_PIN AA7 [get_ports GTPFromSouthPxSI]
#set_property PACKAGE_PIN AB3 [get_ports GTPToSouthNxSO]
#set_property PACKAGE_PIN AA3 [get_ports GTPToSouthPxSO]
#set_property PACKAGE_PIN AB9 [get_ports GTPFromEastNxSI]
#set_property PACKAGE_PIN AA9 [get_ports GTPFromEastPxSI]
#set_property PACKAGE_PIN AB5 [get_ports GTPToEastNxSO]
#set_property PACKAGE_PIN AA5 [get_ports GTPToEastPxSO]
#set_property PACKAGE_PIN Y6 [get_ports GTPFromWestNxSI]
#set_property PACKAGE_PIN W6 [get_ports GTPFromWestPxSI]
#set_property PACKAGE_PIN Y2 [get_ports GTPToWestNxSO]
#set_property PACKAGE_PIN W2 [get_ports GTPToWestPxSO]

##### LVDS links towards edge connectors #####
# North (bank 35)
#set_property PACKAGE_PIN "E8"   [get_ports "LVDS2V5North7PxSIO"]
#set_property PACKAGE_PIN "D8"   [get_ports "LVDS2V5North7NxSIO"]
#set_property PACKAGE_PIN "D7"   [get_ports "LVDS2V5North6PxSIO"]
#set_property PACKAGE_PIN "D6"   [get_ports "LVDS2V5North6NxSIO"]
#set_property PACKAGE_PIN "C8"   [get_ports "LVDS2V5North5PxSIO"]
#set_property PACKAGE_PIN "B8"   [get_ports "LVDS2V5North5NxSIO"]
#set_property PACKAGE_PIN "B7"   [get_ports "LVDS2V5North4PxSIO"]
#set_property PACKAGE_PIN "B6"   [get_ports "LVDS2V5North4NxSIO"]
#set_property PACKAGE_PIN "A7"   [get_ports "LVDS2V5North3PxSIO"]
#set_property PACKAGE_PIN "A6"   [get_ports "LVDS2V5North3NxSIO"]
#set_property PACKAGE_PIN "A5"   [get_ports "LVDS2V5North2PxSIO"]
#set_property PACKAGE_PIN "A4"   [get_ports "LVDS2V5North2NxSIO"]
#set_property PACKAGE_PIN "B2"   [get_ports "LVDS2V5North1PxSIO"]
#set_property PACKAGE_PIN "B1"   [get_ports "LVDS2V5North1NxSIO"]
#set_property PACKAGE_PIN "A2"   [get_ports "LVDS2V5North0PxSIO"]
#set_property PACKAGE_PIN "A1"   [get_ports "LVDS2V5North0NxSIO"]
# South (bank 13)
#set_property PACKAGE_PIN "V15"  [get_ports "LVDS2V5South7PxSIO"]
#set_property PACKAGE_PIN "W15"  [get_ports "LVDS2V5South7NxSIO"]
#set_property PACKAGE_PIN "AB13" [get_ports "LVDS2V5South6PxSIO"]
#set_property PACKAGE_PIN "AB14" [get_ports "LVDS2V5South6NxSIO"]
#set_property PACKAGE_PIN "V13"  [get_ports "LVDS2V5South5PxSIO"]
#set_property PACKAGE_PIN "V14"  [get_ports "LVDS2V5South5NxSIO"]
#set_property PACKAGE_PIN "Y12"  [get_ports "LVDS2V5South4PxSIO"]
#set_property PACKAGE_PIN "Y13"  [get_ports "LVDS2V5South4NxSIO"]
#set_property PACKAGE_PIN "AA12" [get_ports "LVDS2V5South3PxSIO"]
#set_property PACKAGE_PIN "AB12" [get_ports "LVDS2V5South3NxSIO"]
#set_property PACKAGE_PIN "W12"  [get_ports "LVDS2V5South2PxSIO"]
#set_property PACKAGE_PIN "W13"  [get_ports "LVDS2V5South2NxSIO"]
#set_property PACKAGE_PIN "AA11" [get_ports "LVDS2V5South1PxSIO"]
#set_property PACKAGE_PIN "AB11" [get_ports "LVDS2V5South1NxSIO"]
#set_property PACKAGE_PIN "V11"  [get_ports "LVDS2V5South0PxSIO"]
#set_property PACKAGE_PIN "W11"  [get_ports "LVDS2V5South0NxSIO"]
# East (bank 13)
#set_property PACKAGE_PIN "V16"  [get_ports "LVDS2V5East7PxSIO"]
#set_property PACKAGE_PIN "W16"  [get_ports "LVDS2V5East7NxSIO"]
#set_property PACKAGE_PIN "W17"  [get_ports "LVDS2V5East6PxSIO"]
#set_property PACKAGE_PIN "Y17"  [get_ports "LVDS2V5East6NxSIO"]
#set_property PACKAGE_PIN "U13"  [get_ports "LVDS2V5East5PxSIO"]
#set_property PACKAGE_PIN "U14"  [get_ports "LVDS2V5East5NxSIO"]
#set_property PACKAGE_PIN "V18"  [get_ports "LVDS2V5East4PxSIO"]
#set_property PACKAGE_PIN "W18"  [get_ports "LVDS2V5East4NxSIO"]
#set_property PACKAGE_PIN "U11"  [get_ports "LVDS2V5East3PxSIO"]
#set_property PACKAGE_PIN "U12"  [get_ports "LVDS2V5East3NxSIO"]
#set_property PACKAGE_PIN "U19"  [get_ports "LVDS2V5East2PxSIO"]
#set_property PACKAGE_PIN "V19"  [get_ports "LVDS2V5East2NxSIO"]
#set_property PACKAGE_PIN "R17"  [get_ports "LVDS2V5East1PxSIO"]
#set_property PACKAGE_PIN "T17"  [get_ports "LVDS2V5East1NxSIO"]
#set_property PACKAGE_PIN "U17"  [get_ports "LVDS2V5East0PxSIO"]
#set_property PACKAGE_PIN "U18"  [get_ports "LVDS2V5East0NxSIO"]
# West (bank 35)
#set_property PACKAGE_PIN "H4"   [get_ports "LVDS2V5West7PxSIO"]
#set_property PACKAGE_PIN "H3"   [get_ports "LVDS2V5West7NxSIO"]
#set_property PACKAGE_PIN "H1"   [get_ports "LVDS2V5West6PxSIO"]
#set_property PACKAGE_PIN "G1"   [get_ports "LVDS2V5West6NxSIO"]
#set_property PACKAGE_PIN "G3"   [get_ports "LVDS2V5West5PxSIO"]
#set_property PACKAGE_PIN "G2"   [get_ports "LVDS2V5West5NxSIO"]
#set_property PACKAGE_PIN "F2"   [get_ports "LVDS2V5West4PxSIO"]
#set_property PACKAGE_PIN "F1"   [get_ports "LVDS2V5West4NxSIO"]
#set_property PACKAGE_PIN "G4"   [get_ports "LVDS2V5West3PxSIO"]
#set_property PACKAGE_PIN "F4"   [get_ports "LVDS2V5West3NxSIO"]
#set_property PACKAGE_PIN "E2"   [get_ports "LVDS2V5West2PxSIO"]
#set_property PACKAGE_PIN "D2"   [get_ports "LVDS2V5West2NxSIO"]
#set_property PACKAGE_PIN "E4"   [get_ports "LVDS2V5West1PxSIO"]
#set_property PACKAGE_PIN "E3"   [get_ports "LVDS2V5West1NxSIO"]
#set_property PACKAGE_PIN "D1"   [get_ports "LVDS2V5West0PxSIO"]
#set_property PACKAGE_PIN "C1"   [get_ports "LVDS2V5West0NxSIO"]

##### HDMI (banks 34) #####
# CEC
set_property PACKAGE_PIN K8 [get_ports HdmiTXCecxSIO]
set_property IOSTANDARD LVCMOS25 [get_ports HdmiTXCecxSIO]
# HPD
set_property PACKAGE_PIN L7 [get_ports HdmiTXHpdxSI]
set_property IOSTANDARD LVCMOS25 [get_ports HdmiTXHpdxSI]
# SDA
#set_property PACKAGE_PIN "J5"    [get_ports "HdmiTXSdaxSIO"]
#set_property IOSTANDARD LVCMOS25 [get_ports "HdmiTXSdaxSIO"]
# SCL
#set_property PACKAGE_PIN "K5"    [get_ports "HdmiTXSclxSO"]
#set_property IOSTANDARD LVCMOS25 [get_ports "HdmiTXSclxSO"]
# BLUE
set_property PACKAGE_PIN N8 [get_ports {HdmiTXPxDO[2]}]
set_property PACKAGE_PIN P8 [get_ports {HdmiTXNxDO[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {HdmiTXPxDO[2]}]
set_property IOSTANDARD LVDS_25 [get_ports {HdmiTXNxDO[2]}]
# GREEN
set_property PACKAGE_PIN M8 [get_ports {HdmiTXPxDO[1]}]
set_property PACKAGE_PIN M7 [get_ports {HdmiTXNxDO[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {HdmiTXPxDO[1]}]
set_property IOSTANDARD LVDS_25 [get_ports {HdmiTXNxDO[1]}]
# RED
set_property PACKAGE_PIN L6 [get_ports {HdmiTXPxDO[0]}]
set_property PACKAGE_PIN M6 [get_ports {HdmiTXNxDO[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {HdmiTXPxDO[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {HdmiTXNxDO[0]}]
# CLK
set_property PACKAGE_PIN J7 [get_ports HdmiTXClkPxSO]
set_property PACKAGE_PIN J6 [get_ports HdmiTXClkNxSO]
set_property IOSTANDARD LVDS_25 [get_ports HdmiTXClkPxSO]
set_property IOSTANDARD LVDS_25 [get_ports HdmiTXClkNxSO]

##### LVDS links towards top-bottom connectors #####
# Top (bank 34)
#set_property PACKAGE_PIN "J8"   [get_ports "LVDS2V5Top7PxSIO"]
#set_property PACKAGE_PIN "K8"   [get_ports "LVDS2V5Top7NxSIO"]
#set_property PACKAGE_PIN "K7"   [get_ports "LVDS2V5Top6PxSIO"]
#set_property PACKAGE_PIN "L7"   [get_ports "LVDS2V5Top6NxSIO"]
#set_property PACKAGE_PIN "N8"   [get_ports "LVDS2V5Top5PxSIO"]
#set_property PACKAGE_PIN "P8"   [get_ports "LVDS2V5Top5NxSIO"]
#set_property PACKAGE_PIN "M8"   [get_ports "LVDS2V5Top4PxSIO"]
#set_property PACKAGE_PIN "M7"   [get_ports "LVDS2V5Top4NxSIO"]
#set_property PACKAGE_PIN "L6"   [get_ports "LVDS2V5Top3PxSIO"]
#set_property PACKAGE_PIN "M6"   [get_ports "LVDS2V5Top3NxSIO"]
#set_property PACKAGE_PIN "J7"   [get_ports "LVDS2V5Top2PxSIO"]
#set_property PACKAGE_PIN "J6"   [get_ports "LVDS2V5Top2NxSIO"]
#set_property PACKAGE_PIN "J5"   [get_ports "LVDS2V5Top1PxSIO"]
#set_property PACKAGE_PIN "K5"   [get_ports "LVDS2V5Top1NxSIO"]
#set_property PACKAGE_PIN "J2"   [get_ports "LVDS2V5Top0PxSIO"]
#set_property PACKAGE_PIN "J1"   [get_ports "LVDS2V5Top0NxSIO"]
# Bottom (bank 34)
#set_property PACKAGE_PIN "N6"   [get_ports "LVDS2V5Bottom7PxSIO"]
#set_property PACKAGE_PIN "N5"   [get_ports "LVDS2V5Bottom7NxSIO"]
#set_property PACKAGE_PIN "P6"   [get_ports "LVDS2V5Bottom6PxSIO"]
#set_property PACKAGE_PIN "P5"   [get_ports "LVDS2V5Bottom6NxSIO"]
#set_property PACKAGE_PIN "R5"   [get_ports "LVDS2V5Bottom5PxSIO"]
#set_property PACKAGE_PIN "R4"   [get_ports "LVDS2V5Bottom5NxSIO"]
#set_property PACKAGE_PIN "R3"   [get_ports "LVDS2V5Bottom4PxSIO"]
#set_property PACKAGE_PIN "R2"   [get_ports "LVDS2V5Bottom4NxSIO"]
#set_property PACKAGE_PIN "P3"   [get_ports "LVDS2V5Bottom3PxSIO"]
#set_property PACKAGE_PIN "P2"   [get_ports "LVDS2V5Bottom3NxSIO"]
#set_property PACKAGE_PIN "N1"   [get_ports "LVDS2V5Bottom2PxSIO"]
#set_property PACKAGE_PIN "P1"   [get_ports "LVDS2V5Bottom2NxSIO"]
#set_property PACKAGE_PIN "N4"   [get_ports "LVDS2V5Bottom1PxSIO"]
#set_property PACKAGE_PIN "N3"   [get_ports "LVDS2V5Bottom1NxSIO"]
#set_property PACKAGE_PIN "M2"   [get_ports "LVDS2V5Bottom0PxSIO"]
#set_property PACKAGE_PIN "M1"   [get_ports "LVDS2V5Bottom0NxSIO"]

##### Switches (banks 34) #####
set_property PACKAGE_PIN L4 [get_ports {SwitchesxDI[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {SwitchesxDI[0]}]
set_property PACKAGE_PIN T1 [get_ports {SwitchesxDI[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {SwitchesxDI[1]}]

##### Joystick (banks 34) #####
set_property PACKAGE_PIN K4 [get_ports {JoystickxDI[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {JoystickxDI[0]}]
set_property PACKAGE_PIN P7 [get_ports {JoystickxDI[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {JoystickxDI[1]}]
set_property PACKAGE_PIN R7 [get_ports {JoystickxDI[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {JoystickxDI[2]}]
set_property PACKAGE_PIN J2 [get_ports {JoystickxDI[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {JoystickxDI[3]}]
set_property PACKAGE_PIN J1 [get_ports {JoystickxDI[4]}]
set_property IOSTANDARD LVCMOS25 [get_ports {JoystickxDI[4]}]

##### I2C IO Ext. (banks 34) #####
# SDA
set_property PACKAGE_PIN J5 [get_ports IoExtIICSdaxDIO]
set_property IOSTANDARD LVCMOS25 [get_ports IoExtIICSdaxDIO]
# SCL
set_property PACKAGE_PIN K5 [get_ports IoExtIICSclxDIO]
set_property IOSTANDARD LVCMOS25 [get_ports IoExtIICSclxDIO]

##### RGB LEDs (banks 34 and 13) #####
# LED1_2V5_R_o (bank 34)
set_property PACKAGE_PIN L2 [get_ports Led12V5RxSO]
set_property IOSTANDARD LVCMOS25 [get_ports Led12V5RxSO]
# LED1_2V5_G_o (bank 34)
set_property PACKAGE_PIN L1 [get_ports Led12V5GxSO]
set_property IOSTANDARD LVCMOS25 [get_ports Led12V5GxSO]
# LED1_2V5_B_o (bank 34)
set_property PACKAGE_PIN R8 [get_ports Led12V5BxSO]
set_property IOSTANDARD LVCMOS25 [get_ports Led12V5BxSO]
# LED2_2V5_R_o (bank 13)
set_property PACKAGE_PIN T16 [get_ports Led22V5RxSO]
set_property IOSTANDARD LVCMOS25 [get_ports Led22V5RxSO]
# LED2_2V5_G_o (bank 13)
set_property PACKAGE_PIN U16 [get_ports Led22V5GxSO]
set_property IOSTANDARD LVCMOS25 [get_ports Led22V5GxSO]
# LED2_2V5_B_o (bank 13)
set_property PACKAGE_PIN AA20 [get_ports Led22V5BxSO]
set_property IOSTANDARD LVCMOS25 [get_ports Led22V5BxSO]

##### Self reset (bank 34) #####
set_property PACKAGE_PIN H8 [get_ports SelfRstxRNO]
set_property IOSTANDARD LVCMOS25 [get_ports SelfRstxRNO]

##### Clock dedicated pins (Multi-region) #####
# Bank 35
#set_property PACKAGE_PIN "D5"   [get_ports "PLLClk2V5LocalPxCI"]
#set_property PACKAGE_PIN "C4"   [get_ports "PLLClk2V5LocalNxCI"]
#set_property PACKAGE_PIN "B4"   [get_ports "PLLClk2V5NorthPxCI"]
#set_property PACKAGE_PIN "B3"   [get_ports "PLLClk2V5NorthNxCI"]
# Bank 34
#set_property PACKAGE_PIN "T2"   [get_ports "PLLClk2V5TopxCI"]
#set_property PACKAGE_PIN "L5"   [get_ports "PLLClk2V5BottomxCI"]
# Bank 13
#set_property PACKAGE_PIN "Y14"  [get_ports "PLLClk2V5SouthPxCI"]
#set_property PACKAGE_PIN "Y15"  [get_ports "PLLClk2V5SouthNxCI"]
#set_property PACKAGE_PIN "Y18"  [get_ports "Clk2V5RecoveryPxCO"]
#set_property PACKAGE_PIN "Y19"  [get_ports "Clk2V5RecoveryNxCO"]

##### Clock dedicated pins (Single-region) #####
# Bank 35
#set_property PACKAGE_PIN "C6"   [get_ports "Clk2V5NorthPxCI"]
#set_property PACKAGE_PIN "C5"   [get_ports "Clk2V5NorthNxCI"]
#set_property PACKAGE_PIN "D3"   [get_ports "Clk2V5WestPxCI"]
#set_property PACKAGE_PIN "C3"   [get_ports "Clk2V5WestNxCI"]
# Bank 34
#set_property PACKAGE_PIN "K4"   [get_ports "Clk2V5TopPxCI"]
#set_property PACKAGE_PIN "K3"   [get_ports "Clk2V5TopNxCI"]
#set_property PACKAGE_PIN "U2"   [get_ports "Clk2V5BottomPxCI"]
#set_property PACKAGE_PIN "U1"   [get_ports "Clk2V5BottomNxCI"]
# Bank 13
#set_property PACKAGE_PIN "AA14" [get_ports "Clk2V5SouthPxCI"]
#set_property PACKAGE_PIN "AA15" [get_ports "Clk2V5SouthNxCI"]
#set_property PACKAGE_PIN "AA16" [get_ports "Clk2V5EastPxCI"]
#set_property PACKAGE_PIN "AA17" [get_ports "Clk2V5EastNxCI"]

##### Clock outputs #####
## Bank 35
#set_property PACKAGE_PIN "F7"   [get_ports "Clk2V5NorthPxCO"]
#set_property PACKAGE_PIN "E7"   [get_ports "Clk2V5NorthNxCO"]
#set_property PACKAGE_PIN "F5"   [get_ports "Clk2V5WestPxCO"]
#set_property PACKAGE_PIN "E5"   [get_ports "Clk2V5WestNxCO"]
# Bank 34
#set_property PACKAGE_PIN "P7"   [get_ports "Clk2V5TopPxCO"]
#set_property PACKAGE_PIN "R7"   [get_ports "Clk2V5TopNxCO"]
#set_property PACKAGE_PIN "M4"   [get_ports "Clk2V5BottomPxCO"]
#set_property PACKAGE_PIN "M3"   [get_ports "Clk2V5BottomNxCO"]
# Bank 13
#set_property PACKAGE_PIN "AB16" [get_ports "Clk2V5SouthPxCO"]
#set_property PACKAGE_PIN "AB17" [get_ports "Clk2V5SouthNxCO"]
#set_property PACKAGE_PIN "AB21" [get_ports "Clk2V5EastPxCO"]
#set_property PACKAGE_PIN "AB22" [get_ports "Clk2V5EastNxCO"]

############################################################################
# Other constraints                                                        #
############################################################################

##### Operating conditions (for XPE report) #####
# Extended grade (as for -2 speed grade) and maximum consumption estimation
set_operating_conditions -grade extended -process maximum
# 4'' by 4'' PCB, no heatsink, no air flow
set_operating_conditions -airflow 0 -heatsink none -board small

