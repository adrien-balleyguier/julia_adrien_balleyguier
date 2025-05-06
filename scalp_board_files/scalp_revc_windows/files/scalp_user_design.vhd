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
-- Module Name: scalp_user_design - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: scalp_user_design
--
-- Last update: 2024-03-26
--
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use ieee.math_real.all;
use ieee.math_real."ceil";
use ieee.math_real."log2";
-- use ieee.std_logic_unsigned.all;
-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_misc.all;

library unisim;
use unisim.vcomponents.all;

library unimacro;
use unimacro.vcomponents.all;

library scalp_lib;
use scalp_lib.scalp_axi_pkg.all;
use scalp_lib.scalp_hdmi_pkg.all;

entity scalp_user_design is

    generic (
        C_USE_IBERT          : boolean               := false;
        C_DEBUG_MODE         : boolean               := false;
        C_GPIO_SWITCHES_SIZE : integer range 0 to 32 := 2;
        C_GPIO_JOYSTICK_SIZE : integer range 0 to 32 := 5;
        C_HDMI_LANES         : integer range 0 to 3  := 3);

    port (
        -----------------------------------------------------------------------
        -- Names defined and not described in the constraint file.
        -----------------------------------------------------------------------
        -- Zynq FIXED_IO
        PSClkxCIO          : inout std_logic;
        PSSRstxRNIO        : inout std_logic;
        PSPorxSNIO         : inout std_logic;
        -- DDR interface
        DDRClkxCNIO        : inout std_logic;
        DDRClkxCPIO        : inout std_logic;
        DDRDRstxRNIO       : inout std_logic;
        DDRCasxSNIO        : inout std_logic;
        DDRCkexSIO         : inout std_logic;
        DDRCsxSNIO         : inout std_logic;
        DDROdtxSIO         : inout std_logic;
        DDRRasxSNIO        : inout std_logic;
        DDRWexSNIO         : inout std_logic;
        DDRBankAddrxDIO    : inout std_logic_vector(2 downto 0);
        DDRAddrxDIO        : inout std_logic_vector(14 downto 0);
        DDRVrxSNIO         : inout std_logic;
        DDRVrxSPIO         : inout std_logic;
        DDRDmxDIO          : inout std_logic_vector(3 downto 0);
        DDRDqxDIO          : inout std_logic_vector(31 downto 0);
        DDRDqsxDNIO        : inout std_logic_vector(3 downto 0);
        DDRDqsxDPIO        : inout std_logic_vector(3 downto 0);
        -- MIO Interface
        MIOxDIO            : inout std_logic_vector(53 downto 0);
        -----------------------------------------------------------------------
        -- USB signals
        UsbVbusPwrFaultxSI : in    std_logic;
        -- PLL interface
        Pll2V5ClkuWirexCO  : out   std_logic;  -- Clock (from SPI1_SCLK)
        Pll2V5DatauWirexSO : out   std_logic;  -- Data (from SPI1_MOSI)
        Pll2V5LEuWirexSO   : out   std_logic;  -- Latch enable (from SPI1_SS)
        Pll2V5GOExSO       : out   std_logic;  -- Global Output Enable
        Pll2V5LDxSI        : in    std_logic;  -- Lock Detect
        Pll2V5SyncxSO      : out   std_logic;  -- Sync
        Pll2V5ClkIn0LOSxSI : in    std_logic;  -- FPGA clock Loss of Sync
        Pll2V5ClkIn1LOSxSI : in    std_logic;  -- External oscillator Loss of Sync
        -- GTP interfaces
        -- Clocks
        -- GTPRefClk0PxCI     : in    std_logic;
        -- GTPRefClk0NxCI     : in    std_logic;
        -- GTPRefClk1PxCI     : in    std_logic;
        -- GTPRefClk1NxCI     : in    std_logic;
        -- North
        -- GTPFromNorthPxSI   : in    std_logic;
        -- GTPFromNorthNxSI   : in    std_logic;
        -- GTPToNorthPxSO     : out   std_logic;
        -- GTPToNorthNxSO     : out   std_logic;
        -- East
        -- GTPFromEastPxSI    : in    std_logic;
        -- GTPFromEastNxSI    : in    std_logic;
        -- GTPToEastPxSO      : out   std_logic;
        -- GTPToEastNxSO      : out   std_logic;
        -- South
        -- GTPFromSouthPxSI   : in    std_logic;
        -- GTPFromSouthNxSI   : in    std_logic;
        -- GTPToSouthPxSO     : out   std_logic;
        -- GTPToSouthNxSO     : out   std_logic;
        -- West
        -- GTPFromWestPxSI    : in    std_logic;
        -- GTPFromWestNxSI    : in    std_logic;
        -- GTPToWestPxSO      : out   std_logic;
        -- GTPToWestNxSO      : out   std_logic;
        -- LVDS links towards edge connectors
        -- North
        -- LVDS2V5North0PxSIO  : inout std_logic;
        -- LVDS2V5North0NxSIO  : inout std_logic;
        -- LVDS2V5North1PxSIO  : inout std_logic;
        -- LVDS2V5North1NxSIO  : inout std_logic;
        -- LVDS2V5North2PxSIO  : inout std_logic;
        -- LVDS2V5North2NxSIO  : inout std_logic;
        -- LVDS2V5North3PxSIO  : inout std_logic;
        -- LVDS2V5North3NxSIO  : inout std_logic;
        -- LVDS2V5North4PxSIO  : inout std_logic;
        -- LVDS2V5North4NxSIO  : inout std_logic;
        -- LVDS2V5North5PxSIO  : inout std_logic;
        -- LVDS2V5North5NxSIO  : inout std_logic;
        -- LVDS2V5North6PxSIO  : inout std_logic;
        -- LVDS2V5North6NxSIO  : inout std_logic;
        -- LVDS2V5North7PxSIO  : inout std_logic;
        -- LVDS2V5North7NxSIO  : inout std_logic;
        -- South
        -- LVDS2V5South0PxSIO  : inout std_logic;
        -- LVDS2V5South0NxSIO  : inout std_logic;
        -- LVDS2V5South1PxSIO  : inout std_logic;
        -- LVDS2V5South1NxSIO  : inout std_logic;
        -- LVDS2V5South2PxSIO  : inout std_logic;
        -- LVDS2V5South2NxSIO  : inout std_logic;
        -- LVDS2V5South3PxSIO  : inout std_logic;
        -- LVDS2V5South3NxSIO  : inout std_logic;
        -- LVDS2V5South4PxSIO  : inout std_logic;
        -- LVDS2V5South4NxSIO  : inout std_logic;
        -- LVDS2V5South5PxSIO  : inout std_logic;
        -- LVDS2V5South5NxSIO  : inout std_logic;
        -- LVDS2V5South6PxSIO  : inout std_logic;
        -- LVDS2V5South6NxSIO  : inout std_logic;
        -- LVDS2V5South7PxSIO  : inout std_logic;
        -- LVDS2V5South7NxSIO  : inout std_logic;
        -- East
        -- LVDS2V5East0PxSIO   : inout std_logic;
        -- LVDS2V5East0NxSIO   : inout std_logic;
        -- LVDS2V5East1PxSIO   : inout std_logic;
        -- LVDS2V5East1NxSIO   : inout std_logic;
        -- LVDS2V5East2PxSIO   : inout std_logic;
        -- LVDS2V5East2NxSIO   : inout std_logic;
        -- LVDS2V5East3PxSIO   : inout std_logic;
        -- LVDS2V5East3NxSIO   : inout std_logic;
        -- LVDS2V5East4PxSIO   : inout std_logic;
        -- LVDS2V5East4NxSIO   : inout std_logic;
        -- LVDS2V5East5PxSIO   : inout std_logic;
        -- LVDS2V5East5NxSIO   : inout std_logic;
        -- LVDS2V5East6PxSIO   : inout std_logic;
        -- LVDS2V5East6NxSIO   : inout std_logic;
        -- LVDS2V5East7PxSIO   : inout std_logic;
        -- LVDS2V5East7NxSIO   : inout std_logic;
        -- West
        -- LVDS2V5West0PxSIO   : inout std_logic;
        -- LVDS2V5West0NxSIO   : inout std_logic;
        -- LVDS2V5West1PxSIO   : inout std_logic;
        -- LVDS2V5West1NxSIO   : inout std_logic;
        -- LVDS2V5West2PxSIO   : inout std_logic;
        -- LVDS2V5West2NxSIO   : inout std_logic;
        -- LVDS2V5West3PxSIO   : inout std_logic;
        -- LVDS2V5West3NxSIO   : inout std_logic;
        -- LVDS2V5West4PxSIO   : inout std_logic;
        -- LVDS2V5West4NxSIO   : inout std_logic;
        -- LVDS2V5West5PxSIO   : inout std_logic;
        -- LVDS2V5West5NxSIO   : inout std_logic;
        -- LVDS2V5West6PxSIO   : inout std_logic;
        -- LVDS2V5West6NxSIO   : inout std_logic;
        -- LVDS2V5West7PxSIO   : inout std_logic;
        -- LVDS2V5West7NxSIO   : inout std_logic;
        -- LVDS links towards top-bottom connectors
        -- Top
        -- LVDS2V5Top0PxSIO    : inout std_logic;
        -- LVDS2V5Top0NxSIO    : inout std_logic;
        -- LVDS2V5Top1PxSIO    : inout std_logic;
        -- LVDS2V5Top1NxSIO    : inout std_logic;
        -- LVDS2V5Top2PxSIO    : inout std_logic;
        -- LVDS2V5Top2NxSIO    : inout std_logic;
        -- LVDS2V5Top3PxSIO    : inout std_logic;
        -- LVDS2V5Top3NxSIO    : inout std_logic;
        -- LVDS2V5Top4PxSIO    : inout std_logic;
        -- LVDS2V5Top4NxSIO    : inout std_logic;
        -- LVDS2V5Top5PxSIO    : inout std_logic;
        -- LVDS2V5Top5NxSIO    : inout std_logic;
        -- LVDS2V5Top6PxSIO    : inout std_logic;
        -- LVDS2V5Top6NxSIO    : inout std_logic;
        -- LVDS2V5Top7PxSIO    : inout std_logic;
        -- LVDS2V5Top7NxSIO    : inout std_logic;
        -- Bottom
        -- LVDS2V5Bottom0PxSIO : inout std_logic;
        -- LVDS2V5Bottom0NxSIO : inout std_logic;
        -- LVDS2V5Bottom1PxSIO : inout std_logic;
        -- LVDS2V5Bottom1NxSIO : inout std_logic;
        -- LVDS2V5Bottom2PxSIO : inout std_logic;
        -- LVDS2V5Bottom2NxSIO : inout std_logic;
        -- LVDS2V5Bottom3PxSIO : inout std_logic;
        -- LVDS2V5Bottom3NxSIO : inout std_logic;
        -- LVDS2V5Bottom4PxSIO : inout std_logic;
        -- LVDS2V5Bottom4NxSIO : inout std_logic;
        -- LVDS2V5Bottom5PxSIO : inout std_logic;
        -- LVDS2V5Bottom5NxSIO : inout std_logic;
        -- LVDS2V5Bottom6PxSIO : inout std_logic;
        -- LVDS2V5Bottom6NxSIO : inout std_logic;
        -- LVDS2V5Bottom7PxSIO : inout std_logic;
        -- LVDS2V5Bottom7NxSIO : inout std_logic;
        -----------------------------------------------------------------------
        -- HDMI TX
        -----------------------------------------------------------------------
        -- HdmiTXSdaxSIO      : inout std_logic;
        -- HdmiTXSclxSO       : out   std_logic;
        HdmiTXCecxSIO      : inout std_logic;
        HdmiTXHpdxSI       : in    std_logic;
        HdmiTXClkPxSO      : out   std_logic;
        HdmiTXClkNxSO      : out   std_logic;
        HdmiTXPxDO         : out   std_logic_vector((C_HDMI_LANES - 1) downto 0);
        HdmiTXNxDO         : out   std_logic_vector((C_HDMI_LANES - 1) downto 0);
        -----------------------------------------------------------------------
        -- Switches
        -----------------------------------------------------------------------
        SwitchesxDI        : in    std_logic_vector((C_GPIO_SWITCHES_SIZE - 1) downto 0);
        -----------------------------------------------------------------------
        -- Joystick
        -----------------------------------------------------------------------
        JoystickxDI        : in    std_logic_vector((C_GPIO_JOYSTICK_SIZE - 1) downto 0);
        -----------------------------------------------------------------------
        -- I2C IO Ext.
        -----------------------------------------------------------------------
        IoExtIICSclxDIO    : inout std_logic;
        IoExtIICSdaxDIO    : inout std_logic;
        -----------------------------------------------------------------------
        -- RGB LEDs
        -----------------------------------------------------------------------
        Led12V5RxSO        : out   std_logic;
        Led12V5GxSO        : out   std_logic;
        Led12V5BxSO        : out   std_logic;
        Led22V5RxSO        : out   std_logic;
        Led22V5GxSO        : out   std_logic;
        Led22V5BxSO        : out   std_logic;
        -----------------------------------------------------------------------
        -- Self reset (connected to PS_SRSTB)
        -----------------------------------------------------------------------
        SelfRstxRNO        : out   std_logic);
    -- Clocks from PLLs (connected to MRCC pins)
    -- Local
    -- PLLClk2V5LocalPxCI  : in    std_logic;
    -- PLLClk2V5LocalNxCI  : in    std_logic;
    -- -- North
    -- PLLClk2V5NorthPxCI  : in    std_logic;
    -- PLLClk2V5NorthNxCI  : in    std_logic;
    -- -- South
    -- PLLClk2V5SouthPxCI  : in    std_logic;
    -- PLLClk2V5SouthNxCI  : in    std_logic;
    -- -- Top
    -- PLLClk2V5TopxCI     : in    std_logic;  -- Single-ended
    -- -- Bottom
    -- PLLClk2V5BottomxCI  : in    std_logic;  -- Single-ended
    -- -- Clocks to/from neighbours
    -- -- North
    -- Clk2V5NorthPxCI     : in    std_logic;
    -- Clk2V5NorthNxCI     : in    std_logic;
    -- Clk2V5NorthPxCO     : out   std_logic;
    -- Clk2V5NorthNxCO     : out   std_logic;
    -- -- South
    -- Clk2V5SouthPxCI     : in    std_logic;
    -- Clk2V5SouthNxCI     : in    std_logic;
    -- Clk2V5SouthPxCO     : out   std_logic;
    -- Clk2V5SouthNxCO     : out   std_logic;
    -- -- East
    -- Clk2V5EastPxCI      : in    std_logic;
    -- Clk2V5EastNxCI      : in    std_logic;
    -- Clk2V5EastPxCO      : out   std_logic;
    -- Clk2V5EastNxCO      : out   std_logic;
    -- -- West
    -- Clk2V5WestPxCI      : in    std_logic;
    -- Clk2V5WestNxCI      : in    std_logic;
    -- Clk2V5WestPxCO      : out   std_logic;
    -- Clk2V5WestNxCO      : out   std_logic;
    -- -- Top
    -- Clk2V5TopPxCI       : in    std_logic;
    -- Clk2V5TopNxCI       : in    std_logic;
    -- Clk2V5TopPxCO       : out   std_logic;
    -- Clk2V5TopNxCO       : out   std_logic;
    -- -- Bottom
    -- Clk2V5BottomPxCI    : in    std_logic;
    -- Clk2V5BottomNxCI    : in    std_logic;
    -- Clk2V5BottomPxCO    : out   std_logic;
    -- Clk2V5BottomNxCO    : out   std_logic;
    -- -- Recovery
    -- Clk2V5RecoveryPxCO  : out   std_logic;
    -- Clk2V5RecoveryNxCO  : out   std_logic);

