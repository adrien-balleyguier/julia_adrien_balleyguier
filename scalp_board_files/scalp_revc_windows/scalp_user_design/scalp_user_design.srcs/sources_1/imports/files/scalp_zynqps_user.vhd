----------------------------------------------------------------------------------
--                                 _             _
--                                | |_  ___ _ __(_)__ _
--                                | ' \/ -_) '_ \ / _` |
--                                |_||_\___| .__/_\__,_|
--                                         |_|
--
----------------------------------------------------------------------------------
--
-- Company: hepia
-- Author: Joachim Schmidt <joachim.schmidt@hesge.ch>
--
-- Module Name: scalp_zynqps_user - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: scalp_zynqps_user
--
-- Last update: 2024-03-25
--
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- use ieee.std_logic_unsigned.all;
-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_misc.all;

library unisim;
use unisim.vcomponents.all;

library scalp_lib;
use scalp_lib.scalp_axi_pkg.all;
use scalp_lib.scalp_hdmi_pkg.all;

entity scalp_zynqps_wrapper is

    generic (
        C_AXI4_ARADDR_SIZE   : integer range 0 to 32 := 32;
        C_AXI4_RDATA_SIZE    : integer range 0 to 32 := 32;
        C_AXI4_RRESP_SIZE    : integer range 0 to 2  := 2;
        C_AXI4_AWADDR_SIZE   : integer range 0 to 32 := 32;
        C_AXI4_WDATA_SIZE    : integer range 0 to 32 := 32;
        C_AXI4_WSTRB_SIZE    : integer range 0 to 4  := 4;
        C_AXI4_BRESP_SIZE    : integer range 0 to 2  := 2;
        C_GPIO_SWITCHES_SIZE : integer range 0 to 32 := 2;
        C_GPIO_JOYSTICK_SIZE : integer range 0 to 32 := 5);

    port (
        -- Processor interface
        FIXED_IO_ps_clk     : inout std_logic;
        FIXED_IO_ps_porb    : inout std_logic;
        FIXED_IO_ps_srstb   : inout std_logic;
        HdmiVgaClocksxCO    : out   t_hdmi_vga_clocks;
        Clk125xCO           : out   std_logic;
        Clk125RstxRO        : out   std_logic;
        Clk125RstxRNAO      : out   std_logic;
        Clk125PllLockedxSO  : out   std_logic;
        -- DDR interface
        DDR_addr            : inout std_logic_vector (14 downto 0);
        DDR_ba              : inout std_logic_vector (2 downto 0);
        DDR_cas_n           : inout std_logic;
        DDR_ck_n            : inout std_logic;
        DDR_ck_p            : inout std_logic;
        DDR_cke             : inout std_logic;
        DDR_cs_n            : inout std_logic;
        DDR_dm              : inout std_logic_vector (3 downto 0);
        DDR_dq              : inout std_logic_vector (31 downto 0);
        DDR_dqs_n           : inout std_logic_vector (3 downto 0);
        DDR_dqs_p           : inout std_logic_vector (3 downto 0);
        DDR_odt             : inout std_logic;
        DDR_ras_n           : inout std_logic;
        DDR_reset_n         : inout std_logic;
        DDR_we_n            : inout std_logic;
        FIXED_IO_ddr_vrn    : inout std_logic;
        FIXED_IO_ddr_vrp    : inout std_logic;
        -- USB interface
        Usb0VBusPwrFaultxSI : in    std_logic;
        -- SPI1 used as uWire master. Clk, Data and LE signals are outputs
        -- SPI1 inputs are unused. Clk is connected to SCLK, Data to MOSI and LE to SS
        Spi1MOSIxSO         : out   std_logic;
        Spi1SSxSO           : out   std_logic;
        Spi1SclkxCO         : out   std_logic;
        -- MIO
        FIXED_IO_mio        : inout std_logic_vector (53 downto 0);
        -- GPIOs
        GPIOSwitchesxDI     : in    std_logic_vector((C_GPIO_SWITCHES_SIZE - 1) downto 0);
        GPIOJoystickxDI     : in    std_logic_vector((C_GPIO_JOYSTICK_SIZE - 1) downto 0);
        GPIOResetBtnxRNO    : out   std_logic;
        -- I2C
        IoExtIICSclxDIO     : inout std_logic;
        IoExtIICSdaxDIO     : inout std_logic;
        -- Firmware ID AXI interface + (clk and rst)
        FirmwareIDAxixDIO   : inout t_axi_lite;
        -- Complex Numbers Registers AXI interface + (clk and rst)
        ClpxNumRegsAxixDIO  : inout t_axi_lite);

end scalp_zynqps_wrapper;

architecture arch of scalp_zynqps_wrapper is

    -- Signals
    signal FirmwareIDAxixD  : t_axi_lite := C_AXI_LITE_IDLE;
    signal ClpxNumRegsAxixD : t_axi_lite := C_AXI_LITE_IDLE;
    signal GPIOResetBtnxR   : std_logic  := '0';
    -- I2C IO Ext.
    signal IoExtIICSclInxD  : std_logic  := '0';
    signal IoExtIICSclOutxD : std_logic  := '0';
    signal IoExtIICSclSelxD : std_logic  := '0';
    signal IoExtIICSdaInxD  : std_logic  := '0';
    signal IoExtIICSdaOutxD : std_logic  := '0';
    signal IoExtIICSdaSelxD : std_logic  := '0';

begin

    IOBufxB : block is
    begin  -- block IOBufxB

        IoExtIICSclxI : IOBUF
            generic map (
                DRIVE      => 12,
                IOSTANDARD => "LVCMOS25",
                SLEW       => "FAST")
            port map (
                O  => IoExtIICSclInxD,
                IO => IoExtIICSclxDIO,
                I  => IoExtIICSclOutxD,
                T  => IoExtIICSclSelxD);

        IoExtIICSdaxI : IOBUF
            generic map (
                DRIVE      => 12,
                IOSTANDARD => "LVCMOS25",
                SLEW       => "FAST")
            port map (
                O  => IoExtIICSdaInxD,
                IO => IoExtIICSdaxDIO,
                I  => IoExtIICSdaOutxD,
                T  => IoExtIICSdaSelxD);

    end block IOBufxB;

    PlatformxB : block is
    begin  -- block PlatformxB
        -- Firmware ID
        FirmwareIDAxixDIO.ClockxC            <= FirmwareIDAxixD.ClockxC;
        FirmwareIDAxixDIO.ResetxR            <= FirmwareIDAxixD.ResetxR;
        FirmwareIDAxixDIO.RdxD.AddrxD.M2SxD  <= FirmwareIDAxixD.RdxD.AddrxD.M2SxD;
        FirmwareIDAxixDIO.RdxD.DataxD.M2SxD  <= FirmwareIDAxixD.RdxD.DataxD.M2SxD;
        FirmwareIDAxixDIO.WrxD.AddrxD.M2SxD  <= FirmwareIDAxixD.WrxD.AddrxD.M2SxD;
        FirmwareIDAxixDIO.WrxD.DataxD.M2SxD  <= FirmwareIDAxixD.WrxD.DataxD.M2SxD;
        FirmwareIDAxixDIO.WrxD.RespxD.M2SxD  <= FirmwareIDAxixD.WrxD.RespxD.M2SxD;
        FirmwareIDAxixD.RdxD.AddrxD.S2MxD    <= FirmwareIDAxixDIO.RdxD.AddrxD.S2MxD;
        FirmwareIDAxixD.RdxD.DataxD.S2MxD    <= FirmwareIDAxixDIO.RdxD.DataxD.S2MxD;
        FirmwareIDAxixD.WrxD.AddrxD.S2MxD    <= FirmwareIDAxixDIO.WrxD.AddrxD.S2MxD;
        FirmwareIDAxixD.WrxD.DataxD.S2MxD    <= FirmwareIDAxixDIO.WrxD.DataxD.S2MxD;
        FirmwareIDAxixD.WrxD.RespxD.S2MxD    <= FirmwareIDAxixDIO.WrxD.RespxD.S2MxD;
        -- Complex Numbers Regs
        ClpxNumRegsAxixDIO.ClockxC           <= ClpxNumRegsAxixD.ClockxC;
        ClpxNumRegsAxixDIO.ResetxR           <= ClpxNumRegsAxixD.ResetxR;
        ClpxNumRegsAxixDIO.RdxD.AddrxD.M2SxD <= ClpxNumRegsAxixD.RdxD.AddrxD.M2SxD;
        ClpxNumRegsAxixDIO.RdxD.DataxD.M2SxD <= ClpxNumRegsAxixD.RdxD.DataxD.M2SxD;
        ClpxNumRegsAxixDIO.WrxD.AddrxD.M2SxD <= ClpxNumRegsAxixD.WrxD.AddrxD.M2SxD;
        ClpxNumRegsAxixDIO.WrxD.DataxD.M2SxD <= ClpxNumRegsAxixD.WrxD.DataxD.M2SxD;
        ClpxNumRegsAxixDIO.WrxD.RespxD.M2SxD <= ClpxNumRegsAxixD.WrxD.RespxD.M2SxD;
        ClpxNumRegsAxixD.RdxD.AddrxD.S2MxD   <= ClpxNumRegsAxixDIO.RdxD.AddrxD.S2MxD;
        ClpxNumRegsAxixD.RdxD.DataxD.S2MxD   <= ClpxNumRegsAxixDIO.RdxD.DataxD.S2MxD;
        ClpxNumRegsAxixD.WrxD.AddrxD.S2MxD   <= ClpxNumRegsAxixDIO.WrxD.AddrxD.S2MxD;
        ClpxNumRegsAxixD.WrxD.DataxD.S2MxD   <= ClpxNumRegsAxixDIO.WrxD.DataxD.S2MxD;
        ClpxNumRegsAxixD.WrxD.RespxD.S2MxD   <= ClpxNumRegsAxixDIO.WrxD.RespxD.S2MxD;
        -- GPIO Reset Btn
        GPIOResetBtnxAS : GPIOResetBtnxRNO   <= not GPIOResetBtnxR;

        ScalpZynqPSxI : entity work.scalp_zynqps
            port map (
                ---------------------------------------------------------------
                -- DDR3 Interface
                ---------------------------------------------------------------
                DDR_addr                                                   => DDR_addr,
                DDR_ba                                                     => DDR_ba,
                DDR_cas_n                                                  => DDR_cas_n,
                DDR_ck_n                                                   => DDR_ck_n,
                DDR_ck_p                                                   => DDR_ck_p,
                DDR_cke                                                    => DDR_cke,
                DDR_cs_n                                                   => DDR_cs_n,
                DDR_dm                                                     => DDR_dm,
                DDR_dq                                                     => DDR_dq,
                DDR_dqs_n                                                  => DDR_dqs_n,
                DDR_dqs_p                                                  => DDR_dqs_p,
                DDR_odt                                                    => DDR_odt,
                DDR_ras_n                                                  => DDR_ras_n,
                DDR_reset_n                                                => DDR_reset_n,
                DDR_we_n                                                   => DDR_we_n,
                FIXED_IO_ddr_vrn                                           => FIXED_IO_ddr_vrn,
                FIXED_IO_ddr_vrp                                           => FIXED_IO_ddr_vrp,
                FIXED_IO_mio                                               => FIXED_IO_mio,
                FIXED_IO_ps_clk                                            => FIXED_IO_ps_clk,
                FIXED_IO_ps_porb                                           => FIXED_IO_ps_porb,
                FIXED_IO_ps_srstb                                          => FIXED_IO_ps_srstb,
                Clk125xCO                                                  => Clk125xCO,
                Clk125RstxRO(0)                                            => Clk125RstxRO,
                Clk125RstxRNAO(0)                                          => Clk125RstxRNAO,
                Clk125PllLockedxS                                          => Clk125PllLockedxSO,
                ClkHdmixCO                                                 => HdmiVgaClocksxCO.HdmixC,
                ClkHdmiRstxRO(0)                                           => HdmiVgaClocksxCO.HdmiResetxR,
                ClkHdmiRstxRNAO(0)                                         => HdmiVgaClocksxCO.HdmiResetxRNA,
                ClkVgaxCO                                                  => HdmiVgaClocksxCO.VgaxC,
                ClkVgaRstxRO(0)                                            => HdmiVgaClocksxCO.VgaResetxR,
                ClkVgaRstxRNAO(0)                                          => HdmiVgaClocksxCO.VgaResetxRNA,
                VgaHdmiClkPllLockedxSO                                     => HdmiVgaClocksxCO.PllLockedxS,
                Spi1MOSIxSO                                                => Spi1MOSIxSO,
                Spi1SSxSO                                                  => Spi1SSxSO,
                Spi1SclkxCO                                                => Spi1SclkxCO,
                Usb0VBusPwrFaultxSI                                        => Usb0VBusPwrFaultxSI,
                ---------------------------------------------------------------
                -- GPIOs
                ---------------------------------------------------------------
                GPIOSwitchesxDI_tri_i((C_GPIO_SWITCHES_SIZE - 1) downto 0) => GPIOSwitchesxDI((C_GPIO_SWITCHES_SIZE - 1) downto 0),
                GPIOJoystickxDI_tri_i((C_GPIO_JOYSTICK_SIZE - 1) downto 0) => GPIOJoystickxDI((C_GPIO_JOYSTICK_SIZE - 1) downto 0),
                GPIOResetBtnxDO_tri_o(0)                                   => GPIOResetBtnxR,
                ---------------------------------------------------------------
                -- I2C
                ---------------------------------------------------------------
                IoExtIICxDIO_scl_i                                         => IoExtIICSclInxD,
                IoExtIICxDIO_scl_o                                         => IoExtIICSclOutxD,
                IoExtIICxDIO_scl_t                                         => IoExtIICSclSelxD,
                IoExtIICxDIO_sda_i                                         => IoExtIICSdaInxD,
                IoExtIICxDIO_sda_o                                         => IoExtIICSdaOutxD,
                IoExtIICxDIO_sda_t                                         => IoExtIICSdaSelxD,
                ---------------------------------------------------------------
                -- Firmware ID Axi Interface
                ---------------------------------------------------------------
                SAxiMstFirmwareIdClkxCO                                    => FirmwareIDAxixD.ClockxC.ClkxC,
                SAxiMstFirmwareIdRstxRANO                                  => FirmwareIDAxixD.ResetxR.RstxRAN,
                aximm_mst_firmwareid_if_araddr                             => FirmwareIDAxixD.RdxD.AddrxD.M2SxD.ARAddrxD,
                aximm_mst_firmwareid_if_arready                            => FirmwareIDAxixD.RdxD.AddrxD.S2MxD.ARReadyxS,
                aximm_mst_firmwareid_if_arvalid                            => FirmwareIDAxixD.RdxD.AddrxD.M2SxD.ARValidxS,
                aximm_mst_firmwareid_if_awaddr                             => FirmwareIDAxixD.WrxD.AddrxD.M2SxD.AWAddrxD,
                aximm_mst_firmwareid_if_awready                            => FirmwareIDAxixD.WrxD.AddrxD.S2MxD.AWReadyxS,
                aximm_mst_firmwareid_if_awvalid                            => FirmwareIDAxixD.WrxD.AddrxD.M2SxD.AWValidxS,
                aximm_mst_firmwareid_if_bready                             => FirmwareIDAxixD.WrxD.RespxD.M2SxD.BReadyxS,
                aximm_mst_firmwareid_if_bresp                              => FirmwareIDAxixD.WrxD.RespxD.S2MxD.BRespxD,
                aximm_mst_firmwareid_if_bvalid                             => FirmwareIDAxixD.WrxD.RespxD.S2MxD.BValidxS,
                aximm_mst_firmwareid_if_rdata                              => FirmwareIDAxixD.RdxD.DataxD.S2MxD.RDataxD,
                aximm_mst_firmwareid_if_rready                             => FirmwareIDAxixD.RdxD.DataxD.M2SxD.RReadyxS,
                aximm_mst_firmwareid_if_rresp                              => FirmwareIDAxixD.RdxD.DataxD.S2MxD.RRespxD,
                aximm_mst_firmwareid_if_rvalid                             => FirmwareIDAxixD.RdxD.DataxD.S2MxD.RValidxS,
                aximm_mst_firmwareid_if_wdata                              => FirmwareIDAxixD.WrxD.DataxD.M2SxD.WDataxD,
                aximm_mst_firmwareid_if_wready                             => FirmwareIDAxixD.WrxD.DataxD.S2MxD.WReadyxS,
                aximm_mst_firmwareid_if_wstrb                              => FirmwareIDAxixD.WrxD.DataxD.M2SxD.WStrbxD,
                aximm_mst_firmwareid_if_wvalid                             => FirmwareIDAxixD.WrxD.DataxD.M2SxD.WValidxS,
                ---------------------------------------------------------------
                -- Complexe Numbers Registers Axi Interface
                ---------------------------------------------------------------
                SAxiMstCplxNumRegsClkxCO                                   => ClpxNumRegsAxixD.ClockxC.ClkxC,
                SAxiMstCplxNumRegsRstxRANO                                 => ClpxNumRegsAxixD.ResetxR.RstxRAN,
                aximm_mst_clpx_num_regs_if_araddr                          => ClpxNumRegsAxixD.RdxD.AddrxD.M2SxD.ARAddrxD,
                aximm_mst_clpx_num_regs_if_arready                         => ClpxNumRegsAxixD.RdxD.AddrxD.S2MxD.ARReadyxS,
                aximm_mst_clpx_num_regs_if_arvalid                         => ClpxNumRegsAxixD.RdxD.AddrxD.M2SxD.ARValidxS,
                aximm_mst_clpx_num_regs_if_awaddr                          => ClpxNumRegsAxixD.WrxD.AddrxD.M2SxD.AWAddrxD,
                aximm_mst_clpx_num_regs_if_awready                         => ClpxNumRegsAxixD.WrxD.AddrxD.S2MxD.AWReadyxS,
                aximm_mst_clpx_num_regs_if_awvalid                         => ClpxNumRegsAxixD.WrxD.AddrxD.M2SxD.AWValidxS,
                aximm_mst_clpx_num_regs_if_bready                          => ClpxNumRegsAxixD.WrxD.RespxD.M2SxD.BReadyxS,
                aximm_mst_clpx_num_regs_if_bresp                           => ClpxNumRegsAxixD.WrxD.RespxD.S2MxD.BRespxD,
                aximm_mst_clpx_num_regs_if_bvalid                          => ClpxNumRegsAxixD.WrxD.RespxD.S2MxD.BValidxS,
                aximm_mst_clpx_num_regs_if_rdata                           => ClpxNumRegsAxixD.RdxD.DataxD.S2MxD.RDataxD,
                aximm_mst_clpx_num_regs_if_rready                          => ClpxNumRegsAxixD.RdxD.DataxD.M2SxD.RReadyxS,
                aximm_mst_clpx_num_regs_if_rresp                           => ClpxNumRegsAxixD.RdxD.DataxD.S2MxD.RRespxD,
                aximm_mst_clpx_num_regs_if_rvalid                          => ClpxNumRegsAxixD.RdxD.DataxD.S2MxD.RValidxS,
                aximm_mst_clpx_num_regs_if_wdata                           => ClpxNumRegsAxixD.WrxD.DataxD.M2SxD.WDataxD,
                aximm_mst_clpx_num_regs_if_wready                          => ClpxNumRegsAxixD.WrxD.DataxD.S2MxD.WReadyxS,
                aximm_mst_clpx_num_regs_if_wstrb                           => ClpxNumRegsAxixD.WrxD.DataxD.M2SxD.WStrbxD,
                aximm_mst_clpx_num_regs_if_wvalid                          => ClpxNumRegsAxixD.WrxD.DataxD.M2SxD.WValidxS);

    end block PlatformxB;

end arch;
