--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2023.2 (lin64) Build 4029153 Fri Oct 13 20:13:54 MDT 2023
--Date        : Wed Mar 27 07:13:32 2024
--Host        : xps15-deb running 64-bit Debian GNU/Linux 12 (bookworm)
--Command     : generate_target scalp_zynqps_wrapper.bd
--Design      : scalp_zynqps_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity scalp_zynqps_wrapper is
  port (
    Clk125PllLockedxS : out STD_LOGIC;
    Clk125RstxRNAO : out STD_LOGIC_VECTOR ( 0 to 0 );
    Clk125RstxRO : out STD_LOGIC_VECTOR ( 0 to 0 );
    Clk125xCO : out STD_LOGIC;
    ClkHdmiRstxRNAO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkHdmiRstxRO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkHdmixCO : out STD_LOGIC;
    ClkVgaRstxRNAO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkVgaRstxRO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkVgaxCO : out STD_LOGIC;
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    GPIOJoystickxDI_tri_i : in STD_LOGIC_VECTOR ( 4 downto 0 );
    GPIOResetBtnxDO_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    GPIOSwitchesxDI_tri_i : in STD_LOGIC_VECTOR ( 1 downto 0 );
    IoExtIICxDIO_scl_io : inout STD_LOGIC;
    IoExtIICxDIO_sda_io : inout STD_LOGIC;
    SAxiMstCplxNumRegsClkxCO : out STD_LOGIC;
    SAxiMstCplxNumRegsRstxRANO : out STD_LOGIC;
    SAxiMstFirmwareIdClkxCO : out STD_LOGIC;
    SAxiMstFirmwareIdRstxRANO : out STD_LOGIC;
    Spi1MOSIxSO : out STD_LOGIC;
    Spi1SSxSO : out STD_LOGIC;
    Spi1SclkxCO : out STD_LOGIC;
    Usb0VBusPwrFaultxSI : in STD_LOGIC;
    VgaHdmiClkPllLockedxSO : out STD_LOGIC;
    aximm_mst_clpx_num_regs_if_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_clpx_num_regs_if_arready : in STD_LOGIC;
    aximm_mst_clpx_num_regs_if_arvalid : out STD_LOGIC;
    aximm_mst_clpx_num_regs_if_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_clpx_num_regs_if_awready : in STD_LOGIC;
    aximm_mst_clpx_num_regs_if_awvalid : out STD_LOGIC;
    aximm_mst_clpx_num_regs_if_bready : out STD_LOGIC;
    aximm_mst_clpx_num_regs_if_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aximm_mst_clpx_num_regs_if_bvalid : in STD_LOGIC;
    aximm_mst_clpx_num_regs_if_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_clpx_num_regs_if_rready : out STD_LOGIC;
    aximm_mst_clpx_num_regs_if_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aximm_mst_clpx_num_regs_if_rvalid : in STD_LOGIC;
    aximm_mst_clpx_num_regs_if_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_clpx_num_regs_if_wready : in STD_LOGIC;
    aximm_mst_clpx_num_regs_if_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    aximm_mst_clpx_num_regs_if_wvalid : out STD_LOGIC;
    aximm_mst_firmwareid_if_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_firmwareid_if_arready : in STD_LOGIC;
    aximm_mst_firmwareid_if_arvalid : out STD_LOGIC;
    aximm_mst_firmwareid_if_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_firmwareid_if_awready : in STD_LOGIC;
    aximm_mst_firmwareid_if_awvalid : out STD_LOGIC;
    aximm_mst_firmwareid_if_bready : out STD_LOGIC;
    aximm_mst_firmwareid_if_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aximm_mst_firmwareid_if_bvalid : in STD_LOGIC;
    aximm_mst_firmwareid_if_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_firmwareid_if_rready : out STD_LOGIC;
    aximm_mst_firmwareid_if_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aximm_mst_firmwareid_if_rvalid : in STD_LOGIC;
    aximm_mst_firmwareid_if_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_firmwareid_if_wready : in STD_LOGIC;
    aximm_mst_firmwareid_if_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    aximm_mst_firmwareid_if_wvalid : out STD_LOGIC
  );