end scalp_user_design;

architecture arch of scalp_user_design is

    -- Constants
    constant C_REGS_DATA_SIZE            : integer range 0 to 32 := 32;
    constant C_REGS_ADDR_SIZE            : integer               := 4096;
    constant C_REGS_ADDR_BIT_SIZE        : integer range 0 to 32 := integer(ceil(log2(real(C_REGS_ADDR_SIZE))));
    constant C_AXI4_ARADDR_SIZE          : integer range 0 to 32 := 32;
    constant C_AXI4_RDATA_SIZE           : integer range 0 to 32 := 32;
    constant C_AXI4_RRESP_SIZE           : integer range 0 to 2  := 2;
    constant C_AXI4_AWADDR_SIZE          : integer range 0 to 32 := 32;
    constant C_AXI4_WDATA_SIZE           : integer range 0 to 32 := 32;
    constant C_AXI4_WSTRB_SIZE           : integer range 0 to 4  := 4;
    constant C_AXI4_BRESP_SIZE           : integer range 0 to 2  := 2;
    -- Scalp PWM
    constant C_PWM_SIZE                  : integer               := 8;
    constant C_CLK_CNT_LEN               : positive              := 256;
    -- Firmware ID
    constant C_FIRMWARE_ID_NB_REGS_IN    : integer               := 0;
    constant C_FIRMWARE_ID_NB_REGS_OUT   : integer               := 2;
    -- Complex number registers
    constant C_CPLX_NUM_REGS_NB_REGS_IN  : integer               := 0;
    constant C_CPLX_NUM_REGS_NB_REGS_OUT : integer               := 4;
    -- RGB Leds
    constant C_NB_RGB_LEDS               : integer               := 2;
    constant C_RGB_LED_1_IDX             : integer               := 0;
    constant C_RGB_LED_2_IDX             : integer               := 1;

    -- Components
    component scalp_zynqps_wrapper is
        generic (
            C_AXI4_ARADDR_SIZE   : integer range 0 to 32;
            C_AXI4_RDATA_SIZE    : integer range 0 to 32;
            C_AXI4_RRESP_SIZE    : integer range 0 to 2;
            C_AXI4_AWADDR_SIZE   : integer range 0 to 32;
            C_AXI4_WDATA_SIZE    : integer range 0 to 32;
            C_AXI4_WSTRB_SIZE    : integer range 0 to 4;
            C_AXI4_BRESP_SIZE    : integer range 0 to 2;
            C_GPIO_SWITCHES_SIZE : integer range 0 to 32;
            C_GPIO_JOYSTICK_SIZE : integer range 0 to 32);
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
    end component scalp_zynqps_wrapper;

    component scalp_firmwareid is
        generic (
            C_REGS_ADDR_SIZE : integer;
            C_NB_REGS_IN     : integer;
            C_NB_REGS_OUT    : integer);
        port (
            AxiSlvxDIO  : inout t_axi_lite;
            -- RegPortsxDI : in    t_axi_bunch_of_registers((C_NB_REGS_IN - 1) downto 0);
            RegPortsxDO : out   t_axi_bunch_of_registers((C_NB_REGS_OUT - 1) downto 0));
    end component scalp_firmwareid;

    component scalp_cplx_num_regs is
        generic (
            C_REGS_ADDR_SIZE : integer;
            C_NB_REGS_IN     : integer;
            C_NB_REGS_OUT    : integer);
        port (
            AxiSlvxDIO  : inout t_axi_lite;
            -- RegPortsxDI : in    t_axi_bunch_of_registers((C_NB_REGS_IN - 1) downto 0);
            RegPortsxDO : out   t_axi_bunch_of_registers((C_NB_REGS_OUT - 1) downto 0));
    end component scalp_cplx_num_regs;

    component scalp_pwm is
        generic (
            C_PWM_SIZE    : integer;
            C_CLK_CNT_LEN : positive);
        port (
            ClkxCI       : in  std_logic;
            RstxRANI     : in  std_logic;
            DutyCyclexDI : in  unsigned((C_PWM_SIZE - 1) downto 0);
            PwmxSO       : out std_logic);
    end component scalp_pwm;

    component scalp_hdmi is
        generic (
            C_VGA_CONFIG : t_vga_config);
        port (
            ClocksxCI         : in    t_hdmi_vga_clocks;
            VgaPixCountersxDO : out   t_hdmi_vga_pix_counters;
            PixelxDI          : in    t_hdmi_vga_pix;
            HdmiTxxDIO        : inout t_hdmi_tx);
    end component scalp_hdmi;

    -- Signals
    -- Clocks
    -- Processing system clock
    signal Clk125xC                : std_logic         := '0';
    -- Processing system pll locked
    signal Clk125PllLockedxS       : std_logic         := '0';
    -- Vga and Hdmi clocks
    signal HdmiVgaClocksxC         : t_hdmi_vga_clocks := C_HDMI_VGA_CLOCKS_IDLE;
    -- Resets
    -- Processing system reset
    signal Clk125RstxR             : std_logic         := '0';
    signal Clk125RstxRNA           : std_logic         := '1';
    ---------------------------------------------------------------------------
    -- Firmware ID
    ---------------------------------------------------------------------------
    signal FirmwareIDAxixD         : t_axi_lite        := C_AXI_LITE_IDLE;
    -- Register outputs
    signal FirmwareLedColorPortsxD : t_axi_bunch_of_registers((C_NB_RGB_LEDS - 1) downto 0) :=
        (others => C_AXI_REGISTER_IDLE);
    ---------------------------------------------------------------------------
    -- Complex Numbers Regs
    ---------------------------------------------------------------------------
    signal ClpxNumRegsAxixD : t_axi_lite                                            := C_AXI_LITE_IDLE;
    -- Register outputs
    signal PatternPortsxD   : t_axi_bunch_of_registers(1 downto 0)                  := (others => C_AXI_REGISTER_IDLE);
    signal ZImInPortxD      : t_axi_register                                        := C_AXI_REGISTER_IDLE;
    signal ZReInPortxD      : t_axi_register                                        := C_AXI_REGISTER_IDLE;
    ---------------------------------------------------------------------------
    -- Scalp Hdmi
    ---------------------------------------------------------------------------
    signal VgaPixCountersxD : t_hdmi_vga_pix_counters                               := C_HDMI_VGA_PIX_COUNTERS_IDLE;
    signal PixelxD          : t_hdmi_vga_pix                                        := C_HDMI_VGA_PIX_RED;
    signal HdmiTxxD         : t_hdmi_tx;
    ---------------------------------------------------------------------------
    -- GPIO Switches and Joystick
    ---------------------------------------------------------------------------
    signal GPIOSwitchesxD   : std_logic_vector((C_GPIO_SWITCHES_SIZE - 1) downto 0) := (others => '0');
    signal GPIOJoystickxD   : std_logic_vector((C_GPIO_JOYSTICK_SIZE - 1) downto 0) := (others => '0');

    -- Attributes
    attribute mark_debug       : string;
    attribute keep             : string;
    -- Clocks
    attribute keep of Clk125xC : signal is "true";
    -- Firmware ID
    -- attribute mark_debug of FirmwareIDAxixD  : signal is "true";
    -- attribute keep of FirmwareIDAxixD        : signal is "true";
    -- Complex Numbers Regs
    -- attribute mark_debug of ClpxNumRegsAxixD : signal is "true";
    -- attribute keep of ClpxNumRegsAxixD       : signal is "true";
    -- Hdmi
    -- attribute mark_debug of VgaPixCountersxD : signal is "true";
    -- attribute keep of VgaPixCountersxD       : signal is "true";
    -- attribute mark_debug of PixelxD          : signal is "true";
    -- attribute keep of PixelxD                : signal is "true";

