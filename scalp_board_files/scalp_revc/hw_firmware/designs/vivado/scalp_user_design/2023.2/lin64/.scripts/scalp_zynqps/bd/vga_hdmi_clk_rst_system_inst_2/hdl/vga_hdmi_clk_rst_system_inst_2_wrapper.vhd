--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2023.2 (lin64) Build 4029153 Fri Oct 13 20:13:54 MDT 2023
--Date        : Tue Mar 26 08:29:35 2024
--Host        : xps15-deb running 64-bit Debian GNU/Linux 12 (bookworm)
--Command     : generate_target vga_hdmi_clk_rst_system_inst_2_wrapper.bd
--Design      : vga_hdmi_clk_rst_system_inst_2_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity vga_hdmi_clk_rst_system_inst_2_wrapper is
  port (
    ClkHdmiRstxRNAO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkHdmiRstxRO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkHdmixCO : out STD_LOGIC;
    ClkVgaRstxRNAO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkVgaRstxRO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkVgaxCO : out STD_LOGIC;
    PsClockxCI : in STD_LOGIC;
    PsResetxRN : in STD_LOGIC;
    VgaHdmiClkPllLockedxSO : out STD_LOGIC
  );
end vga_hdmi_clk_rst_system_inst_2_wrapper;

architecture STRUCTURE of vga_hdmi_clk_rst_system_inst_2_wrapper is
  component vga_hdmi_clk_rst_system_inst_2 is
  port (
    ClkHdmiRstxRNAO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkHdmiRstxRO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkHdmixCO : out STD_LOGIC;
    ClkVgaRstxRNAO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkVgaRstxRO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkVgaxCO : out STD_LOGIC;
    VgaHdmiClkPllLockedxSO : out STD_LOGIC;
    PsResetxRN : in STD_LOGIC;
    PsClockxCI : in STD_LOGIC
  );
  end component vga_hdmi_clk_rst_system_inst_2;
begin
vga_hdmi_clk_rst_system_inst_2_i: component vga_hdmi_clk_rst_system_inst_2
     port map (
      ClkHdmiRstxRNAO(0) => ClkHdmiRstxRNAO(0),
      ClkHdmiRstxRO(0) => ClkHdmiRstxRO(0),
      ClkHdmixCO => ClkHdmixCO,
      ClkVgaRstxRNAO(0) => ClkVgaRstxRNAO(0),
      ClkVgaRstxRO(0) => ClkVgaRstxRO(0),
      ClkVgaxCO => ClkVgaxCO,
      PsClockxCI => PsClockxCI,
      PsResetxRN => PsResetxRN,
      VgaHdmiClkPllLockedxSO => VgaHdmiClkPllLockedxSO
    );
end STRUCTURE;
