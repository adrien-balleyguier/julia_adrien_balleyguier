-- (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- (c) Copyright 2022-2024 Advanced Micro Devices, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of AMD and is protected under U.S. and international copyright
-- and other intellectual property laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- AMD, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) AMD shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or AMD had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- AMD products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of AMD products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: hepia.hesge.ch:user:scalp_axi_link:1.0
-- IP Revision: 2

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY scalp_zynqps_scalp_axi_link_firmwareid_0 IS
  PORT (
    SAxiSlvClkxCI : IN STD_LOGIC;
    SAxiSlvRstxRANI : IN STD_LOGIC;
    SAxiSlvARAddrxDI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    SAxiSlvARValidxSI : IN STD_LOGIC;
    SAxiSlvARReadyxSO : OUT STD_LOGIC;
    SAxiSlvRDataxDO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    SAxiSlvRRespxDO : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    SAxiSlvRValidxSO : OUT STD_LOGIC;
    SAxiSlvRReadyxSI : IN STD_LOGIC;
    SAxiSlvAWAddrxDI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    SAxiSlvAWValidxSI : IN STD_LOGIC;
    SAxiSlvAWReadyxSO : OUT STD_LOGIC;
    SAxiSlvWDataxDI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    SAxiSlvWStrbxDI : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    SAxiSlvWValidxSI : IN STD_LOGIC;
    SAxiSlvWReadyxSO : OUT STD_LOGIC;
    SAxiSlvBRespxDO : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    SAxiSlvBValidxSO : OUT STD_LOGIC;
    SAxiSlvBReadyxSI : IN STD_LOGIC;
    SAxiMstClkxCO : OUT STD_LOGIC;
    SAxiMstRstxRANO : OUT STD_LOGIC;
    SAxiMstARAddrxDO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    SAxiMstARValidxSO : OUT STD_LOGIC;
    SAxiMstARReadyxSI : IN STD_LOGIC;
    SAxiMstRDataxDI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    SAxiMstRRespxDI : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    SAxiMstRValidxSI : IN STD_LOGIC;
    SAxiMstRReadyxSO : OUT STD_LOGIC;
    SAxiMstAWAddrxDO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    SAxiMstAWValidxSO : OUT STD_LOGIC;
    SAxiMstAWReadyxSI : IN STD_LOGIC;
    SAxiMstWDataxDO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    SAxiMstWStrbxDO : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    SAxiMstWValidxSO : OUT STD_LOGIC;
    SAxiMstWReadyxSI : IN STD_LOGIC;
    SAxiMstBRespxDI : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    SAxiMstBValidxSI : IN STD_LOGIC;
    SAxiMstBReadyxSO : OUT STD_LOGIC
  );
END scalp_zynqps_scalp_axi_link_firmwareid_0;

