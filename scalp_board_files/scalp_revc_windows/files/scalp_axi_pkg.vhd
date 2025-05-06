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
-- Module Name: scalp_axi_pkg - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: Package scalp_axi_pkg
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

package scalp_axi_pkg is

    -- Constants
    -- AXI
    constant C_AXI_WDATA_SIZE   : integer range 0 to 32                             := 32;
    constant C_AXI_ARADDR_SIZE  : integer range 0 to 32                             := 32;
    constant C_AXI_ARCACHE_SIZE : integer range 0 to 4                              := 4;
    constant C_AXI_ARPROT_SIZE  : integer range 0 to 3                              := 3;
    constant C_AXI_AWCACHE_SIZE : integer range 0 to 4                              := 4;
    constant C_AXI_AWPROT_SIZE  : integer range 0 to 3                              := 3;
    constant C_AXI_AWADDR_SIZE  : integer range 0 to 32                             := 32;
    constant C_AXI_WSTRB_SIZE   : integer range 0 to 4                              := 4;
    constant C_AXI_RRESP_SIZE   : integer range 0 to 2                              := 2;
    constant C_AXI_BRESP_SIZE   : integer range 0 to 2                              := 2;
    constant C_AXI_RDATA_SIZE   : integer range 0 to 32                             := 32;
    constant C_AXI_DATA_SIZE    : integer range 0 to 32                             := 32;
    constant C_AXI_ADDR_SIZE    : integer range 0 to 32                             := 32;
    constant C_AXI_BYTE_SIZE    : integer range 0 to 8                              := 8;
    -- RRESP
    constant C_AXI_RRESP_OKAY   : std_logic_vector((C_AXI_RRESP_SIZE - 1) downto 0) := "00";
    constant C_AXI_RRESP_EXOKAY : std_logic_vector((C_AXI_RRESP_SIZE - 1) downto 0) := "01";
    constant C_AXI_RRESP_SLVERR : std_logic_vector((C_AXI_RRESP_SIZE - 1) downto 0) := "10";
    constant C_AXI_RRESP_DECERR : std_logic_vector((C_AXI_RRESP_SIZE - 1) downto 0) := "11";
    -- BRESP
    constant C_AXI_BRESP_OKAY   : std_logic_vector((C_AXI_BRESP_SIZE - 1) downto 0) := "00";
    constant C_AXI_BRESP_EXOKAY : std_logic_vector((C_AXI_BRESP_SIZE - 1) downto 0) := "01";
    constant C_AXI_BRESP_SLVERR : std_logic_vector((C_AXI_BRESP_SIZE - 1) downto 0) := "10";
    constant C_AXI_BRESP_DECERR : std_logic_vector((C_AXI_BRESP_SIZE - 1) downto 0) := "11";

    type t_read_states is (C_READ_WAITING_ON_VALID_ADDR,
                           C_READ_WAITING_ON_HANDSHAKE,
                           C_READ_COMPLETE_TRANSACTION);

    type t_write_states is (C_WRITE_WAITING_ON_VALID_ADDR_DATA,
                            C_WRITE_WAITING_ON_HANDSHAKE,
                            C_WRITE_COMPLETE_TRANSACTION);

    ---------------------------------------------------------------------------
    -- Global signals
    ---------------------------------------------------------------------------
    type t_axi_clock_m2s is record
        ClkxC : std_logic;
    end record t_axi_clock_m2s;

    constant C_AXI_CLOCK_IDLE : t_axi_clock_m2s := (ClkxC => '0');

    type t_axi_reset_m2s is record
        RstxRAN : std_logic;
    end record t_axi_reset_m2s;

    constant C_AXI_ARESETN_IDLE : t_axi_reset_m2s := (RstxRAN => '1');

    ---------------------------------------------------------------------------
    -- Read address channel
    ---------------------------------------------------------------------------
    type t_axi_rac_m2s is record
        ARAddrxD  : std_logic_vector((C_AXI_ARADDR_SIZE - 1) downto 0);
        ARCachexD : std_logic_vector((C_AXI_ARCACHE_SIZE - 1) downto 0);
        ARProtxD  : std_logic_vector((C_AXI_ARPROT_SIZE - 1) downto 0);
        ARValidxS : std_logic;
    end record t_axi_rac_m2s;

    constant C_AXI_RAC_M2S_IDLE : t_axi_rac_m2s := (ARAddrxD  => (others => '0'),
                                                    ARCachexD => (others => '0'),
                                                    ARProtxD  => (others => '0'),
                                                    ARValidxS => '0');

    type t_axi_rac_s2m is record
        ARReadyxS : std_logic;
    end record t_axi_rac_s2m;

    constant C_AXI_RAC_S2M_IDLE : t_axi_rac_s2m := (ARReadyxS => '0');

    type t_axi_rac is record
        M2SxD : t_axi_rac_m2s;
        S2MxD : t_axi_rac_s2m;
    end record t_axi_rac;

    constant C_AXI_RAC_IDLE : t_axi_rac := (M2SxD => C_AXI_RAC_M2S_IDLE,
                                            S2MxD => C_AXI_RAC_S2M_IDLE);

    ---------------------------------------------------------------------------
    -- Read data channel
    ---------------------------------------------------------------------------
    type t_axi_rdc_m2s is record
        RReadyxS : std_logic;
    end record t_axi_rdc_m2s;

    constant C_AXI_RDC_M2S_IDLE : t_axi_rdc_m2s := (RReadyxS => '0');

    type t_axi_rdc_s2m is record
        RDataxD  : std_logic_vector((C_AXI_RDATA_SIZE - 1) downto 0);
        RRespxD  : std_logic_vector((C_AXI_RRESP_SIZE - 1) downto 0);
        RValidxS : std_logic;
    end record t_axi_rdc_s2m;

    constant C_AXI_RDC_S2M_IDLE : t_axi_rdc_s2m := (RDataxD  => (others => '0'),
                                                    RRespxD  => C_AXI_RRESP_OKAY,
                                                    RValidxS => '0');

    type t_axi_rdc is record
        M2SxD : t_axi_rdc_m2s;
        S2MxD : t_axi_rdc_s2m;
    end record t_axi_rdc;

    constant C_AXI_RDC_IDLE : t_axi_rdc := (M2SxD => C_AXI_RDC_M2S_IDLE,
                                            S2MxD => C_AXI_RDC_S2M_IDLE);

    ---------------------------------------------------------------------------
    -- Read channel
    ---------------------------------------------------------------------------
    type t_axi_rc is record
        AddrxD : t_axi_rac;
        DataxD : t_axi_rdc;
    end record t_axi_rc;

    constant C_AXI_RC_IDLE : t_axi_rc := (AddrxD => C_AXI_RAC_IDLE,
                                          DataxD => C_AXI_RDC_IDLE);

    ---------------------------------------------------------------------------
    -- Write address channel
    ---------------------------------------------------------------------------
    type t_axi_wac_m2s is record
        AWAddrxD  : std_logic_vector((C_AXI_AWADDR_SIZE - 1) downto 0);
        AWCachexD : std_logic_vector((C_AXI_AWCACHE_SIZE - 1) downto 0);
        AWProtxD  : std_logic_vector((C_AXI_AWPROT_SIZE - 1) downto 0);
        AWValidxS : std_logic;
    end record t_axi_wac_m2s;

    constant C_AXI_WAC_M2S_IDLE : t_axi_wac_m2s := (AWAddrxD  => (others => '0'),
                                                    AWCachexD => (others => '0'),
                                                    AWProtxD  => (others => '0'),
                                                    AWValidxS => '0');

    type t_axi_wac_s2m is record
        AWReadyxS : std_logic;
    end record t_axi_wac_s2m;

    constant C_AXI_WAC_S2M_IDLE : t_axi_wac_s2m := (AWReadyxS => '0');

    type t_axi_wac is record
        M2SxD : t_axi_wac_m2s;
        S2MxD : t_axi_wac_s2m;
    end record t_axi_wac;

    constant C_AXI_WAC_IDLE : t_axi_wac := (M2SxD => C_AXI_WAC_M2S_IDLE,
                                            S2MxD => C_AXI_WAC_S2M_IDLE);

    ---------------------------------------------------------------------------
    -- Write data channel
    ---------------------------------------------------------------------------
    type t_axi_wdc_m2s is record
        WDataxD  : std_logic_vector((C_AXI_WDATA_SIZE - 1) downto 0);
        WStrbxD  : std_logic_vector((C_AXI_WSTRB_SIZE - 1) downto 0);
        WValidxS : std_logic;
    end record t_axi_wdc_m2s;

    constant C_AXI_WDC_M2S_IDLE : t_axi_wdc_m2s := (WDataxD  => (others => '0'),
                                                    WStrbxD  => (others => '0'),
                                                    WValidxS => '0');

    type t_axi_wdc_s2m is record
        WReadyxS : std_logic;
    end record t_axi_wdc_s2m;

    constant C_AXI_WDC_S2M_IDLE : t_axi_wdc_s2m := (WReadyxS => '0');

    type t_axi_wdc is record
        M2SxD : t_axi_wdc_m2s;
        S2MxD : t_axi_wdc_s2m;
    end record t_axi_wdc;

    constant C_AXI_WDC_IDLE : t_axi_wdc := (M2SxD => C_AXI_WDC_M2S_IDLE,
                                            S2MxD => C_AXI_WDC_S2M_IDLE);

    ---------------------------------------------------------------------------
    -- Write response channel
    ---------------------------------------------------------------------------
    type t_axi_wrc_m2s is record
        BReadyxS : std_logic;
    end record t_axi_wrc_m2s;

    constant C_AXI_WRC_M2S_IDLE : t_axi_wrc_m2s := (BReadyxS => '0');

    type t_axi_wrc_s2m is record
        BRespxD  : std_logic_vector((C_AXI_BRESP_SIZE - 1) downto 0);
        BValidxS : std_logic;
    end record t_axi_wrc_s2m;

    constant C_AXI_WRC_S2M_IDLE : t_axi_wrc_s2m := (BRespxD  => C_AXI_BRESP_OKAY,
                                                    BValidxS => '0');

    type t_axi_wrc is record
        M2SxD : t_axi_wrc_m2s;
        S2MxD : t_axi_wrc_s2m;
    end record t_axi_wrc;

    constant C_AXI_WRC_IDLE : t_axi_wrc := (M2SxD => C_AXI_WRC_M2S_IDLE,
                                            S2MxD => C_AXI_WRC_S2M_IDLE);

    ---------------------------------------------------------------------------
    -- Write channel
    ---------------------------------------------------------------------------
    type t_axi_wc is record
        AddrxD : t_axi_wac;
        DataxD : t_axi_wdc;
        RespxD : t_axi_wrc;
    end record t_axi_wc;

    constant C_AXI_WC_IDLE : t_axi_wc := (AddrxD => C_AXI_WAC_IDLE,
                                          DataxD => C_AXI_WDC_IDLE,
                                          RespxD => C_AXI_WRC_IDLE);

    ---------------------------------------------------------------------------
    -- Axi Lite interface
    ---------------------------------------------------------------------------
    type t_axi_lite is record
        ClockxC : t_axi_clock_m2s;
        ResetxR : t_axi_reset_m2s;
        RdxD    : t_axi_rc;
        WrxD    : t_axi_wc;
    end record t_axi_lite;

    constant C_AXI_LITE_IDLE : t_axi_lite := (ClockxC => C_AXI_CLOCK_IDLE,
                                              ResetxR => C_AXI_ARESETN_IDLE,
                                              RdxD    => C_AXI_RC_IDLE,
                                              WrxD    => C_AXI_WC_IDLE);

    ---------------------------------------------------------------------------
    -- Axi write handshakes
    ---------------------------------------------------------------------------
    type t_axi_write_handshakes is record
        AddressxS : std_logic;
        DataxS    : std_logic;
    end record t_axi_write_handshakes;

    constant C_AXI_WRITE_HANDSHAKES_IDLE : t_axi_write_handshakes := (AddressxS => '0',
                                                                      DataxS    => '0');

    ---------------------------------------------------------------------------
    -- Axi register and bunch of registers
    ---------------------------------------------------------------------------
    type t_axi_register is record
        RegxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0);
    end record t_axi_register;

    constant C_AXI_REGISTER_IDLE : t_axi_register := (RegxD => (others => '0'));

    type t_axi_bunch_of_registers is array (natural range <>) of t_axi_register;

    ---------------------------------------------------------------------------
    -- Control signals for reading from and writing to the register file.
    ---------------------------------------------------------------------------
    type t_axi_read_ctrl_regfile_ms2 is record
        RdAddrxD  : std_logic_vector((C_AXI_ADDR_SIZE - 1) downto 0);
        RdValidxS : std_logic;
    end record t_axi_read_ctrl_regfile_m2s;

    type t_axi_read_ctrl_regfile_s2m is record
        RdDataxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0);
    end record t_axi_read_ctrl_regfile_s2m;

    constant C_AXI_READ_CTRL_REGFILE_M2S_IDLE : t_axi_read_ctrl_regfile_ms2 := (RdAddrxD  => (others => '0'),
                                                                                RdValidxS => '0');

    constant C_AXI_READ_CTRL_REGFILE_S2M_IDLE : t_axi_read_ctrl_regfile_s2m := (RdDataxD => (others => '0'));

    type t_axi_write_ctrl_regfile_ms2 is record
        WrAddrxD  : std_logic_vector((C_AXI_ADDR_SIZE - 1) downto 0);
        WrDataxD  : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0);
        WrStrbxD  : std_logic_vector((C_AXI_WSTRB_SIZE - 1) downto 0);
        WrValidxS : std_logic;
    end record t_axi_write_ctrl_regfile_ms2;

    constant C_AXI_WRITE_CTRL_REGFILE_M2S_IDLE : t_axi_write_ctrl_regfile_ms2 := (WrAddrxD  => (others => '0'),
                                                                                  WrDataxD  => (others => '0'),
                                                                                  WrStrbxD  => (others => '0'),
                                                                                  WrValidxS => '0');

    ---------------------------------------------------------------------------
    -- Functions
    ---------------------------------------------------------------------------
    -- purpose: Apply a bit mask to preserve only valid bytes.
    function axi_wr_valid_bytes (
        signal WDataxD    : std_logic_vector((C_AXI_WDATA_SIZE - 1) downto 0);
        signal WStrbxD    : std_logic_vector((C_AXI_WSTRB_SIZE - 1) downto 0);
        signal RegisterxD : t_axi_register)
        return t_axi_register;

    -- purpose: Perform a set bit operation
    function axi_set_bit (
        signal VectxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0);
        signal MaskxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0))
        return std_logic_vector;

    -- purpose: Perform a clear bit operation
    function axi_clear_bit (
        signal VectxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0);
        signal MaskxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0))
        return std_logic_vector;

    -- purpose: Perform a toggle bit operation
    function axi_toggle_bit (
        signal VectxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0);
        signal MaskxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0))
        return std_logic_vector;

