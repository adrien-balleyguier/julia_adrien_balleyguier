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
-- Module Name: scalp_hdmi - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: scalp_hdmi
--
-- Last update: 2024-03-22
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

entity scalp_hdmi is

    generic (
        C_VGA_CONFIG : t_vga_config := C_VGA_DEFAULT_CONFIG);

    port (
        -- Vga and Hdmi clocks, reset and pll locked signals
        ClocksxCI         : in    t_hdmi_vga_clocks;
        -- Vga pixel counters
        VgaPixCountersxDO : out   t_hdmi_vga_pix_counters;
        -- Pixel input
        PixelxDI          : in    t_hdmi_vga_pix;
        -- Hdmi Tx
        HdmiTxxDIO        : inout t_hdmi_tx);

end scalp_hdmi;

architecture arch of scalp_hdmi is

    -- Components
    component vga is
        generic (
            C_VGA_CONFIG : t_vga_config);
        port (
            ClocksxCI         : in  t_hdmi_vga_clocks;
            DataxDI           : in  std_logic_vector((C_VGA_PIXELS_SIZE - 1) downto 0);
            VgaPixCountersxDO : out t_hdmi_vga_pix_counters;
            VgaxDO            : out t_hdmi_vga);
    end component vga;

    component vga_to_hdmi is
        port (
            ClocksxCI : in    t_hdmi_vga_clocks;
            VidOnxSI  : in    std_logic;
            VgaxDI    : in    t_hdmi_vga;
            HdmixDIO  : inout t_hdmi_tx);
    end component vga_to_hdmi;

    -- Signals
    signal DataxD           : std_logic_vector((C_VGA_PIXELS_SIZE - 1) downto 0) := (others => '0');
    signal VgaxD            : t_hdmi_vga                                         := C_HDMI_VGA_IDLE;
    signal VgaPixCountersxD : t_hdmi_vga_pix_counters                            := C_HDMI_VGA_PIX_COUNTERS_IDLE;

begin

    assert (C_VGA_CONFIG = C_VGA_720X720_60HZ_CONFIG)
        report "Not supported resolution!" severity failure;

    IOxB : block is
    begin  -- block IOxB

        DataxAS           : DataxD            <= PixelxDI.RxD & PixelxDI.GxD & PixelxDI.BxD;
        VgaPixCountersxAS : VgaPixCountersxDO <= VgaPixCountersxD;

    end block IOxB;

    Vga2HdmiConvertxB : block is
    begin  -- block Vga2HdmiConvertxB

        -- Data input (23:16 => R, 15:8 => G, 7:0 => B)
        VgaxI : entity work.vga
            generic map (
                C_VGA_CONFIG => C_VGA_CONFIG)
            port map (
                ClocksxCI         => ClocksxCI,
                DataxDI           => DataxD,
                VgaPixCountersxDO => VgaPixCountersxD,
                VgaxDO            => VgaxD);

        Vga2HdmixI : entity work.vga_to_hdmi
            port map (
                ClocksxCI => ClocksxCI,
                VidOnxSI  => VgaPixCountersxD.VidOnxS,
                VgaxDI    => VgaxD,
                HdmixDIO  => HdmiTxxDIO);

    end block Vga2HdmiConvertxB;

end arch;
