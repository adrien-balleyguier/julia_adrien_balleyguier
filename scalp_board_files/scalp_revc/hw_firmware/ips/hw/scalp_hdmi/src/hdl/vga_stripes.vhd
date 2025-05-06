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
-- Module Name: vga_stripes - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: vga_stripes
--
-- Last update: 2024-03-19
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

entity vga_stripes is

    port (
        VgaPixCounterxDI : in  t_hdmi_vga_pix_counters;
        VgaPixCounterxDO : out t_hdmi_vga_pix_counters;
        DataxDI          : in  std_logic_vector((C_VGA_PIXELS_SIZE - 1) downto 0);
        VgaPixelxDO      : out t_hdmi_vga_pix);

end vga_stripes;

architecture arch of vga_stripes is

begin

    VgaPixCountersxP : process (all) is
    begin  -- process VgaPixCountersxP
        if VgaPixCounterxDI.VidOnxS = '1' then
            VgaPixCounterxDO.HxD <= VgaPixCounterxDI.HxD;
            VgaPixCounterxDO.VxD <= VgaPixCounterxDI.VxD;
        else
            VgaPixCounterxDO.HxD <= (others => '0');
            VgaPixCounterxDO.VxD <= (others => '0');
        end if;
    end process VgaPixCountersxP;

    PixelxP : process (all) is
    begin  -- process PixelxP
        if VgaPixCounterxDI.VidOnxS = '1' then
            VgaPixelxDO.RxD <= DataxDI((C_VGA_PIXELS_SIZE - 1) downto (C_VGA_PIXELS_SIZE - C_VGA_PIXEL_SIZE));
            VgaPixelxDO.GxD <= DataxDI((C_VGA_PIXELS_SIZE - C_VGA_PIXEL_SIZE - 1) downto (C_VGA_PIXELS_SIZE - (2 * C_VGA_PIXEL_SIZE)));
            VgaPixelxDO.BxD <= DataxDI(((C_VGA_PIXELS_SIZE - (2 * C_VGA_PIXEL_SIZE)) - 1) downto 0);
        else
            VgaPixelxDO.RxD <= (others => '0');
            VgaPixelxDO.GxD <= (others => '0');
            VgaPixelxDO.BxD <= (others => '0');
        end if;
    end process PixelxP;

end arch;