end scalp_axi_pkg;

package body scalp_axi_pkg is

    -- purpose: Apply a bit mask to preserve only valid bytes.
    function axi_wr_valid_bytes (
        signal WDataxD    : std_logic_vector((C_AXI_WDATA_SIZE - 1) downto 0);
        signal WStrbxD    : std_logic_vector((C_AXI_WSTRB_SIZE - 1) downto 0);
        signal RegisterxD : t_axi_register)
        return t_axi_register is
        variable MaskedRegisterxD : t_axi_register := C_AXI_REGISTER_IDLE;
    begin  -- function axi_wr_valid_bytes
        for i in 0 to (C_AXI_WSTRB_SIZE - 1) loop
            if WStrbxD(i) = '1' then
                MaskedRegisterxD.RegxD((((i + 1) * C_AXI_BYTE_SIZE) - 1) downto (i * (C_AXI_BYTE_SIZE))) :=
                    WDataxD((((i + 1) * C_AXI_BYTE_SIZE) - 1) downto (i * (C_AXI_BYTE_SIZE)));
            else
                MaskedRegisterxD.RegxD((((i + 1) * C_AXI_BYTE_SIZE) - 1) downto (i * (C_AXI_BYTE_SIZE))) :=
                    RegisterxD.RegxD((((i + 1) * C_AXI_BYTE_SIZE) - 1) downto (i * (C_AXI_BYTE_SIZE)));
            end if;
        end loop;  -- i

        return MaskedRegisterxD;
    end function axi_wr_valid_bytes;

    -- purpose: Perform a set bit operation
    function axi_set_bit (
        signal VectxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0);
        signal MaskxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0))
        return std_logic_vector is
    begin  -- function axi_set_bit
        return VectxD or MaskxD;
    end function axi_set_bit;

    -- purpose: Perform a clear bit operation
    function axi_clear_bit (
        signal VectxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0);
        signal MaskxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0))
        return std_logic_vector is
    begin  -- function axi_clear_bit
        return VectxD and not(MaskxD);
    end function axi_clear_bit;

    -- purpose: Perform a toggle bit operation
    function axi_toggle_bit (
        signal VectxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0);
        signal MaskxD : std_logic_vector((C_AXI_DATA_SIZE - 1) downto 0))
        return std_logic_vector is
    begin  -- function axi_toggle_bit
        return VectxD xor MaskxD;
    end function axi_toggle_bit;

end scalp_axi_pkg;
