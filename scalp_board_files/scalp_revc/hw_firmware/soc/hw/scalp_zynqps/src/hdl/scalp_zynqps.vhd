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
-- Module Name: scalp_zynqps_wrapper - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: scalp_zynqps_wrapper
--
-- Last update: 2024-03-21
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

entity scalp_zynqps_wrapper is

    generic (
        C_AXI4_ARADDR_SIZE   : integer range 0 to 32 := 32;
        C_AXI4_RDATA_SIZE    : integer range 0 to 32 := 32;
        C_AXI4_RRESP_SIZE    : integer range 0 to 2  := 2;
        C_AXI4_AWADDR_SIZE   : integer range 0 to 32 := 32;
        C_AXI4_WDATA_SIZE    : integer range 0 to 32 := 32;
        C_AXI4_WSTRB_SIZE    : integer range 0 to 4  := 4;
        C_AXI4_BRESP_SIZE    : integer range 0 to 2  := 2;
        C_GPIO_SWITCHES_SIZE : integer range 0 to 32 := 2);

    port (
        -- Processor interface
        FIXED_IO_ps_clk     : inout std_logic;
        FIXED_IO_ps_porb    : inout std_logic;
        FIXED_IO_ps_srstb   : inout std_logic;
        Clk125xCO           : out   std_logic;
        Clk125RstxRO        : out   std_logic;
        Clk125RstxRNAO      : out   std_logic;
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
        GPIOResetBtnxRNO    : out   std_logic;
        -- Firmware ID AXI interface + (clk and rst)
        FirmwareIDAxixCO    : out   t_axi_clk;
        FirmwareIDAxixRO    : out   t_axi_reset;
        FirmwareIDAxixDO    : out   t_axi_m2s;
        FirmwareIDAxixDI    : in    t_axi_s2m);

end scalp_zynqps_wrapper;

architecture arch of scalp_zynqps_wrapper is

    -- Signals
    signal FirmwareIDAxixC    : t_axi_clk   := C_AXI_IDLE_CLK;
    signal FirmwareIDAxixR    : t_axi_reset := C_AXI_IDLE_RESET;
    signal FirmwareIDAxiOutxD : t_axi_m2s   := C_AXI_IDLE_M2S;
    signal FirmwareIDAxiInxD  : t_axi_s2m   := C_AXI_IDLE_S2M;
    signal GPIOResetBtnxR     : std_logic   := '0';

begin

    PlatformxB : block is
    begin  -- block PlatformxB

        FirmwareIDAxiClkxAS : FirmwareIDAxixCO  <= FirmwareIDAxixC;
        FirmwareIDAxiRstxAS : FirmwareIDAxixRO  <= FirmwareIDAxixR;
        FirmwareIDAxiOutxAS : FirmwareIDAxixDO  <= FirmwareIDAxiOutxD;
        FirmwareIDAxiInxAS  : FirmwareIDAxiInxD <= FirmwareIDAxixDI;
        GPIOResetBtnxAS     : GPIOResetBtnxRNO  <= not GPIOResetBtnxR;

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
                Spi1MOSIxSO                                                => Spi1MOSIxSO,
                Spi1SSxSO                                                  => Spi1SSxSO,
                Spi1SclkxCO                                                => Spi1SclkxCO,
                Usb0VBusPwrFaultxSI                                        => Usb0VBusPwrFaultxSI,
                ---------------------------------------------------------------
                -- GPIOs
                ---------------------------------------------------------------
                GPIOSwitchesxDI_tri_i((C_GPIO_SWITCHES_SIZE - 1) downto 0) => GPIOSwitchesxDI((C_GPIO_SWITCHES_SIZE - 1) downto 0),
                GPIOResetBtnxDO_tri_o(0)                                   => GPIOResetBtnxR,
                ---------------------------------------------------------------
                -- ID Axi Interface
                ---------------------------------------------------------------
                SAxiMstFirmwareIDClkxCO                                    => FirmwareIDAxixC.ClkxC,
                SAxiMstFirmwareIDRstxRANO                                  => FirmwareIDAxixR.ResetxRAN,
                aximm_mst_firmwareid_if_araddr                             => FirmwareIDAxiOutxD.ARAddrxD,
                aximm_mst_firmwareid_if_arready                            => FirmwareIDAxiInxD.RdxD.ARReadyxS,
                aximm_mst_firmwareid_if_arvalid                            => FirmwareIDAxiOutxD.ARValidxS,
                aximm_mst_firmwareid_if_awaddr                             => FirmwareIDAxiOutxD.AWAddrxD,
                aximm_mst_firmwareid_if_awready                            => FirmwareIDAxiInxD.WrxD.AWReadyxS,
                aximm_mst_firmwareid_if_awvalid                            => FirmwareIDAxiOutxD.AWValidxS,
                aximm_mst_firmwareid_if_bready                             => FirmwareIDAxiOutxD.BReadyxS,
                aximm_mst_firmwareid_if_bresp                              => FirmwareIDAxiInxD.WrxD.BRespxD,
                aximm_mst_firmwareid_if_bvalid                             => FirmwareIDAxiInxD.WrxD.BValidxS,
                aximm_mst_firmwareid_if_rdata                              => FirmwareIDAxiInxD.RdxD.RDataxD,
                aximm_mst_firmwareid_if_rready                             => FirmwareIDAxiOutxD.RReadyxS,
                aximm_mst_firmwareid_if_rresp                              => FirmwareIDAxiInxD.RdxD.RRespxD,
                aximm_mst_firmwareid_if_rvalid                             => FirmwareIDAxiInxD.RdxD.RValidxS,
                aximm_mst_firmwareid_if_wdata                              => FirmwareIDAxiOutxD.WDataxD,
                aximm_mst_firmwareid_if_wready                             => FirmwareIDAxiInxD.WrxD.WReadyxS,
                aximm_mst_firmwareid_if_wstrb                              => FirmwareIDAxiOutxD.WStrbxD,
                aximm_mst_firmwareid_if_wvalid                             => FirmwareIDAxiOutxD.WValidxS);

    end block PlatformxB;

end arch;
