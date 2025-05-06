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
-- Module Name: vga_to_hdmi - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: vga_to_hdmi
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

entity vga_to_hdmi is

    port (
        ClocksxCI : in    t_hdmi_vga_clocks;
        VidOnxSI  : in    std_logic;
        VgaxDI    : in    t_hdmi_vga;
        HdmixDIO  : inout t_hdmi_tx);

end vga_to_hdmi;

architecture arch of vga_to_hdmi is

    -- Components
    component tmds_encoder is
        port (
            ClkxCI             : in  std_logic;
            TmdsDataxDI        : in  std_logic_vector((C_TMDS_DATA_SIZE - 1) downto 0);
            ControlxDI         : in  std_logic_vector(1 downto 0);
            VidOnxSI           : in  std_logic;
            TmdsEncodedDataxDO : out std_logic_vector((C_TMDS_ENCODED_DATA_SIZE - 1) downto 0));
    end component tmds_encoder;

    component serializer_10_to_1 is
        port (
            ClocksxCI         : in  t_hdmi_vga_clocks;
            TmdsDataxDI       : in  std_logic_vector((C_TMDS_ENCODED_DATA_SIZE - 1) downto 0);
            TmdsSerialDataxSO : out std_logic);
    end component serializer_10_to_1;

    -- Signals
    signal HdmixD               : t_hdmi_tx                                                 := C_HDMI_TX_IDLE;
    signal TmdsEncodedDataCh0xD : std_logic_vector((C_TMDS_ENCODED_DATA_SIZE - 1) downto 0) := (others => '0');
    signal TmdsEncodedDataCh1xD : std_logic_vector((C_TMDS_ENCODED_DATA_SIZE - 1) downto 0) := (others => '0');
    signal TmdsEncodedDataCh2xD : std_logic_vector((C_TMDS_ENCODED_DATA_SIZE - 1) downto 0) := (others => '0');
    signal TmdsEncodedDataClkxD : std_logic_vector((C_TMDS_ENCODED_DATA_SIZE - 1) downto 0) := C_TMDS_ENCODED_DATA_CLK;
    signal TmdsSerialDataxD     : std_logic_vector((C_HDMI_CHANNELS - 1) downto 0)          := (others => '0');

begin

    IOxB : block is
    begin  -- block IOxB

        OutxAS   : HdmixDIO.OutxD       <= HdmixD.OutxD;
        InxAS    : HdmixD.InxD          <= HdmixDIO.InxD;
        InOutxAS : HdmixDIO.InOutxD     <= HdmixD.InOutxD;
        SclxAS   : HdmixD.OutxD.SclxS   <= '1';
        SdaxAS   : HdmixD.InOutxD.SdaxS <= 'Z';
        CecxAS   : HdmixD.InOutxD.CecxS <= 'Z';

    end block IOxB;

    TmdsEncodersxB : block is
    begin  -- block TmdsEncodersxB

        -- Blue + HSync + VSync
        TmdsEncoderC0xI : entity work.tmds_encoder
            port map (
                ClkxCI             => ClocksxCI.VgaxC,
                TmdsDataxDI        => VgaxDI.PixelxD.BxD,
                ControlxDI(0)      => VgaxDI.SyncxS.HxS,
                ControlxDI(1)      => VgaxDI.SyncxS.VxS,
                VidOnxSI           => VidOnxSI,
                TmdsEncodedDataxDO => TmdsEncodedDataCh0xD);

        -- Green
        TmdsEncoderC1xI : entity work.tmds_encoder
            port map (
                ClkxCI             => ClocksxCI.VgaxC,
                TmdsDataxDI        => VgaxDI.PixelxD.GxD,
                ControlxDI         => (others => '0'),
                VidOnxSI           => VidOnxSI,
                TmdsEncodedDataxDO => TmdsEncodedDataCh1xD);

        -- Red
        TmdsEncoderC2xI : entity work.tmds_encoder
            port map (
                ClkxCI             => ClocksxCI.VgaxC,
                TmdsDataxDI        => VgaxDI.PixelxD.RxD,
                ControlxDI         => (others => '0'),
                VidOnxSI           => VidOnxSI,
                TmdsEncodedDataxDO => TmdsEncodedDataCh2xD);

    end block TmdsEncodersxB;

    SerializersxB : block is
    begin  -- block SerializersxB

        -- Blue + HSync + VSync
        SerializerC0xI : entity work.serializer_10_to_1
            port map (
                ClocksxCI         => ClocksxCI,
                TmdsDataxDI       => TmdsEncodedDataCh0xD,
                TmdsSerialDataxSO => TmdsSerialDataxD(0));

        -- Green
        SerializerC1xI : entity work.serializer_10_to_1
            port map (
                ClocksxCI         => ClocksxCI,
                TmdsDataxDI       => TmdsEncodedDataCh1xD,
                TmdsSerialDataxSO => TmdsSerialDataxD(1));

        -- Red
        SerializerC2xI : entity work.serializer_10_to_1
            port map (
                ClocksxCI         => ClocksxCI,
                TmdsDataxDI       => TmdsEncodedDataCh2xD,
                TmdsSerialDataxSO => TmdsSerialDataxD(2));

        -- Clock
        SerializerC3xI : entity work.serializer_10_to_1
            port map (
                ClocksxCI         => ClocksxCI,
                TmdsDataxDI       => TmdsEncodedDataClkxD,
                TmdsSerialDataxSO => TmdsSerialDataxD(3));

    end block SerializersxB;

    OBufDSxB : block is
    begin  -- block OBufDSxB

        -- 0 => Blue + HSync + VSync
        -- 1 => Green
        -- 2 => Red
        OBufDSxG : for i in 0 to (C_HDMI_LANES - 1) generate

            OBufDSHdmiTxCNxI : OBUFDS
                generic map (
                    IOSTANDARD => "LVDS_25",
                    SLEW       => "FAST")
                port map (
                    O  => HdmixD.OutxD.DataxD.PxD(i),
                    OB => HdmixD.OutxD.DataxD.NxD(i),
                    I  => TmdsSerialDataxD(i));

        end generate OBufDSxG;

        -- 3 => Clock
        OBufDSHdmiTxC3xI : OBUFDS
            generic map (
                IOSTANDARD => "LVDS_25",
                SLEW       => "FAST")
            port map (
                O  => HdmixD.OutxD.ClkxC.PxC,
                OB => HdmixD.OutxD.ClkxC.NxC,
                I  => TmdsSerialDataxD(3));

    end block OBufDSxB;

end arch;
