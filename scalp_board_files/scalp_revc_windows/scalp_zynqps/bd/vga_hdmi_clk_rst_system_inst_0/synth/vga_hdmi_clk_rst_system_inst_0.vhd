--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2023.2 (lin64) Build 4029153 Fri Oct 13 20:13:54 MDT 2023
--Date        : Wed Mar 27 07:13:45 2024
--Host        : xps15-deb running 64-bit Debian GNU/Linux 12 (bookworm)
--Command     : generate_target vga_hdmi_clk_rst_system_inst_0.bd
--Design      : vga_hdmi_clk_rst_system_inst_0
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity vga_hdmi_clk_rst_system_inst_0 is
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
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of vga_hdmi_clk_rst_system_inst_0 : entity is "vga_hdmi_clk_rst_system_inst_0,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=vga_hdmi_clk_rst_system_inst_0,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=3,numReposBlks=3,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=/home/jo/projects/scalp_revc_windows/scalp_user_design/scalp_user_design.srcs/sources_1/bd/vga_hdmi_clk_rst_system/vga_hdmi_clk_rst_system.bd,synth_mode=Hierarchical}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of vga_hdmi_clk_rst_system_inst_0 : entity is "vga_hdmi_clk_rst_system_inst_0.hwdef";
end vga_hdmi_clk_rst_system_inst_0;

