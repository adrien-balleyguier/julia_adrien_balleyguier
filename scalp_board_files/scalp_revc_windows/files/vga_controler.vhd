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
-- Module Name: vga_controler - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: vga_controler
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

entity vga_controler is

    generic (
        C_VGA_CONFIG : t_vga_config := C_VGA_DEFAULT_CONFIG);

    port (
        ClocksxCI         : in  t_hdmi_vga_clocks;
        VgaSyncxSO        : out t_hdmi_vga_sync;
        VgaPixCountersxDO : out t_hdmi_vga_pix_counters);

end vga_controler;

architecture arch of vga_controler is

    signal VgaConfigxD      : t_vga_config            := C_VGA_CONFIG;
    signal VgaSyncxS        : t_hdmi_vga_sync         := C_HDMI_VGA_SYNC_IDLE;
    signal VgaPixCountersxD : t_hdmi_vga_pix_counters := C_HDMI_VGA_PIX_COUNTERS_IDLE;

begin

    IOxB : block is
    begin  -- block IOxB

        VgaSyncxAS : VgaSyncxSO                <= VgaSyncxS;
        HxAS       : VgaPixCountersxDO.HxD     <= std_logic_vector(unsigned(VgaPixCountersxD.HxD) - to_unsigned(C_HDMI_LATENCY, C_VGA_HV_COUNT_SIZE));
        VxAS       : VgaPixCountersxDO.VxD     <= VgaPixCountersxD.VxD;
        VidOnxAS   : VgaPixCountersxDO.VidOnxS <= VgaPixCountersxD.VidOnxS;

    end block IOxB;

    VgaPixCountersxP : process (ClocksxCI.PllLockedxS, ClocksxCI.VgaResetxR,
                                ClocksxCI.VgaxC) is
    begin  -- process VgaPixCountersxP
        if (ClocksxCI.VgaResetxR = '1') or (ClocksxCI.PllLockedxS = '0') then
            VgaSyncxS        <= C_HDMI_VGA_SYNC_IDLE;
            VgaPixCountersxD <= C_HDMI_VGA_PIX_COUNTERS_IDLE;
        elsif rising_edge(ClocksxCI.VgaxC) then
            VgaSyncxS        <= VgaSyncxS;
            VgaPixCountersxD <= VgaPixCountersxD;

            -- Set/reset VidOnxS
            if unsigned(VgaPixCountersxD.HxD) = (VgaConfigxD.HActivexD - 1) then
                VgaPixCountersxD.VidOnxS <= '0';
            elsif (unsigned(VgaPixCountersxD.HxD) = (VgaConfigxD.HLenxD - 1)) and
                ((unsigned(VgaPixCountersxD.VxD) < (VgaConfigxD.VActivexD - 1)) or
                 (unsigned(VgaPixCountersxD.VxD) = (VgaConfigxD.VLenxD - 1))) then
                VgaPixCountersxD.VidOnxS <= '1';
            end if;

            -- Set/reset HSyncxS
            if unsigned(VgaPixCountersxD.HxD) = (VgaConfigxD.HActivexD + VgaConfigxD.HFrontPorchxD - 1) then
                VgaSyncxS.HxS <= '1';
            elsif unsigned(VgaPixCountersxD.HxD) = (VgaConfigxD.HActivexD + VgaConfigxD.HFrontPorchxD +
                                                    VgaConfigxD.HSyncLenxD - 1) then
                VgaSyncxS.HxS <= '0';
            end if;

            -- Reset HCountxD or increment HCountxD
            if unsigned(VgaPixCountersxD.HxD) = (VgaConfigxD.HLenxD - 1) then
                VgaPixCountersxD.HxD <= C_HDMI_VGA_PIX_H_COUNTER_IDLE;

                -- Set/reset VSyncxS
                if unsigned(VgaPixCountersxD.VxD) = (VgaConfigxD.VActivexD + VgaConfigxD.VBackPorchxD - 1) then
                    VgaSyncxS.VxS <= '1';
                elsif unsigned(VgaPixCountersxD.VxD) = (VgaConfigxD.VActivexD + VgaConfigxD.VBackPorchxD +
                                                        VgaConfigxD.VSyncLenxD - 1) then
                    VgaSyncxS.VxS <= '0';
                end if;

                -- Reset VCountxD or increment VCountxD
                if unsigned(VgaPixCountersxD.VxD) = (VgaConfigxD.VLenxD - 1) then
                    VgaPixCountersxD.VxD <= C_HDMI_VGA_PIX_V_COUNTER_IDLE;
                else
                    VgaPixCountersxD.VxD <= std_logic_vector(unsigned(VgaPixCountersxD.VxD) + 1);
                end if;
            else
                VgaPixCountersxD.HxD <= std_logic_vector(unsigned(VgaPixCountersxD.HxD) + 1);
            end if;
        end if;
    end process VgaPixCountersxP;

end arch;