begin

    PSxB : block is
    begin  -- block PSxB

        ZynqxI : entity work.scalp_zynqps_wrapper
            generic map (
                C_AXI4_ARADDR_SIZE   => C_AXI4_ARADDR_SIZE,
                C_AXI4_RDATA_SIZE    => C_AXI4_RDATA_SIZE,
                C_AXI4_RRESP_SIZE    => C_AXI4_RRESP_SIZE,
                C_AXI4_AWADDR_SIZE   => C_AXI4_AWADDR_SIZE,
                C_AXI4_WDATA_SIZE    => C_AXI4_WDATA_SIZE,
                C_AXI4_WSTRB_SIZE    => C_AXI4_WSTRB_SIZE,
                C_AXI4_BRESP_SIZE    => C_AXI4_BRESP_SIZE,
                C_GPIO_SWITCHES_SIZE => C_GPIO_SWITCHES_SIZE,
                C_GPIO_JOYSTICK_SIZE => C_GPIO_JOYSTICK_SIZE)
            port map (
                FIXED_IO_ps_clk     => PSClkxCIO,
                FIXED_IO_ps_porb    => PSPorxSNIO,
                FIXED_IO_ps_srstb   => PSSRstxRNIO,
                -- Clk and rst (125Mhz)
                HdmiVgaClocksxCO    => HdmiVgaClocksxC,
                Clk125xCO           => Clk125xC,
                Clk125RstxRO        => Clk125RstxR,
                Clk125RstxRNAO      => Clk125RstxRNA,
                Clk125PllLockedxSO  => Clk125PllLockedxS,
                -- DDR interface
                DDR_addr            => DDRAddrxDIO,
                DDR_ba              => DDRBankAddrxDIO,
                DDR_cas_n           => DDRCasxSNIO,
                DDR_ck_n            => DDRClkxCNIO,
                DDR_ck_p            => DDRClkxCPIO,
                DDR_cke             => DDRCkexSIO,
                DDR_cs_n            => DDRCsxSNIO,
                DDR_dm              => DDRDmxDIO,
                DDR_dq              => DDRDqxDIO,
                DDR_dqs_n           => DDRDqsxDNIO,
                DDR_dqs_p           => DDRDqsxDPIO,
                DDR_odt             => DDROdtxSIO,
                DDR_ras_n           => DDRRasxSNIO,
                DDR_reset_n         => DDRDRstxRNIO,
                DDR_we_n            => DDRWexSNIO,
                FIXED_IO_ddr_vrn    => DDRVrxSNIO,
                FIXED_IO_ddr_vrp    => DDRVrxSPIO,
                -- USB interface
                Usb0VBusPwrFaultxSI => UsbVbusPwrFaultxSI,
                -- SPI1 used as uWire master. Clk, Data and LE signals are outputs
                -- SPI1 inputs are unused. Clk is connected to SCLK, Data to MOSI and LE to SS
                Spi1MOSIxSO         => Pll2V5DatauWirexSO,
                Spi1SSxSO           => Pll2V5LEuWirexSO,
                Spi1SclkxCO         => Pll2V5ClkuWirexCO,
                -- MIO
                FIXED_IO_mio        => MIOxDIO,
                -- GPIOs
                GPIOSwitchesxDI     => GPIOSwitchesxD,
                GPIOJoystickxDI     => GPIOJoystickxD,
                GPIOResetBtnxRNO    => SelfRstxRNO,
                -- I2C
                IoExtIICSclxDIO     => IoExtIICSclxDIO,
                IoExtIICSdaxDIO     => IoExtIICSdaxDIO,
                -- Firmware ID AXI interface + (clk and rst)
                FirmwareIDAxixDIO   => FirmwareIDAxixD,
                -- Complex Numbers Registers AXI interface + (clk and rst)
                ClpxNumRegsAxixDIO  => ClpxNumRegsAxixD);

    end block PSxB;

    PLxB : block is
    begin  -- block PLxB

        ScalpFirmwareIDxI : entity work.scalp_firmwareid
            generic map (
                C_REGS_ADDR_SIZE => C_REGS_ADDR_SIZE,
                C_NB_REGS_IN     => C_FIRMWARE_ID_NB_REGS_IN,
                C_NB_REGS_OUT    => C_FIRMWARE_ID_NB_REGS_OUT)
            port map (
                AxiSlvxDIO  => FirmwareIDAxixD,
                -- RegPortsxDI => RegPortsxD,
                RegPortsxDO => FirmwareLedColorPortsxD);

        PwmLedsxB : block is

            -- PWM led signals
            signal PwmRed1xS   : std_logic := '0';
            signal PwmRed2xS   : std_logic := '0';
            signal PwmGreen1xS : std_logic := '0';
            signal PwmGreen2xS : std_logic := '0';
            signal PwmBlue1xS  : std_logic := '0';
            signal PwmBlue2xS  : std_logic := '0';

            -- Attributes
            attribute mark_debug : string;
            attribute keep       : string;

            -- attribute mark_debug of PwmRedxS   : signal is "true";
            -- attribute keep of PwmRedxS         : signal is "true";
            -- attribute mark_debug of PwmGreenxS : signal is "true";
            -- attribute keep of PwmGreenxS       : signal is "true";
            -- attribute mark_debug of PwmBluexS  : signal is "true";
            -- attribute keep of PwmBluexS        : signal is "true";

        begin  -- block PwmLedsxB

            PwmRed1xI : entity work.scalp_pwm
                generic map (
                    C_PWM_SIZE    => C_PWM_SIZE,
                    C_CLK_CNT_LEN => C_CLK_CNT_LEN)
                port map (
                    ClkxCI       => FirmwareIDAxixD.ClockxC.ClkxC,
                    RstxRANI     => FirmwareIDAxixD.ResetxR.RstxRAN,
                    DutyCyclexDI => unsigned(FirmwareLedColorPortsxD(C_RGB_LED_1_IDX).RegxD(23 downto 16)),
                    PwmxSO       => PwmRed1xS);

            PwmRed2xI : entity work.scalp_pwm
                generic map (
                    C_PWM_SIZE    => C_PWM_SIZE,
                    C_CLK_CNT_LEN => C_CLK_CNT_LEN)
                port map (
                    ClkxCI       => FirmwareIDAxixD.ClockxC.ClkxC,
                    RstxRANI     => FirmwareIDAxixD.ResetxR.RstxRAN,
                    DutyCyclexDI => unsigned(FirmwareLedColorPortsxD(C_RGB_LED_2_IDX).RegxD(23 downto 16)),
                    PwmxSO       => PwmRed2xS);

            OBufRedxB : block is
            begin  -- block OBufRedxB

                OutBufLed1RxI : OBUF
                    generic map (
                        DRIVE      => 12,
                        IOSTANDARD => "DEFAULT",
                        SLEW       => "SLOW")
                    port map (
                        O => Led12V5RxSO,
                        I => PwmRed1xS);

                OutBufLed2RxI : OBUF
                    generic map (
                        DRIVE      => 12,
                        IOSTANDARD => "DEFAULT",
                        SLEW       => "SLOW")
                    port map (
                        O => Led22V5RxSO,
                        I => PwmRed2xS);

            end block OBufRedxB;

            PwmGreen1xI : entity work.scalp_pwm
                generic map (
                    C_PWM_SIZE    => C_PWM_SIZE,
                    C_CLK_CNT_LEN => C_CLK_CNT_LEN)
                port map (
                    ClkxCI       => FirmwareIDAxixD.ClockxC.ClkxC,
                    RstxRANI     => FirmwareIDAxixD.ResetxR.RstxRAN,
                    DutyCyclexDI => unsigned(FirmwareLedColorPortsxD(C_RGB_LED_1_IDX).RegxD(15 downto 8)),
                    PwmxSO       => PwmGreen1xS);

            PwmGreen2xI : entity work.scalp_pwm
                generic map (
                    C_PWM_SIZE    => C_PWM_SIZE,
                    C_CLK_CNT_LEN => C_CLK_CNT_LEN)
                port map (
                    ClkxCI       => FirmwareIDAxixD.ClockxC.ClkxC,
                    RstxRANI     => FirmwareIDAxixD.ResetxR.RstxRAN,
                    DutyCyclexDI => unsigned(FirmwareLedColorPortsxD(C_RGB_LED_2_IDX).RegxD(15 downto 8)),
                    PwmxSO       => PwmGreen2xS);

            OBufGreenxB : block is
            begin  -- block OBufGreenxB

                OutBufLed1GxI : OBUF
                    generic map (
                        DRIVE      => 12,
                        IOSTANDARD => "DEFAULT",
                        SLEW       => "SLOW")
                    port map (
                        O => Led12V5GxSO,
                        I => PwmGreen1xS);

                OutBufLed2RxI : OBUF
                    generic map (
                        DRIVE      => 12,
                        IOSTANDARD => "DEFAULT",
                        SLEW       => "SLOW")
                    port map (
                        O => Led22V5GxSO,
                        I => PwmGreen2xS);

            end block OBufGreenxB;

            PwmBlue1xI : entity work.scalp_pwm
                generic map (
                    C_PWM_SIZE    => C_PWM_SIZE,
                    C_CLK_CNT_LEN => C_CLK_CNT_LEN)
                port map (
                    ClkxCI       => FirmwareIDAxixD.ClockxC.ClkxC,
                    RstxRANI     => FirmwareIDAxixD.ResetxR.RstxRAN,
                    DutyCyclexDI => unsigned(FirmwareLedColorPortsxD(C_RGB_LED_1_IDX).RegxD(7 downto 0)),
                    PwmxSO       => PwmBlue1xS);

            PwmBlue2xI : entity work.scalp_pwm
                generic map (
                    C_PWM_SIZE    => C_PWM_SIZE,
                    C_CLK_CNT_LEN => C_CLK_CNT_LEN)
                port map (
                    ClkxCI       => FirmwareIDAxixD.ClockxC.ClkxC,
                    RstxRANI     => FirmwareIDAxixD.ResetxR.RstxRAN,
                    DutyCyclexDI => unsigned(FirmwareLedColorPortsxD(C_RGB_LED_2_IDX).RegxD(7 downto 0)),
                    PwmxSO       => PwmBlue2xS);

            OBufBluexB : block is
            begin  -- block OBufBluexB

                OutBufLed1BxI : OBUF
                    generic map (
                        DRIVE      => 12,
                        IOSTANDARD => "DEFAULT",
                        SLEW       => "SLOW")
                    port map (
                        O => Led12V5BxSO,
                        I => PwmBlue1xS);

                OutBufLed2BxI : OBUF
                    generic map (
                        DRIVE      => 12,
                        IOSTANDARD => "DEFAULT",
                        SLEW       => "SLOW")
                    port map (
                        O => Led22V5BxSO,
                        I => PwmBlue2xS);

            end block OBufBluexB;

        end block PwmLedsxB;

        SwitchesxB : block is
        begin  -- block SwitchesxB

            InBufSwitchesxG : for i in 0 to (C_GPIO_SWITCHES_SIZE - 1) generate
                InBufSwitch0xI : IBUF
                    generic map (
                        IBUF_LOW_PWR => true,
                        IOSTANDARD   => "DEFAULT")
                    port map (
                        O => GPIOSwitchesxD(i),
                        I => SwitchesxDI(i));
            end generate InBufSwitchesxG;

        end block SwitchesxB;

        JoystickxB : block is
        begin  -- block JoystickxB

            InBufJoystickxG : for i in 0 to (C_GPIO_JOYSTICK_SIZE - 1) generate
                InBufJoystickIdxxI : IBUF
                    generic map (
                        IBUF_LOW_PWR => true,
                        IOSTANDARD   => "DEFAULT")
                    port map (
                        O => GPIOJoystickxD(i),
                        I => JoystickxDI(i));
            end generate InBufJoystickxG;

        end block JoystickxB;

        ScalpClpxNumRegsxI : entity work.scalp_cplx_num_regs
            generic map (
                C_REGS_ADDR_SIZE => C_REGS_ADDR_SIZE,
                C_NB_REGS_IN     => C_CPLX_NUM_REGS_NB_REGS_IN,
                C_NB_REGS_OUT    => C_CPLX_NUM_REGS_NB_REGS_OUT)
            port map (
                AxiSlvxDIO              => ClpxNumRegsAxixD,
                -- RegPortsxDI => ,
                RegPortsxDO(1 downto 0) => PatternPortsxD,
                RegPortsxDO(2)          => ZImInPortxD,
                RegPortsxDO(3)          => ZReInPortxD);

        HdmixB : block is
        begin  -- block HdmixB

            HdmiIOxB : block is
            begin  -- block HdmiIOxB

                -- In
                HpdxAS  : HdmiTxxD.InxD.HpdxS <= HdmiTXHpdxSI;
                -- InOut
                -- SdaxAS  : HdmiTXSdaxSIO       <= HdmiTxxD.InOutxD.SdaxS;
                CecxAS  : HdmiTXCecxSIO       <= HdmiTxxD.InOutxD.CecxS;
                -- Out
                -- SclxAS  : HdmiTXSclxSO        <= HdmiTxxD.OutxD.SclxS;
                ClkPxAS : HdmiTXClkPxSO       <= HdmiTxxD.OutxD.ClkxC.PxC;
                ClkNxAS : HdmiTXClkNxSO       <= HdmiTxxD.OutxD.ClkxC.NxC;

                HdmiDataLanesxG : for i in 0 to (C_HDMI_LANES - 1) generate
                    DataPxAS : HdmiTXPxDO(i) <= HdmiTxxD.OutxD.DataxD.PxD(i);
                    DataNxAS : HdmiTXNxDO(i) <= HdmiTxxD.OutxD.DataxD.NxD(i);
                end generate HdmiDataLanesxG;

            end block HdmiIOxB;

            TxxI : entity work.scalp_hdmi
                generic map (
                    C_VGA_CONFIG => C_VGA_720X720_60HZ_CONFIG)
                port map (
                    ClocksxCI         => HdmiVgaClocksxC,
                    VgaPixCountersxDO => VgaPixCountersxD,
                    PixelxDI          => PixelxD,
                    HdmiTxxDIO        => HdmiTxxD);

        end block HdmixB;

        ImGenxB : block is

            -- Constants
            constant C_CDC_TYPE     : integer range 0 to 2  := 1;
            constant C_RESET_STATE  : integer range 0 to 1  := 1;
            constant C_SINGLE_BIT   : integer range 0 to 1  := 0;
            constant C_FLOP_INPUT   : integer range 0 to 1  := 1;
            constant C_VECTOR_WIDTH : integer range 0 to 32 := 32;
            constant C_MTBF_STAGES  : integer range 0 to 6  := 2;

            constant C_AXI_CROSS_REGISTER : t_axi_register := (RegxD => x"00ffffff");
            constant C_AXI_BG_REGISTER    : t_axi_register := (RegxD => x"00ff0000");

            -- Signals
            signal CDCPatternPortsxD : t_axi_bunch_of_registers(1 downto 0) := (0 => C_AXI_BG_REGISTER,
                                                                                1 => C_AXI_CROSS_REGISTER);
            signal BramAddrxD : std_logic_vector(8 downto 0) := (others => '0');
            signal BramWexD   : std_logic_vector(3 downto 0) := (others => '1');

            -- Attributes
            attribute mark_debug : string;
            attribute keep       : string;

            -- attribute mark_debug of CDCPatternPortsxD : signal is "true";
            -- attribute keep of CDCPatternPortsxD       : signal is "true";
            -- attribute mark_debug of BramAddrxD        : signal is "true";
            -- attribute keep of BramAddrxD              : signal is "true";
            -- attribute mark_debug of BramWexD          : signal is "true";
            -- attribute keep of BramWexD                : signal is "true";

        begin  -- block ImGenxB

            BramSDPMacro1xI : BRAM_SDP_MACRO
                generic map (
                    BRAM_SIZE           => "18Kb",
                    DEVICE              => "7SERIES",
                    WRITE_WIDTH         => 32,
                    READ_WIDTH          => 32,
                    DO_REG              => 0,
                    INIT_FILE           => "NONE",
                    SIM_COLLISION_CHECK => "ALL",
                    SRVAL               => X"000000000000000000",
                    write_mode          => "WRITE_FIRST",
                    INIT                => X"000000000000000000")
                port map (
                    DO     => CDCPatternPortsxD(0).RegxD,
                    DI     => PatternPortsxD(0).RegxD,
                    RDADDR => BramAddrxD,
                    RDCLK  => HdmiVgaClocksxC.VgaxC,
                    RDEN   => '1',
                    REGCE  => '0',
                    RST    => '0',
                    WE     => BramWexD,
                    WRADDR => BramAddrxD,
                    WRCLK  => ClpxNumRegsAxixD.ClockxC.ClkxC,
                    WREN   => '1');

            BramSDPMacro2xI : BRAM_SDP_MACRO
                generic map (
                    BRAM_SIZE           => "18Kb",
                    DEVICE              => "7SERIES",
                    WRITE_WIDTH         => 32,
                    READ_WIDTH          => 32,
                    DO_REG              => 0,
                    INIT_FILE           => "NONE",
                    SIM_COLLISION_CHECK => "ALL",
                    SRVAL               => X"000000000000000000",
                    write_mode          => "WRITE_FIRST",
                    INIT                => X"000000000000000000")
                port map (
                    DO     => CDCPatternPortsxD(1).RegxD,
                    DI     => PatternPortsxD(1).RegxD,
                    RDADDR => BramAddrxD,
                    RDCLK  => HdmiVgaClocksxC.VgaxC,
                    RDEN   => '1',
                    REGCE  => '0',
                    RST    => '0',
                    WE     => BramWexD,
                    WRADDR => BramAddrxD,
                    WRCLK  => ClpxNumRegsAxixD.ClockxC.ClkxC,
                    WREN   => '1');

            SwissFlagxP : process (HdmiVgaClocksxC.PllLockedxS,
                                   HdmiVgaClocksxC.VgaResetxRNA,
                                   HdmiVgaClocksxC.VgaxC) is
            begin  -- process SwissFlagxP
                if (HdmiVgaClocksxC.PllLockedxS = '0') or (HdmiVgaClocksxC.VgaResetxRNA = '0') then
                    PixelxD <= C_HDMI_VGA_PIX_IDLE;
                elsif rising_edge(HdmiVgaClocksxC.VgaxC) then
                    if VgaPixCountersxD.VidOnxS = '1' then
                        PixelxD.RxD <= CDCPatternPortsxD(0).RegxD((C_VGA_PIXELS_SIZE - 1) downto (C_VGA_PIXEL_SIZE * 2));
                        PixelxD.GxD <= CDCPatternPortsxD(0).RegxD(((C_VGA_PIXEL_SIZE * 2) - 1) downto (C_VGA_PIXEL_SIZE));
                        PixelxD.BxD <= CDCPatternPortsxD(0).RegxD((C_VGA_PIXEL_SIZE - 1) downto 0);

                        if (to_integer(unsigned(VgaPixCountersxD.HxD)) >= 288) and
                            (to_integer(unsigned(VgaPixCountersxD.HxD)) < 432) then
                            if (to_integer(unsigned(VgaPixCountersxD.VxD)) >= 144) and
                                (to_integer(unsigned(VgaPixCountersxD.VxD)) < 576) then
                                PixelxD.RxD <= CDCPatternPortsxD(1).RegxD((C_VGA_PIXELS_SIZE - 1) downto (C_VGA_PIXEL_SIZE * 2));
                                PixelxD.GxD <= CDCPatternPortsxD(1).RegxD(((C_VGA_PIXEL_SIZE * 2) - 1) downto (C_VGA_PIXEL_SIZE));
                                PixelxD.BxD <= CDCPatternPortsxD(1).RegxD((C_VGA_PIXEL_SIZE - 1) downto 0);
                            end if;
                        end if;

                        if (to_integer(unsigned(VgaPixCountersxD.HxD)) >= 144) and
                            (to_integer(unsigned(VgaPixCountersxD.HxD)) < 576) then
                            if (to_integer(unsigned(VgaPixCountersxD.VxD)) >= 288) and
                                (to_integer(unsigned(VgaPixCountersxD.VxD)) < 432) then
                                PixelxD.RxD <= CDCPatternPortsxD(1).RegxD((C_VGA_PIXELS_SIZE - 1) downto (C_VGA_PIXEL_SIZE * 2));
                                PixelxD.GxD <= CDCPatternPortsxD(1).RegxD(((C_VGA_PIXEL_SIZE * 2) - 1) downto (C_VGA_PIXEL_SIZE));
                                PixelxD.BxD <= CDCPatternPortsxD(1).RegxD((C_VGA_PIXEL_SIZE - 1) downto 0);
                            end if;
                        end if;
                    else
                        PixelxD <= C_HDMI_VGA_PIX_IDLE;
                    end if;
                end if;
            end process SwissFlagxP;

        end block ImGenxB;

    end block PLxB;

end arch;