architecture STRUCTURE of vga_hdmi_clk_rst_system_inst_0 is
  component vga_hdmi_clk_rst_system_inst_0_vga_hdmi_clock_0 is
  port (
    resetn : in STD_LOGIC;
    clk_in1 : in STD_LOGIC;
    clk_vga : out STD_LOGIC;
    clk_hdmi : out STD_LOGIC;
    locked : out STD_LOGIC
  );
  end component vga_hdmi_clk_rst_system_inst_0_vga_hdmi_clock_0;
  component vga_hdmi_clk_rst_system_inst_0_rst_ps7_1_vga_0 is
  port (
    slowest_sync_clk : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    aux_reset_in : in STD_LOGIC;
    mb_debug_sys_rst : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    mb_reset : out STD_LOGIC;
    bus_struct_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component vga_hdmi_clk_rst_system_inst_0_rst_ps7_1_vga_0;
  component vga_hdmi_clk_rst_system_inst_0_rst_ps7_2_hdmi_0 is
  port (
    slowest_sync_clk : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    aux_reset_in : in STD_LOGIC;
    mb_debug_sys_rst : in STD_LOGIC;
    dcm_locked : in STD_LOGIC;
    mb_reset : out STD_LOGIC;
    bus_struct_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_reset : out STD_LOGIC_VECTOR ( 0 to 0 );
    interconnect_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 );
    peripheral_aresetn : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component vga_hdmi_clk_rst_system_inst_0_rst_ps7_2_hdmi_0;
  signal clk_in1_0_1 : STD_LOGIC;
  signal resetn_0_1 : STD_LOGIC;
  signal rst_ps7_1_vga_peripheral_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rst_ps7_1_vga_peripheral_reset : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rst_ps7_2_hdmi_peripheral_aresetn : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rst_ps7_2_hdmi_peripheral_reset : STD_LOGIC_VECTOR ( 0 to 0 );
  signal vga_hdmi_clock_clk_hdmi : STD_LOGIC;
  signal vga_hdmi_clock_clk_vga : STD_LOGIC;
  signal vga_hdmi_clock_locked : STD_LOGIC;
  signal NLW_rst_ps7_1_vga_mb_reset_UNCONNECTED : STD_LOGIC;
  signal NLW_rst_ps7_1_vga_bus_struct_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_rst_ps7_1_vga_interconnect_aresetn_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_rst_ps7_2_hdmi_mb_reset_UNCONNECTED : STD_LOGIC;
  signal NLW_rst_ps7_2_hdmi_bus_struct_reset_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_rst_ps7_2_hdmi_interconnect_aresetn_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of ClkHdmixCO : signal is "xilinx.com:signal:clock:1.0 CLK.CLKHDMIXCO CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of ClkHdmixCO : signal is "XIL_INTERFACENAME CLK.CLKHDMIXCO, ASSOCIATED_RESET ClkHdmiRstxRNAO:ClkHdmiRstxRO, CLK_DOMAIN /vga_hdmi_clk_rst_sys_0/vga_hdmi_clock_clk_out1, FREQ_HZ 240000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of ClkVgaxCO : signal is "xilinx.com:signal:clock:1.0 CLK.CLKVGAXCO CLK";
  attribute X_INTERFACE_PARAMETER of ClkVgaxCO : signal is "XIL_INTERFACENAME CLK.CLKVGAXCO, ASSOCIATED_RESET ClkVgaRstxRNAO:ClkVgaRstxRO, CLK_DOMAIN /vga_hdmi_clk_rst_sys_0/vga_hdmi_clock_clk_out1, FREQ_HZ 48000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of PsClockxCI : signal is "xilinx.com:signal:clock:1.0 CLK.PSCLOCKXCI CLK";
  attribute X_INTERFACE_PARAMETER of PsClockxCI : signal is "XIL_INTERFACENAME CLK.PSCLOCKXCI, ASSOCIATED_RESET PsResetxRN, CLK_DOMAIN scalp_zynqps_processing_system7_0_0_FCLK_CLK0, FREQ_HZ 125000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
  attribute X_INTERFACE_INFO of PsResetxRN : signal is "xilinx.com:signal:reset:1.0 RST.PSRESETXRN RST";
  attribute X_INTERFACE_PARAMETER of PsResetxRN : signal is "XIL_INTERFACENAME RST.PSRESETXRN, INSERT_VIP 0, POLARITY ACTIVE_LOW";
  attribute X_INTERFACE_INFO of ClkHdmiRstxRNAO : signal is "xilinx.com:signal:reset:1.0 RST.CLKHDMIRSTXRNAO RST";
  attribute X_INTERFACE_PARAMETER of ClkHdmiRstxRNAO : signal is "XIL_INTERFACENAME RST.CLKHDMIRSTXRNAO, INSERT_VIP 0, POLARITY ACTIVE_LOW, TYPE PERIPHERAL";
  attribute X_INTERFACE_INFO of ClkHdmiRstxRO : signal is "xilinx.com:signal:reset:1.0 RST.CLKHDMIRSTXRO RST";
  attribute X_INTERFACE_PARAMETER of ClkHdmiRstxRO : signal is "XIL_INTERFACENAME RST.CLKHDMIRSTXRO, INSERT_VIP 0, POLARITY ACTIVE_HIGH, TYPE PERIPHERAL";
  attribute X_INTERFACE_INFO of ClkVgaRstxRNAO : signal is "xilinx.com:signal:reset:1.0 RST.CLKVGARSTXRNAO RST";
  attribute X_INTERFACE_PARAMETER of ClkVgaRstxRNAO : signal is "XIL_INTERFACENAME RST.CLKVGARSTXRNAO, INSERT_VIP 0, POLARITY ACTIVE_LOW, TYPE PERIPHERAL";
  attribute X_INTERFACE_INFO of ClkVgaRstxRO : signal is "xilinx.com:signal:reset:1.0 RST.CLKVGARSTXRO RST";
  attribute X_INTERFACE_PARAMETER of ClkVgaRstxRO : signal is "XIL_INTERFACENAME RST.CLKVGARSTXRO, INSERT_VIP 0, POLARITY ACTIVE_HIGH, TYPE PERIPHERAL";
begin
  ClkHdmiRstxRNAO(0) <= rst_ps7_2_hdmi_peripheral_aresetn(0);
  ClkHdmiRstxRO(0) <= rst_ps7_2_hdmi_peripheral_reset(0);
  ClkHdmixCO <= vga_hdmi_clock_clk_hdmi;
  ClkVgaRstxRNAO(0) <= rst_ps7_1_vga_peripheral_aresetn(0);
  ClkVgaRstxRO(0) <= rst_ps7_1_vga_peripheral_reset(0);
  ClkVgaxCO <= vga_hdmi_clock_clk_vga;
  VgaHdmiClkPllLockedxSO <= vga_hdmi_clock_locked;
  clk_in1_0_1 <= PsClockxCI;
  resetn_0_1 <= PsResetxRN;
rst_ps7_1_vga: component vga_hdmi_clk_rst_system_inst_0_rst_ps7_1_vga_0
     port map (
      aux_reset_in => '1',
      bus_struct_reset(0) => NLW_rst_ps7_1_vga_bus_struct_reset_UNCONNECTED(0),
      dcm_locked => vga_hdmi_clock_locked,
      ext_reset_in => resetn_0_1,
      interconnect_aresetn(0) => NLW_rst_ps7_1_vga_interconnect_aresetn_UNCONNECTED(0),
      mb_debug_sys_rst => '0',
      mb_reset => NLW_rst_ps7_1_vga_mb_reset_UNCONNECTED,
      peripheral_aresetn(0) => rst_ps7_1_vga_peripheral_aresetn(0),
      peripheral_reset(0) => rst_ps7_1_vga_peripheral_reset(0),
      slowest_sync_clk => vga_hdmi_clock_clk_vga
    );
rst_ps7_2_hdmi: component vga_hdmi_clk_rst_system_inst_0_rst_ps7_2_hdmi_0
     port map (
      aux_reset_in => '1',
      bus_struct_reset(0) => NLW_rst_ps7_2_hdmi_bus_struct_reset_UNCONNECTED(0),
      dcm_locked => vga_hdmi_clock_locked,
      ext_reset_in => resetn_0_1,
      interconnect_aresetn(0) => NLW_rst_ps7_2_hdmi_interconnect_aresetn_UNCONNECTED(0),
      mb_debug_sys_rst => '0',
      mb_reset => NLW_rst_ps7_2_hdmi_mb_reset_UNCONNECTED,
      peripheral_aresetn(0) => rst_ps7_2_hdmi_peripheral_aresetn(0),
      peripheral_reset(0) => rst_ps7_2_hdmi_peripheral_reset(0),
      slowest_sync_clk => vga_hdmi_clock_clk_hdmi
    );
vga_hdmi_clock: component vga_hdmi_clk_rst_system_inst_0_vga_hdmi_clock_0
     port map (
      clk_hdmi => vga_hdmi_clock_clk_hdmi,
      clk_in1 => clk_in1_0_1,
      clk_vga => vga_hdmi_clock_clk_vga,
      locked => vga_hdmi_clock_locked,
      resetn => resetn_0_1
    );
end STRUCTURE;
