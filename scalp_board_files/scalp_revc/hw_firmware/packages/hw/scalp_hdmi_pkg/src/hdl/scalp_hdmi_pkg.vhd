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
-- Module Name: scalp_hdmi_pkg - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: Package scalp_hdmi_pkg
--
-- Last update: 2024-03-26
--
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use ieee.std_logic_unsigned.all;
-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_misc.all;

package scalp_hdmi_pkg is

    -- Constants
    -- HDMI
    constant C_HDMI_LANES             : integer range 0 to 3                                      := 3;
    constant C_HDMI_CHANNELS          : integer range 0 to 4                                      := C_HDMI_LANES + 1;
    constant C_HDMI_LATENCY           : integer                                                   := 0;
    -- VGA
    constant C_VGA_HV_COUNT_SIZE      : integer                                                   := 16;
    constant C_VGA_PIXEL_SIZE         : integer                                                   := 8;
    constant C_VGA_PIXELS_SIZE        : integer                                                   := C_VGA_PIXEL_SIZE * 3;
    -- TMDS encoder
    constant C_TMDS_DATA_SIZE         : integer                                                   := 8;
    constant C_TMDS_ENCODED_DATA_SIZE : integer                                                   := 10;
    constant C_TMDS_ENCODED_DATA_CLK  : std_logic_vector((C_TMDS_ENCODED_DATA_SIZE - 1) downto 0) := "0000011111";

    ---------------------------------------------------------------------------
    -- VGA 720x720 @ 60 Hz - Pixel clock = 48 MHz / Hdmi clock = 240 MHz
    ---------------------------------------------------------------------------
    ---------------------------------------------------------------------------
    -- hdmi_timings=720 0 100 20 100 720 0 20 8 20 0 0 0 60 0 48000000 6
    -- hdmi_timings=
    -- h_active_pixels = 720
    -- h_sync_polarity = 0
    -- h_front_porch   = 100
    -- h_sync_pulse    = 20
    -- h_back_porch    = 100
    -- v_active_lines  = 720
    -- v_sync_polarity = 0
    -- v_front_porch   = 20
    -- v_sync_pulse    = 8
    -- v_back_porch    = 20
    -- v_sync_offset_a = 0
    -- v_sync_offset_b = 0
    -- pixel_rep       = 0
    -- frame_rate      = 60
    -- interlaced      = 0
    -- pixel_freq      = 48
    -- aspect_ratio    = 6
    ---------------------------------------------------------------------------
    constant C_VGA_720X720_60HZ_H_ACTIVE      : integer := 720;
    constant C_VGA_720X720_60HZ_V_ACTIVE      : integer := 720;
    constant C_VGA_720X720_60HZ_H_FRONT_PORCH : integer := 100;
    constant C_VGA_720X720_60HZ_H_BACK_PORCH  : integer := 100;
    constant C_VGA_720X720_60HZ_V_FRONT_PORCH : integer := 20;
    constant C_VGA_720X720_60HZ_V_BACK_PORCH  : integer := 20;
    constant C_VGA_720X720_60HZ_H_SYNC_LEN    : integer := 20;
    constant C_VGA_720X720_60HZ_V_SYNC_LEN    : integer := 8;
    constant C_VGA_720X720_60HZ_H_SYNC_ACTIVE : integer := 0;
    constant C_VGA_720X720_60HZ_V_SYNC_ACTIVE : integer := 0;

    constant C_VGA_720X720_60HZ_H_LEN : integer := C_VGA_720X720_60HZ_H_ACTIVE +
                                                   C_VGA_720X720_60HZ_H_FRONT_PORCH +
                                                   C_VGA_720X720_60HZ_H_BACK_PORCH +
                                                   C_VGA_720X720_60HZ_H_SYNC_LEN;
    constant C_VGA_720X720_60HZ_V_LEN : integer := C_VGA_720X720_60HZ_V_ACTIVE +
                                                   C_VGA_720X720_60HZ_V_FRONT_PORCH +
                                                   C_VGA_720X720_60HZ_V_BACK_PORCH +
                                                   C_VGA_720X720_60HZ_V_SYNC_LEN;

    ---------------------------------------------------------------------------
    -- VGA 800x600 @ 60 Hz - Pixel clock = 40 MHz / Hdmi clock = 200 MHz
    ---------------------------------------------------------------------------
    constant C_VGA_800X600_60HZ_H_ACTIVE      : integer := 800;
    constant C_VGA_800X600_60HZ_V_ACTIVE      : integer := 600;
    constant C_VGA_800X600_60HZ_H_FRONT_PORCH : integer := 40;
    constant C_VGA_800X600_60HZ_H_BACK_PORCH  : integer := 88;
    constant C_VGA_800X600_60HZ_V_FRONT_PORCH : integer := 1;
    constant C_VGA_800X600_60HZ_V_BACK_PORCH  : integer := 23;
    constant C_VGA_800X600_60HZ_H_SYNC_LEN    : integer := 128;
    constant C_VGA_800X600_60HZ_V_SYNC_LEN    : integer := 4;
    constant C_VGA_800X600_60HZ_H_SYNC_ACTIVE : integer := 0;
    constant C_VGA_800X600_60HZ_V_SYNC_ACTIVE : integer := 0;

    constant C_VGA_800X600_60HZ_H_LEN : integer := C_VGA_800X600_60HZ_H_ACTIVE +
                                                   C_VGA_800X600_60HZ_H_FRONT_PORCH +
                                                   C_VGA_800X600_60HZ_H_BACK_PORCH +
                                                   C_VGA_800X600_60HZ_H_SYNC_LEN;
    constant C_VGA_800X600_60HZ_V_LEN : integer := C_VGA_800X600_60HZ_V_ACTIVE +
                                                   C_VGA_800X600_60HZ_V_FRONT_PORCH +
                                                   C_VGA_800X600_60HZ_V_BACK_PORCH +
                                                   C_VGA_800X600_60HZ_V_SYNC_LEN;

    ---------------------------------------------------------------------------
    -- VGA 1024x600 @ 60 Hz - Pixel clock = 51.250 MHz / Hdmi clock = 256.250 MHz
    ---------------------------------------------------------------------------
    constant C_VGA_1024X600_60HZ_H_ACTIVE      : integer := 1024;
    constant C_VGA_1024X600_60HZ_V_ACTIVE      : integer := 600;
    constant C_VGA_1024X600_60HZ_H_FRONT_PORCH : integer := 160;
    constant C_VGA_1024X600_60HZ_H_BACK_PORCH  : integer := 140;
    constant C_VGA_1024X600_60HZ_V_FRONT_PORCH : integer := 12;
    constant C_VGA_1024X600_60HZ_V_BACK_PORCH  : integer := 20;
    constant C_VGA_1024X600_60HZ_H_SYNC_LEN    : integer := 20;
    constant C_VGA_1024X600_60HZ_V_SYNC_LEN    : integer := 3;
    constant C_VGA_1024X600_60HZ_H_SYNC_ACTIVE : integer := 0;
    constant C_VGA_1024X600_60HZ_V_SYNC_ACTIVE : integer := 0;

    constant C_VGA_1024X600_60HZ_H_LEN : integer := C_VGA_1024X600_60HZ_H_ACTIVE +
                                                    C_VGA_1024X600_60HZ_H_FRONT_PORCH +
                                                    C_VGA_1024X600_60HZ_H_BACK_PORCH +
                                                    C_VGA_1024X600_60HZ_H_SYNC_LEN;
    constant C_VGA_1024X600_60HZ_V_LEN : integer := C_VGA_1024X600_60HZ_V_ACTIVE +
                                                    C_VGA_1024X600_60HZ_V_FRONT_PORCH +
                                                    C_VGA_1024X600_60HZ_V_BACK_PORCH +
                                                    C_VGA_1024X600_60HZ_V_SYNC_LEN;

    ---------------------------------------------------------------------------
    -- VGA 1024x768 @ 60 Hz - Pixel clock = 65 MHz / Hdmi clock = 325 MHz
    ---------------------------------------------------------------------------
    constant C_VGA_1024X768_60HZ_H_ACTIVE      : integer := 1024;
    constant C_VGA_1024X768_60HZ_V_ACTIVE      : integer := 768;
    constant C_VGA_1024X768_60HZ_H_FRONT_PORCH : integer := 24;
    constant C_VGA_1024X768_60HZ_H_BACK_PORCH  : integer := 160;
    constant C_VGA_1024X768_60HZ_V_FRONT_PORCH : integer := 3;
    constant C_VGA_1024X768_60HZ_V_BACK_PORCH  : integer := 29;
    constant C_VGA_1024X768_60HZ_H_SYNC_LEN    : integer := 136;
    constant C_VGA_1024X768_60HZ_V_SYNC_LEN    : integer := 6;
    constant C_VGA_1024X768_60HZ_H_SYNC_ACTIVE : integer := 0;
    constant C_VGA_1024X768_60HZ_V_SYNC_ACTIVE : integer := 0;

    constant C_VGA_1024X768_60HZ_H_LEN : integer := C_VGA_1024X768_60HZ_H_ACTIVE +
                                                    C_VGA_1024X768_60HZ_H_FRONT_PORCH +
                                                    C_VGA_1024X768_60HZ_H_BACK_PORCH +
                                                    C_VGA_1024X768_60HZ_H_SYNC_LEN;
    constant C_VGA_1024X768_60HZ_V_LEN : integer := C_VGA_1024X768_60HZ_V_ACTIVE +
                                                    C_VGA_1024X768_60HZ_V_FRONT_PORCH +
                                                    C_VGA_1024X768_60HZ_V_BACK_PORCH +
                                                    C_VGA_1024X768_60HZ_V_SYNC_LEN;

    ---------------------------------------------------------------------------
    -- If you intend to use a different resolution, please consult the following website.
    -- https://tomverbeure.github.io/video_timings_calculator
    ---------------------------------------------------------------------------

    type t_vga_config is record
        HActivexD     : unsigned((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        VActivexD     : unsigned((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        HFrontPorchxD : unsigned((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        HBackPorchxD  : unsigned((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        VFrontPorchxD : unsigned((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        VBackPorchxD  : unsigned((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        HSyncLenxD    : unsigned((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        VSyncLenxD    : unsigned((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        HLenxD        : unsigned((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        VLenxD        : unsigned((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        HSyncActivexD : unsigned((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        VSyncActivexD : unsigned((C_VGA_HV_COUNT_SIZE - 1) downto 0);
    end record t_vga_config;

    constant C_VGA_CONFIG_IDLE : t_vga_config := (HActivexD     => (others => '0'),
                                                  VActivexD     => (others => '0'),
                                                  HFrontPorchxD => (others => '0'),
                                                  HBackPorchxD  => (others => '0'),
                                                  VFrontPorchxD => (others => '0'),
                                                  VBackPorchxD  => (others => '0'),
                                                  HSyncLenxD    => (others => '0'),
                                                  VSyncLenxD    => (others => '0'),
                                                  HLenxD        => (others => '0'),
                                                  VLenxD        => (others => '0'),
                                                  HSyncActivexD => (others => '0'),
                                                  VSyncActivexD => (others => '0'));

    constant C_VGA_720X720_60HZ_CONFIG : t_vga_config := (HActivexD     => to_unsigned(C_VGA_720X720_60HZ_H_ACTIVE, C_VGA_HV_COUNT_SIZE),
                                                          VActivexD     => to_unsigned(C_VGA_720X720_60HZ_V_ACTIVE, C_VGA_HV_COUNT_SIZE),
                                                          HFrontPorchxD => to_unsigned(C_VGA_720X720_60HZ_H_FRONT_PORCH, C_VGA_HV_COUNT_SIZE),
                                                          HBackPorchxD  => to_unsigned(C_VGA_720X720_60HZ_H_BACK_PORCH, C_VGA_HV_COUNT_SIZE),
                                                          VFrontPorchxD => to_unsigned(C_VGA_720X720_60HZ_V_FRONT_PORCH, C_VGA_HV_COUNT_SIZE),
                                                          VBackPorchxD  => to_unsigned(C_VGA_720X720_60HZ_V_BACK_PORCH, C_VGA_HV_COUNT_SIZE),
                                                          HSyncLenxD    => to_unsigned(C_VGA_720X720_60HZ_H_SYNC_LEN, C_VGA_HV_COUNT_SIZE),
                                                          VSyncLenxD    => to_unsigned(C_VGA_720X720_60HZ_V_SYNC_LEN, C_VGA_HV_COUNT_SIZE),
                                                          HLenxD        => to_unsigned(C_VGA_720X720_60HZ_H_LEN, C_VGA_HV_COUNT_SIZE),
                                                          VLenxD        => to_unsigned(C_VGA_720X720_60HZ_V_LEN, C_VGA_HV_COUNT_SIZE),
                                                          HSyncActivexD => to_unsigned(C_VGA_720X720_60HZ_H_SYNC_ACTIVE, C_VGA_HV_COUNT_SIZE),
                                                          VSyncActivexD => to_unsigned(C_VGA_720X720_60HZ_V_SYNC_ACTIVE, C_VGA_HV_COUNT_SIZE));

    constant C_VGA_800X600_60HZ_CONFIG : t_vga_config := (HActivexD     => to_unsigned(C_VGA_800X600_60HZ_H_ACTIVE, C_VGA_HV_COUNT_SIZE),
                                                          VActivexD     => to_unsigned(C_VGA_800X600_60HZ_V_ACTIVE, C_VGA_HV_COUNT_SIZE),
                                                          HFrontPorchxD => to_unsigned(C_VGA_800X600_60HZ_H_FRONT_PORCH, C_VGA_HV_COUNT_SIZE),
                                                          HBackPorchxD  => to_unsigned(C_VGA_800X600_60HZ_H_BACK_PORCH, C_VGA_HV_COUNT_SIZE),
                                                          VFrontPorchxD => to_unsigned(C_VGA_800X600_60HZ_V_FRONT_PORCH, C_VGA_HV_COUNT_SIZE),
                                                          VBackPorchxD  => to_unsigned(C_VGA_800X600_60HZ_V_BACK_PORCH, C_VGA_HV_COUNT_SIZE),
                                                          HSyncLenxD    => to_unsigned(C_VGA_800X600_60HZ_H_SYNC_LEN, C_VGA_HV_COUNT_SIZE),
                                                          VSyncLenxD    => to_unsigned(C_VGA_800X600_60HZ_V_SYNC_LEN, C_VGA_HV_COUNT_SIZE),
                                                          HLenxD        => to_unsigned(C_VGA_800X600_60HZ_H_LEN, C_VGA_HV_COUNT_SIZE),
                                                          VLenxD        => to_unsigned(C_VGA_800X600_60HZ_V_LEN, C_VGA_HV_COUNT_SIZE),
                                                          HSyncActivexD => to_unsigned(C_VGA_800X600_60HZ_H_SYNC_ACTIVE, C_VGA_HV_COUNT_SIZE),
                                                          VSyncActivexD => to_unsigned(C_VGA_800X600_60HZ_V_SYNC_ACTIVE, C_VGA_HV_COUNT_SIZE));

    constant C_VGA_1024X600_60HZ_CONFIG : t_vga_config := (HActivexD     => to_unsigned(C_VGA_1024X600_60HZ_H_ACTIVE, C_VGA_HV_COUNT_SIZE),
                                                           VActivexD     => to_unsigned(C_VGA_1024X600_60HZ_V_ACTIVE, C_VGA_HV_COUNT_SIZE),
                                                           HFrontPorchxD => to_unsigned(C_VGA_1024X600_60HZ_H_FRONT_PORCH, C_VGA_HV_COUNT_SIZE),
                                                           HBackPorchxD  => to_unsigned(C_VGA_1024X600_60HZ_H_BACK_PORCH, C_VGA_HV_COUNT_SIZE),
                                                           VFrontPorchxD => to_unsigned(C_VGA_1024X600_60HZ_V_FRONT_PORCH, C_VGA_HV_COUNT_SIZE),
                                                           VBackPorchxD  => to_unsigned(C_VGA_1024X600_60HZ_V_BACK_PORCH, C_VGA_HV_COUNT_SIZE),
                                                           HSyncLenxD    => to_unsigned(C_VGA_1024X600_60HZ_H_SYNC_LEN, C_VGA_HV_COUNT_SIZE),
                                                           VSyncLenxD    => to_unsigned(C_VGA_1024X600_60HZ_V_SYNC_LEN, C_VGA_HV_COUNT_SIZE),
                                                           HLenxD        => to_unsigned(C_VGA_1024X600_60HZ_H_LEN, C_VGA_HV_COUNT_SIZE),
                                                           VLenxD        => to_unsigned(C_VGA_1024X600_60HZ_V_LEN, C_VGA_HV_COUNT_SIZE),
                                                           HSyncActivexD => to_unsigned(C_VGA_1024X600_60HZ_H_SYNC_ACTIVE, C_VGA_HV_COUNT_SIZE),
                                                           VSyncActivexD => to_unsigned(C_VGA_1024X600_60HZ_V_SYNC_ACTIVE, C_VGA_HV_COUNT_SIZE));

    constant C_VGA_1024X768_60HZ_CONFIG : t_vga_config := (HActivexD     => to_unsigned(C_VGA_1024X768_60HZ_H_ACTIVE, C_VGA_HV_COUNT_SIZE),
                                                           VActivexD     => to_unsigned(C_VGA_1024X768_60HZ_V_ACTIVE, C_VGA_HV_COUNT_SIZE),
                                                           HFrontPorchxD => to_unsigned(C_VGA_1024X768_60HZ_H_FRONT_PORCH, C_VGA_HV_COUNT_SIZE),
                                                           HBackPorchxD  => to_unsigned(C_VGA_1024X768_60HZ_H_BACK_PORCH, C_VGA_HV_COUNT_SIZE),
                                                           VFrontPorchxD => to_unsigned(C_VGA_1024X768_60HZ_V_FRONT_PORCH, C_VGA_HV_COUNT_SIZE),
                                                           VBackPorchxD  => to_unsigned(C_VGA_1024X768_60HZ_V_BACK_PORCH, C_VGA_HV_COUNT_SIZE),
                                                           HSyncLenxD    => to_unsigned(C_VGA_1024X768_60HZ_H_SYNC_LEN, C_VGA_HV_COUNT_SIZE),
                                                           VSyncLenxD    => to_unsigned(C_VGA_1024X768_60HZ_V_SYNC_LEN, C_VGA_HV_COUNT_SIZE),
                                                           HLenxD        => to_unsigned(C_VGA_1024X768_60HZ_H_LEN, C_VGA_HV_COUNT_SIZE),
                                                           VLenxD        => to_unsigned(C_VGA_1024X768_60HZ_V_LEN, C_VGA_HV_COUNT_SIZE),
                                                           HSyncActivexD => to_unsigned(C_VGA_1024X768_60HZ_H_SYNC_ACTIVE, C_VGA_HV_COUNT_SIZE),
                                                           VSyncActivexD => to_unsigned(C_VGA_1024X768_60HZ_V_SYNC_ACTIVE, C_VGA_HV_COUNT_SIZE));

    constant C_VGA_DEFAULT_CONFIG : t_vga_config := C_VGA_720X720_60HZ_CONFIG;

    type t_hdmi_tx_i is record
        HpdxS : std_logic;
    end record t_hdmi_tx_i;

    constant C_HDMI_TX_I_IDLE : t_hdmi_tx_i := (HpdxS => '0');

    type t_hdmi_tx_diff_clock is record
        PxC : std_logic;
        NxC : std_logic;
    end record t_hdmi_tx_diff_clock;

    constant C_HDMI_TX_DIFF_CLOCK_IDLE : t_hdmi_tx_diff_clock := (PxC => '0',
                                                                  NxC => '0');

    type t_hdmi_tx_diff_data is record
        PxD : std_logic_vector((C_HDMI_LANES - 1) downto 0);
        NxD : std_logic_vector((C_HDMI_LANES - 1) downto 0);
    end record t_hdmi_tx_diff_data;

    constant C_HDMI_TX_DIFF_DATA_IDLE : t_hdmi_tx_diff_data := (PxD => (others => '0'),
                                                                NxD => (others => '0'));

    type t_hdmi_tx_o is record
        ClkxC  : t_hdmi_tx_diff_clock;
        DataxD : t_hdmi_tx_diff_data;
        SclxS  : std_logic;
    end record t_hdmi_tx_o;

    constant C_HDMI_TX_O_IDLE : t_hdmi_tx_o := (ClkxC  => C_HDMI_TX_DIFF_CLOCK_IDLE,
                                                DataxD => C_HDMI_TX_DIFF_DATA_IDLE,
                                                SclxS  => '0');

    type t_hdmi_tx_io is record
        SdaxS : std_logic;
        CecxS : std_logic;
    end record t_hdmi_tx_io;

    constant C_HDMI_TX_IO_IDLE : t_hdmi_tx_io := (SdaxS => '0',
                                                  CecxS => '0');

    type t_hdmi_tx is record
        InxD    : t_hdmi_tx_i;
        OutxD   : t_hdmi_tx_o;
        InOutxD : t_hdmi_tx_io;
    end record t_hdmi_tx;

    constant C_HDMI_TX_IDLE : t_hdmi_tx := (InxD    => C_HDMI_TX_I_IDLE,
                                            OutxD   => C_HDMI_TX_O_IDLE,
                                            InOutxD => C_HDMI_TX_IO_IDLE);

    type t_hdmi_vga_clocks is record
        VgaxC         : std_logic;
        HdmixC        : std_logic;
        VgaResetxR    : std_logic;
        VgaResetxRNA  : std_logic;
        HdmiResetxR   : std_logic;
        HdmiResetxRNA : std_logic;
        PllLockedxS   : std_logic;
    end record t_hdmi_vga_clocks;

    constant C_HDMI_VGA_CLOCKS_IDLE : t_hdmi_vga_clocks := (VgaxC         => '0',
                                                            HdmixC        => '0',
                                                            VgaResetxR    => '1',
                                                            VgaResetxRNA  => '0',
                                                            HdmiResetxR   => '1',
                                                            HdmiResetxRNA => '0',
                                                            PllLockedxS   => '0');

    type t_hdmi_vga_pix_counters is record
        HxD     : std_logic_vector((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        VxD     : std_logic_vector((C_VGA_HV_COUNT_SIZE - 1) downto 0);
        VidOnxS : std_logic;
    end record t_hdmi_vga_pix_counters;

    constant C_HDMI_VGA_PIX_COUNTERS_IDLE : t_hdmi_vga_pix_counters := (HxD     => (others => '0'),
                                                                        VxD     => (others => '0'),
                                                                        VidOnxS => '0');

    constant C_HDMI_VGA_PIX_H_COUNTER_IDLE : std_logic_vector((C_VGA_HV_COUNT_SIZE - 1) downto 0) := (others => '0');
    constant C_HDMI_VGA_PIX_V_COUNTER_IDLE : std_logic_vector((C_VGA_HV_COUNT_SIZE - 1) downto 0) := (others => '0');

    type t_hdmi_vga_sync is record
        HxS : std_logic;
        VxS : std_logic;
    end record t_hdmi_vga_sync;

    constant C_HDMI_VGA_SYNC_IDLE : t_hdmi_vga_sync := (HxS => '0',
                                                        VxS => '0');
    constant C_HDMI_VGA_SYNC_SET : t_hdmi_vga_sync := (HxS => '1',
                                                       VxS => '1');

    type t_hdmi_vga_pix is record
        RxD : std_logic_vector((C_VGA_PIXEL_SIZE - 1) downto 0);
        GxD : std_logic_vector((C_VGA_PIXEL_SIZE - 1) downto 0);
        BxD : std_logic_vector((C_VGA_PIXEL_SIZE - 1) downto 0);
    end record t_hdmi_vga_pix;

    constant C_HDMI_VGA_PIX_IDLE    : t_hdmi_vga_pix := (RxD => (others => '0'), GxD => (others => '0'), BxD => (others => '0'));
    constant C_HDMI_VGA_PIX_BLACK   : t_hdmi_vga_pix := C_HDMI_VGA_PIX_IDLE;
    constant C_HDMI_VGA_PIX_RED     : t_hdmi_vga_pix := (RxD => x"ff", GxD => x"00", BxD => x"00");
    constant C_HDMI_VGA_PIX_GREEN   : t_hdmi_vga_pix := (RxD => x"00", GxD => x"ff", BxD => x"00");
    constant C_HDMI_VGA_PIX_BLUE    : t_hdmi_vga_pix := (RxD => x"00", GxD => x"00", BxD => x"ff");
    constant C_HDMI_VGA_PIX_YELLOW  : t_hdmi_vga_pix := (RxD => x"eb", GxD => x"d8", BxD => x"34");
    constant C_HDMI_VGA_PIX_MAGENTA : t_hdmi_vga_pix := (RxD => x"ff", GxD => x"00", BxD => x"ff");
    constant C_HDMI_VGA_PIX_CYAN    : t_hdmi_vga_pix := (RxD => x"00", GxD => x"ff", BxD => x"ff");
    constant C_HDMI_VGA_PIX_GRAY    : t_hdmi_vga_pix := (RxD => x"60", GxD => x"60", BxD => x"60");
    constant C_HDMI_VGA_PIX_WHITE   : t_hdmi_vga_pix := (RxD => x"ff", GxD => x"ff", BxD => x"ff");

    type t_hdmi_vga is record
        SyncxS  : t_hdmi_vga_sync;
        PixelxD : t_hdmi_vga_pix;
    end record t_hdmi_vga;

    constant C_HDMI_VGA_IDLE : t_hdmi_vga := (SyncxS  => C_HDMI_VGA_SYNC_IDLE,
                                              PixelxD => C_HDMI_VGA_PIX_IDLE);

end scalp_hdmi_pkg;

package body scalp_hdmi_pkg is

end scalp_hdmi_pkg;
