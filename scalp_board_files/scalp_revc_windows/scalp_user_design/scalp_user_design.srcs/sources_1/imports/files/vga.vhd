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
-- Module Name: vga - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: vga
--
-- Last update: 2024-03-20
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
use scalp_lib.scalp_hdmi_pkg.all;

entity vga is

    generic (
        C_VGA_CONFIG : t_vga_config := C_VGA_DEFAULT_CONFIG);

    port (
        ClocksxCI         : in  t_hdmi_vga_clocks;
        DataxDI           : in  std_logic_vector((C_VGA_PIXELS_SIZE - 1) downto 0);
        VgaPixCountersxDO : out t_hdmi_vga_pix_counters;
        VgaxDO            : out t_hdmi_vga);

end vga;

architecture arch of vga is

    -- Components
    component vga_stripes is
        port (
            VgaPixCounterxDI : in  t_hdmi_vga_pix_counters;
            VgaPixCounterxDO : out t_hdmi_vga_pix_counters;
            DataxDI          : in  std_logic_vector((C_VGA_PIXELS_SIZE - 1) downto 0);
            VgaPixelxDO      : out t_hdmi_vga_pix);
    end component vga_stripes;

    component vga_controler is
        generic (
            C_VGA_CONFIG : t_vga_config);
        port (
            ClocksxCI         : in  t_hdmi_vga_clocks;
            VgaSyncxSO        : out t_hdmi_vga_sync;
            VgaPixCountersxDO : out t_hdmi_vga_pix_counters);
    end component vga_controler;

    -- Signals
    signal VgaPixCountersCtrl2StripesxD : t_hdmi_vga_pix_counters := C_HDMI_VGA_PIX_COUNTERS_IDLE;
    signal VgaPixCountersxD             : t_hdmi_vga_pix_counters := C_HDMI_VGA_PIX_COUNTERS_IDLE;
    signal VgaxD                        : t_hdmi_vga              := C_HDMI_VGA_IDLE;

begin

    IOxI : block is
    begin  -- block IOxI

        VidOnxAS : VgaPixCountersxDO.VidOnxS <= VgaPixCountersCtrl2StripesxD.VidOnxS;
        HxAS     : VgaPixCountersxDO.HxD     <= VgaPixCountersxD.HxD;
        VxAS     : VgaPixCountersxDO.VxD     <= VgaPixCountersxD.VxD;
        VgaxAS   : VgaxDO                    <= VgaxD;

    end block IOxI;

    VgaxB : block is
    begin  -- block VgaxB

        VgaStripesxI : entity work.vga_stripes
            port map (
                VgaPixCounterxDI => VgaPixCountersCtrl2StripesxD,
                VgaPixCounterxDO => VgaPixCountersxD,
                DataxDI          => DataxDI,
                VgaPixelxDO      => VgaxD.PixelxD);

        VgaControlerxI : entity work.vga_controler
            generic map (
                C_VGA_CONFIG => C_VGA_CONFIG)
            port map (
                ClocksxCI         => ClocksxCI,
                VgaSyncxSO        => VgaxD.SyncxS,
                VgaPixCountersxDO => VgaPixCountersCtrl2StripesxD);

    end block VgaxB;

end arch;
