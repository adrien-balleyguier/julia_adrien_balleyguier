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
-- Module Name: scalp_axi_link - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: scalp_axi_link
--
-- Last update: 2023-11-29
--
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.all;

library unisim;
use unisim.vcomponents.all;

entity scalp_axi_link is

    generic (
        C_AXI4_ARADDR_SIZE : integer range 0 to 32 := 32;
        C_AXI4_RDATA_SIZE  : integer range 0 to 32 := 32;
        C_AXI4_RRESP_SIZE  : integer range 0 to 2  := 2;
        C_AXI4_AWADDR_SIZE : integer range 0 to 32 := 32;
        C_AXI4_WDATA_SIZE  : integer range 0 to 32 := 32;
        C_AXI4_WSTRB_SIZE  : integer range 0 to 4  := 4;
        C_AXI4_BRESP_SIZE  : integer range 0 to 2  := 2;
        C_AXI4_ADDR_SIZE   : integer range 0 to 32 := 12;
        C_AXI4_DATA_SIZE   : integer range 0 to 32 := 32);

    port (
        -----------------------------------------------------------------------
        -- Input side
        -----------------------------------------------------------------------
        -- Clock and reset
        SAxiSlvClkxCI     : in  std_ulogic;
        SAxiSlvRstxRANI   : in  std_ulogic;
        -- AXI4 Lite
        -- Read Channel
        -- Read Address Channel
        SAxiSlvARAddrxDI  : in  std_ulogic_vector((C_AXI4_ARADDR_SIZE - 1) downto 0);
        SAxiSlvARValidxSI : in  std_ulogic;
        SAxiSlvARReadyxSO : out std_ulogic;
        -- Read Data Channel
        SAxiSlvRDataxDO   : out std_ulogic_vector((C_AXI4_RDATA_SIZE - 1) downto 0);
        SAxiSlvRRespxDO   : out std_ulogic_vector((C_AXI4_RRESP_SIZE - 1) downto 0);
        SAxiSlvRValidxSO  : out std_ulogic;
        SAxiSlvRReadyxSI  : in  std_ulogic;
        -- Write Channel
        -- Write Address Channel
        SAxiSlvAWAddrxDI  : in  std_ulogic_vector((C_AXI4_AWADDR_SIZE - 1) downto 0);
        SAxiSlvAWValidxSI : in  std_ulogic;
        SAxiSlvAWReadyxSO : out std_ulogic;
        -- Write Data Channel
        SAxiSlvWDataxDI   : in  std_ulogic_vector((C_AXI4_WDATA_SIZE - 1) downto 0);
        SAxiSlvWStrbxDI   : in  std_ulogic_vector((C_AXI4_WSTRB_SIZE - 1) downto 0);
        SAxiSlvWValidxSI  : in  std_ulogic;
        SAxiSlvWReadyxSO  : out std_ulogic;
        -- Write Response Channel
        SAxiSlvBRespxDO   : out std_ulogic_vector((C_AXI4_BRESP_SIZE - 1) downto 0);
        SAxiSlvBValidxSO  : out std_ulogic;
        SAxiSlvBReadyxSI  : in  std_ulogic;
        -----------------------------------------------------------------------
        -- Output side
        -----------------------------------------------------------------------
        -- Clock and reset
        SAxiMstClkxCO     : out std_ulogic;
        SAxiMstRstxRANO   : out std_ulogic;
        -- AXI4 Lite
        -- Read Channel
        -- Read Address Channel
        SAxiMstARAddrxDO  : out std_ulogic_vector((C_AXI4_ARADDR_SIZE - 1) downto 0);
        SAxiMstARValidxSO : out std_ulogic;
        SAxiMstARReadyxSI : in  std_ulogic;
        -- Read Data Channel
        SAxiMstRDataxDI   : in  std_ulogic_vector((C_AXI4_RDATA_SIZE - 1) downto 0);
        SAxiMstRRespxDI   : in  std_ulogic_vector((C_AXI4_RRESP_SIZE - 1) downto 0);
        SAxiMstRValidxSI  : in  std_ulogic;
        SAxiMstRReadyxSO  : out std_ulogic;
        -- Write Channel
        -- Write Address Channel
        SAxiMstAWAddrxDO  : out std_ulogic_vector((C_AXI4_AWADDR_SIZE - 1) downto 0);
        SAxiMstAWValidxSO : out std_ulogic;
        SAxiMstAWReadyxSI : in  std_ulogic;
        -- Write Data Channel
        SAxiMstWDataxDO   : out std_ulogic_vector((C_AXI4_WDATA_SIZE - 1) downto 0);
        SAxiMstWStrbxDO   : out std_ulogic_vector((C_AXI4_WSTRB_SIZE - 1) downto 0);
        SAxiMstWValidxSO  : out std_ulogic;
        SAxiMstWReadyxSI  : in  std_ulogic;
        -- Write Response Channel
        SAxiMstBRespxDI   : in  std_ulogic_vector((C_AXI4_BRESP_SIZE - 1) downto 0);
        SAxiMstBValidxSI  : in  std_ulogic;
        SAxiMstBReadyxSO  : out std_ulogic);