ARCHITECTURE scalp_zynqps_scalp_axi_link_firmwareid_0_arch OF scalp_zynqps_scalp_axi_link_firmwareid_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF scalp_zynqps_scalp_axi_link_firmwareid_0_arch: ARCHITECTURE IS "yes";
  COMPONENT scalp_axi_link IS
    GENERIC (
      C_AXI4_ARADDR_SIZE : INTEGER;
      C_AXI4_RDATA_SIZE : INTEGER;
      C_AXI4_RRESP_SIZE : INTEGER;
      C_AXI4_AWADDR_SIZE : INTEGER;
      C_AXI4_WDATA_SIZE : INTEGER;
      C_AXI4_WSTRB_SIZE : INTEGER;
      C_AXI4_BRESP_SIZE : INTEGER;
      C_AXI4_ADDR_SIZE : INTEGER;
      C_AXI4_DATA_SIZE : INTEGER
    );
    PORT (
      SAxiSlvClkxCI : IN STD_LOGIC;
      SAxiSlvRstxRANI : IN STD_LOGIC;
      SAxiSlvARAddrxDI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      SAxiSlvARValidxSI : IN STD_LOGIC;
      SAxiSlvARReadyxSO : OUT STD_LOGIC;
      SAxiSlvRDataxDO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      SAxiSlvRRespxDO : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      SAxiSlvRValidxSO : OUT STD_LOGIC;
      SAxiSlvRReadyxSI : IN STD_LOGIC;
      SAxiSlvAWAddrxDI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      SAxiSlvAWValidxSI : IN STD_LOGIC;
      SAxiSlvAWReadyxSO : OUT STD_LOGIC;
      SAxiSlvWDataxDI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      SAxiSlvWStrbxDI : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      SAxiSlvWValidxSI : IN STD_LOGIC;
      SAxiSlvWReadyxSO : OUT STD_LOGIC;
      SAxiSlvBRespxDO : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      SAxiSlvBValidxSO : OUT STD_LOGIC;
      SAxiSlvBReadyxSI : IN STD_LOGIC;
      SAxiMstClkxCO : OUT STD_LOGIC;
      SAxiMstRstxRANO : OUT STD_LOGIC;
      SAxiMstARAddrxDO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      SAxiMstARValidxSO : OUT STD_LOGIC;
      SAxiMstARReadyxSI : IN STD_LOGIC;
      SAxiMstRDataxDI : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      SAxiMstRRespxDI : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      SAxiMstRValidxSI : IN STD_LOGIC;
      SAxiMstRReadyxSO : OUT STD_LOGIC;
      SAxiMstAWAddrxDO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      SAxiMstAWValidxSO : OUT STD_LOGIC;
      SAxiMstAWReadyxSI : IN STD_LOGIC;
      SAxiMstWDataxDO : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      SAxiMstWStrbxDO : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      SAxiMstWValidxSO : OUT STD_LOGIC;
      SAxiMstWReadyxSI : IN STD_LOGIC;
      SAxiMstBRespxDI : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      SAxiMstBValidxSI : IN STD_LOGIC;
      SAxiMstBReadyxSO : OUT STD_LOGIC
    );
  END COMPONENT scalp_axi_link;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF scalp_zynqps_scalp_axi_link_firmwareid_0_arch: ARCHITECTURE IS "scalp_axi_link,Vivado 2023.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF scalp_zynqps_scalp_axi_link_firmwareid_0_arch : ARCHITECTURE IS "scalp_zynqps_scalp_axi_link_firmwareid_0,scalp_axi_link,{}";
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF scalp_zynqps_scalp_axi_link_firmwareid_0_arch: ARCHITECTURE IS "package_project";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF SAxiMstARAddrxDO: SIGNAL IS "XIL_INTERFACENAME aximm_mst_if, DATA_WIDTH 32, PROTOCOL AXI4LITE, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN scalp_zynqps_scalp_axi_link_firmwareid_0_SAxiMstClkxCO, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, W" & 
"USER_BITS_PER_BYTE 0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstARAddrxDO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstARReadyxSI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstARValidxSO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstAWAddrxDO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstAWReadyxSI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstAWValidxSO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstBReadyxSO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstBRespxDI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstBValidxSI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if BVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF SAxiMstClkxCO: SIGNAL IS "XIL_INTERFACENAME aximm_mst_clk, ASSOCIATED_RESET SAxiMstRstxRANO, ASSOCIATED_BUSIF aximm_mst_if, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN scalp_zynqps_scalp_axi_link_firmwareid_0_SAxiMstClkxCO, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstClkxCO: SIGNAL IS "xilinx.com:signal:clock:1.0 aximm_mst_clk CLK";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstRDataxDI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstRReadyxSO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstRRespxDI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstRValidxSI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if RVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF SAxiMstRstxRANO: SIGNAL IS "XIL_INTERFACENAME aximm_master_reset, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstRstxRANO: SIGNAL IS "xilinx.com:signal:reset:1.0 aximm_master_reset RST";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstWDataxDO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstWReadyxSI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstWStrbxDO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiMstWValidxSO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_mst_if WVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF SAxiSlvARAddrxDI: SIGNAL IS "XIL_INTERFACENAME aximm_slv_if, DATA_WIDTH 32, PROTOCOL AXI4LITE, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN /sys_clock_clk_out1, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvARAddrxDI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvARReadyxSO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvARValidxSI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvAWAddrxDI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if AWADDR";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvAWReadyxSO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvAWValidxSI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvBReadyxSI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvBRespxDO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvBValidxSO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if BVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF SAxiSlvClkxCI: SIGNAL IS "XIL_INTERFACENAME aximm_slv_clk, ASSOCIATED_RESET SAxiSlvRstxRANI, ASSOCIATED_BUSIF aximm_slv_if, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN /sys_clock_clk_out1, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvClkxCI: SIGNAL IS "xilinx.com:signal:clock:1.0 aximm_slv_clk CLK";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvRDataxDO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvRReadyxSI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvRRespxDO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvRValidxSO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if RVALID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF SAxiSlvRstxRANI: SIGNAL IS "XIL_INTERFACENAME aximm_slv_rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvRstxRANI: SIGNAL IS "xilinx.com:signal:reset:1.0 aximm_slv_rst RST";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvWDataxDI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvWReadyxSO: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvWStrbxDI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF SAxiSlvWValidxSI: SIGNAL IS "xilinx.com:interface:aximm:1.0 aximm_slv_if WVALID";
BEGIN
  U0 : scalp_axi_link
    GENERIC MAP (
      C_AXI4_ARADDR_SIZE => 32,
      C_AXI4_RDATA_SIZE => 32,
      C_AXI4_RRESP_SIZE => 2,
      C_AXI4_AWADDR_SIZE => 32,
      C_AXI4_WDATA_SIZE => 32,
      C_AXI4_WSTRB_SIZE => 4,
      C_AXI4_BRESP_SIZE => 2,
      C_AXI4_ADDR_SIZE => 12,
      C_AXI4_DATA_SIZE => 32
    )
    PORT MAP (
      SAxiSlvClkxCI => SAxiSlvClkxCI,
      SAxiSlvRstxRANI => SAxiSlvRstxRANI,
      SAxiSlvARAddrxDI => SAxiSlvARAddrxDI,
      SAxiSlvARValidxSI => SAxiSlvARValidxSI,
      SAxiSlvARReadyxSO => SAxiSlvARReadyxSO,
      SAxiSlvRDataxDO => SAxiSlvRDataxDO,
      SAxiSlvRRespxDO => SAxiSlvRRespxDO,
      SAxiSlvRValidxSO => SAxiSlvRValidxSO,
      SAxiSlvRReadyxSI => SAxiSlvRReadyxSI,
      SAxiSlvAWAddrxDI => SAxiSlvAWAddrxDI,
      SAxiSlvAWValidxSI => SAxiSlvAWValidxSI,
      SAxiSlvAWReadyxSO => SAxiSlvAWReadyxSO,
      SAxiSlvWDataxDI => SAxiSlvWDataxDI,
      SAxiSlvWStrbxDI => SAxiSlvWStrbxDI,
      SAxiSlvWValidxSI => SAxiSlvWValidxSI,
      SAxiSlvWReadyxSO => SAxiSlvWReadyxSO,
      SAxiSlvBRespxDO => SAxiSlvBRespxDO,
      SAxiSlvBValidxSO => SAxiSlvBValidxSO,
      SAxiSlvBReadyxSI => SAxiSlvBReadyxSI,
      SAxiMstClkxCO => SAxiMstClkxCO,
      SAxiMstRstxRANO => SAxiMstRstxRANO,
      SAxiMstARAddrxDO => SAxiMstARAddrxDO,
      SAxiMstARValidxSO => SAxiMstARValidxSO,
      SAxiMstARReadyxSI => SAxiMstARReadyxSI,
      SAxiMstRDataxDI => SAxiMstRDataxDI,
      SAxiMstRRespxDI => SAxiMstRRespxDI,
      SAxiMstRValidxSI => SAxiMstRValidxSI,
      SAxiMstRReadyxSO => SAxiMstRReadyxSO,
      SAxiMstAWAddrxDO => SAxiMstAWAddrxDO,
      SAxiMstAWValidxSO => SAxiMstAWValidxSO,
      SAxiMstAWReadyxSI => SAxiMstAWReadyxSI,
      SAxiMstWDataxDO => SAxiMstWDataxDO,
      SAxiMstWStrbxDO => SAxiMstWStrbxDO,
      SAxiMstWValidxSO => SAxiMstWValidxSO,
      SAxiMstWReadyxSI => SAxiMstWReadyxSI,
      SAxiMstBRespxDI => SAxiMstBRespxDI,
      SAxiMstBValidxSI => SAxiMstBValidxSI,
      SAxiMstBReadyxSO => SAxiMstBReadyxSO
    );
END scalp_zynqps_scalp_axi_link_firmwareid_0_arch;