end scalp_zynqps_wrapper;

architecture STRUCTURE of scalp_zynqps_wrapper is
  component scalp_zynqps is
  port (
    Spi1MOSIxSO : out STD_LOGIC;
    Spi1SSxSO : out STD_LOGIC;
    Spi1SclkxCO : out STD_LOGIC;
    Usb0VBusPwrFaultxSI : in STD_LOGIC;
    Clk125RstxRNAO : out STD_LOGIC_VECTOR ( 0 to 0 );
    Clk125RstxRO : out STD_LOGIC_VECTOR ( 0 to 0 );
    SAxiMstFirmwareIdClkxCO : out STD_LOGIC;
    SAxiMstFirmwareIdRstxRANO : out STD_LOGIC;
    ClkVgaxCO : out STD_LOGIC;
    ClkHdmixCO : out STD_LOGIC;
    ClkVgaRstxRO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkVgaRstxRNAO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkHdmiRstxRO : out STD_LOGIC_VECTOR ( 0 to 0 );
    ClkHdmiRstxRNAO : out STD_LOGIC_VECTOR ( 0 to 0 );
    Clk125PllLockedxS : out STD_LOGIC;
    Clk125xCO : out STD_LOGIC;
    SAxiMstCplxNumRegsClkxCO : out STD_LOGIC;
    SAxiMstCplxNumRegsRstxRANO : out STD_LOGIC;
    VgaHdmiClkPllLockedxSO : out STD_LOGIC;
    GPIOSwitchesxDI_tri_i : in STD_LOGIC_VECTOR ( 1 downto 0 );
    GPIOJoystickxDI_tri_i : in STD_LOGIC_VECTOR ( 4 downto 0 );
    GPIOResetBtnxDO_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    IoExtIICxDIO_scl_i : in STD_LOGIC;
    IoExtIICxDIO_scl_o : out STD_LOGIC;
    IoExtIICxDIO_scl_t : out STD_LOGIC;
    IoExtIICxDIO_sda_i : in STD_LOGIC;
    IoExtIICxDIO_sda_o : out STD_LOGIC;
    IoExtIICxDIO_sda_t : out STD_LOGIC;
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    aximm_mst_firmwareid_if_rready : out STD_LOGIC;
    aximm_mst_firmwareid_if_bvalid : in STD_LOGIC;
    aximm_mst_firmwareid_if_bready : out STD_LOGIC;
    aximm_mst_firmwareid_if_awvalid : out STD_LOGIC;
    aximm_mst_firmwareid_if_awready : in STD_LOGIC;
    aximm_mst_firmwareid_if_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_firmwareid_if_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aximm_mst_firmwareid_if_rvalid : in STD_LOGIC;
    aximm_mst_firmwareid_if_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_firmwareid_if_arready : in STD_LOGIC;
    aximm_mst_firmwareid_if_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_firmwareid_if_wvalid : out STD_LOGIC;
    aximm_mst_firmwareid_if_wready : in STD_LOGIC;
    aximm_mst_firmwareid_if_arvalid : out STD_LOGIC;
    aximm_mst_firmwareid_if_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    aximm_mst_firmwareid_if_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aximm_mst_firmwareid_if_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_clpx_num_regs_if_rready : out STD_LOGIC;
    aximm_mst_clpx_num_regs_if_bvalid : in STD_LOGIC;
    aximm_mst_clpx_num_regs_if_bready : out STD_LOGIC;
    aximm_mst_clpx_num_regs_if_awvalid : out STD_LOGIC;
    aximm_mst_clpx_num_regs_if_awready : in STD_LOGIC;
    aximm_mst_clpx_num_regs_if_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_clpx_num_regs_if_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aximm_mst_clpx_num_regs_if_rvalid : in STD_LOGIC;
    aximm_mst_clpx_num_regs_if_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_clpx_num_regs_if_arready : in STD_LOGIC;
    aximm_mst_clpx_num_regs_if_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    aximm_mst_clpx_num_regs_if_wvalid : out STD_LOGIC;
    aximm_mst_clpx_num_regs_if_wready : in STD_LOGIC;
    aximm_mst_clpx_num_regs_if_arvalid : out STD_LOGIC;
    aximm_mst_clpx_num_regs_if_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    aximm_mst_clpx_num_regs_if_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    aximm_mst_clpx_num_regs_if_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component scalp_zynqps;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal IoExtIICxDIO_scl_i : STD_LOGIC;
  signal IoExtIICxDIO_scl_o : STD_LOGIC;
  signal IoExtIICxDIO_scl_t : STD_LOGIC;
  signal IoExtIICxDIO_sda_i : STD_LOGIC;
  signal IoExtIICxDIO_sda_o : STD_LOGIC;
  signal IoExtIICxDIO_sda_t : STD_LOGIC;
begin
IoExtIICxDIO_scl_iobuf: component IOBUF
     port map (
      I => IoExtIICxDIO_scl_o,
      IO => IoExtIICxDIO_scl_io,
      O => IoExtIICxDIO_scl_i,
      T => IoExtIICxDIO_scl_t
    );
IoExtIICxDIO_sda_iobuf: component IOBUF
     port map (
      I => IoExtIICxDIO_sda_o,
      IO => IoExtIICxDIO_sda_io,
      O => IoExtIICxDIO_sda_i,
      T => IoExtIICxDIO_sda_t
    );
scalp_zynqps_i: component scalp_zynqps
     port map (
      Clk125PllLockedxS => Clk125PllLockedxS,
      Clk125RstxRNAO(0) => Clk125RstxRNAO(0),
      Clk125RstxRO(0) => Clk125RstxRO(0),
      Clk125xCO => Clk125xCO,
      ClkHdmiRstxRNAO(0) => ClkHdmiRstxRNAO(0),
      ClkHdmiRstxRO(0) => ClkHdmiRstxRO(0),
      ClkHdmixCO => ClkHdmixCO,
      ClkVgaRstxRNAO(0) => ClkVgaRstxRNAO(0),
      ClkVgaRstxRO(0) => ClkVgaRstxRO(0),
      ClkVgaxCO => ClkVgaxCO,
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      GPIOJoystickxDI_tri_i(4 downto 0) => GPIOJoystickxDI_tri_i(4 downto 0),
      GPIOResetBtnxDO_tri_o(0) => GPIOResetBtnxDO_tri_o(0),
      GPIOSwitchesxDI_tri_i(1 downto 0) => GPIOSwitchesxDI_tri_i(1 downto 0),
      IoExtIICxDIO_scl_i => IoExtIICxDIO_scl_i,
      IoExtIICxDIO_scl_o => IoExtIICxDIO_scl_o,
      IoExtIICxDIO_scl_t => IoExtIICxDIO_scl_t,
      IoExtIICxDIO_sda_i => IoExtIICxDIO_sda_i,
      IoExtIICxDIO_sda_o => IoExtIICxDIO_sda_o,
      IoExtIICxDIO_sda_t => IoExtIICxDIO_sda_t,
      SAxiMstCplxNumRegsClkxCO => SAxiMstCplxNumRegsClkxCO,
      SAxiMstCplxNumRegsRstxRANO => SAxiMstCplxNumRegsRstxRANO,
      SAxiMstFirmwareIdClkxCO => SAxiMstFirmwareIdClkxCO,
      SAxiMstFirmwareIdRstxRANO => SAxiMstFirmwareIdRstxRANO,
      Spi1MOSIxSO => Spi1MOSIxSO,
      Spi1SSxSO => Spi1SSxSO,
      Spi1SclkxCO => Spi1SclkxCO,
      Usb0VBusPwrFaultxSI => Usb0VBusPwrFaultxSI,
      VgaHdmiClkPllLockedxSO => VgaHdmiClkPllLockedxSO,
      aximm_mst_clpx_num_regs_if_araddr(31 downto 0) => aximm_mst_clpx_num_regs_if_araddr(31 downto 0),
      aximm_mst_clpx_num_regs_if_arready => aximm_mst_clpx_num_regs_if_arready,
      aximm_mst_clpx_num_regs_if_arvalid => aximm_mst_clpx_num_regs_if_arvalid,
      aximm_mst_clpx_num_regs_if_awaddr(31 downto 0) => aximm_mst_clpx_num_regs_if_awaddr(31 downto 0),
      aximm_mst_clpx_num_regs_if_awready => aximm_mst_clpx_num_regs_if_awready,
      aximm_mst_clpx_num_regs_if_awvalid => aximm_mst_clpx_num_regs_if_awvalid,
      aximm_mst_clpx_num_regs_if_bready => aximm_mst_clpx_num_regs_if_bready,
      aximm_mst_clpx_num_regs_if_bresp(1 downto 0) => aximm_mst_clpx_num_regs_if_bresp(1 downto 0),
      aximm_mst_clpx_num_regs_if_bvalid => aximm_mst_clpx_num_regs_if_bvalid,
      aximm_mst_clpx_num_regs_if_rdata(31 downto 0) => aximm_mst_clpx_num_regs_if_rdata(31 downto 0),
      aximm_mst_clpx_num_regs_if_rready => aximm_mst_clpx_num_regs_if_rready,
      aximm_mst_clpx_num_regs_if_rresp(1 downto 0) => aximm_mst_clpx_num_regs_if_rresp(1 downto 0),
      aximm_mst_clpx_num_regs_if_rvalid => aximm_mst_clpx_num_regs_if_rvalid,
      aximm_mst_clpx_num_regs_if_wdata(31 downto 0) => aximm_mst_clpx_num_regs_if_wdata(31 downto 0),
      aximm_mst_clpx_num_regs_if_wready => aximm_mst_clpx_num_regs_if_wready,
      aximm_mst_clpx_num_regs_if_wstrb(3 downto 0) => aximm_mst_clpx_num_regs_if_wstrb(3 downto 0),
      aximm_mst_clpx_num_regs_if_wvalid => aximm_mst_clpx_num_regs_if_wvalid,
      aximm_mst_firmwareid_if_araddr(31 downto 0) => aximm_mst_firmwareid_if_araddr(31 downto 0),
      aximm_mst_firmwareid_if_arready => aximm_mst_firmwareid_if_arready,
      aximm_mst_firmwareid_if_arvalid => aximm_mst_firmwareid_if_arvalid,
      aximm_mst_firmwareid_if_awaddr(31 downto 0) => aximm_mst_firmwareid_if_awaddr(31 downto 0),
      aximm_mst_firmwareid_if_awready => aximm_mst_firmwareid_if_awready,
      aximm_mst_firmwareid_if_awvalid => aximm_mst_firmwareid_if_awvalid,
      aximm_mst_firmwareid_if_bready => aximm_mst_firmwareid_if_bready,
      aximm_mst_firmwareid_if_bresp(1 downto 0) => aximm_mst_firmwareid_if_bresp(1 downto 0),
      aximm_mst_firmwareid_if_bvalid => aximm_mst_firmwareid_if_bvalid,
      aximm_mst_firmwareid_if_rdata(31 downto 0) => aximm_mst_firmwareid_if_rdata(31 downto 0),
      aximm_mst_firmwareid_if_rready => aximm_mst_firmwareid_if_rready,
      aximm_mst_firmwareid_if_rresp(1 downto 0) => aximm_mst_firmwareid_if_rresp(1 downto 0),
      aximm_mst_firmwareid_if_rvalid => aximm_mst_firmwareid_if_rvalid,
      aximm_mst_firmwareid_if_wdata(31 downto 0) => aximm_mst_firmwareid_if_wdata(31 downto 0),
      aximm_mst_firmwareid_if_wready => aximm_mst_firmwareid_if_wready,
      aximm_mst_firmwareid_if_wstrb(3 downto 0) => aximm_mst_firmwareid_if_wstrb(3 downto 0),
      aximm_mst_firmwareid_if_wvalid => aximm_mst_firmwareid_if_wvalid
    );
end STRUCTURE;