end scalp_axi_link;

architecture arch of scalp_axi_link is
begin

    LinkInOutxB : block is
    begin  -- block LinkInOutxB

        ClkRstxB : block is
        begin  -- block ClkRstxB
            ClkxAS : SAxiMstClkxCO   <= SAxiSlvClkxCI;
            RstxAS : SAxiMstRstxRANO <= SAxiSlvRstxRANI;
        end block ClkRstxB;

        ReadChanxB : block is
        begin  -- block ReadChanxB

            AddrChanxB : block is
            begin  -- block AddrChanxB
                ARAddrxAS  : SAxiMstARAddrxDO  <= SAxiSlvARAddrxDI;
                ARValidxAS : SAxiMstARValidxSO <= SAxiSlvARValidxSI;
                ARReadyxAS : SAxiSlvARReadyxSO <= SAxiMstARReadyxSI;
            end block AddrChanxB;

            DataChanxB : block is
            begin  -- block DataChanxB
                RDataxAS  : SAxiSlvRDataxDO  <= SAxiMstRDataxDI;
                RRespxAS  : SAxiSlvRRespxDO  <= SAxiMstRRespxDI;
                RValidxAS : SAxiSlvRValidxSO <= SAxiMstRValidxSI;
                RReadyxAS : SAxiMstRReadyxSO <= SAxiSlvRReadyxSI;
            end block DataChanxB;

        end block ReadChanxB;

        WriteChanxB : block is
        begin  -- block WriteChanxB

            AddrChanxB : block is
            begin  -- block AddrChanxB
                AWAddrxAS  : SAxiMstAWAddrxDO  <= SAxiSlvAWAddrxDI;
                AWValidxAS : SAxiMstAWValidxSO <= SAxiSlvAWValidxSI;
                AWReadyxAS : SAxiSlvAWReadyxSO <= SAxiMstAWReadyxSI;
            end block AddrChanxB;

            DataChanxB : block is
            begin  -- block DataChanxB
                WDataxAS  : SAxiMstWDataxDO  <= SAxiSlvWDataxDI;
                WStrbxAS  : SAxiMstWStrbxDO  <= SAxiSlvWStrbxDI;
                WValidxAS : SAxiMstWValidxSO <= SAxiSlvWValidxSI;
                WReadyxAS : SAxiSlvWReadyxSO <= SAxiMstWReadyxSI;
            end block DataChanxB;

            RespChanxB : block is
            begin  -- block RespChanxB
                BRespxAS  : SAxiSlvBRespxDO  <= SAxiMstBRespxDI;
                BValidxAS : SAxiSlvBValidxSO <= SAxiMstBValidxSI;
                BReadyxAS : SAxiMstBReadyxSO <= SAxiSlvBReadyxSI;
            end block RespChanxB;

        end block WriteChanxB;

    end block LinkInOutxB;

end arch;
