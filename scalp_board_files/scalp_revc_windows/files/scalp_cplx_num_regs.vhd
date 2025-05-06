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
-- Module Name: scalp_cplx_num_regs - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: scalp_cplx_num_regs
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

library scalp_lib;
use scalp_lib.scalp_axi_pkg.all;

entity scalp_cplx_num_regs is

    generic (
        C_REGS_ADDR_SIZE : integer := 4096;
        C_NB_REGS_IN     : integer := 0;
        C_NB_REGS_OUT    : integer := 4);

    port (
        -----------------------------------------------------------------------
        -- AXI Lite slave interface
        -----------------------------------------------------------------------
        AxiSlvxDIO  : inout t_axi_lite;
        -----------------------------------------------------------------------
        -- Register inputs
        -----------------------------------------------------------------------
        -- RegPortsxDI : in    t_axi_bunch_of_registers((C_NB_REGS_IN - 1) downto 0);
        -----------------------------------------------------------------------
        -- Register outputs
        -----------------------------------------------------------------------
        RegPortsxDO : out   t_axi_bunch_of_registers((C_NB_REGS_OUT - 1) downto 0));

end scalp_cplx_num_regs;

architecture arch of scalp_cplx_num_regs is

    -- Constants
    constant C_REGS_ADDR_BIT_SIZE  : integer        := integer(ceil(log2(real(C_REGS_ADDR_SIZE))));
    ---------------------------------------------------------------------------
    -- Register default values
    ---------------------------------------------------------------------------
    constant C_AXI_ZIM_IN_REGISTER : t_axi_register := (RegxD => x"00002000");
    constant C_AXI_ZRE_IN_REGISTER : t_axi_register := (RegxD => x"ffffe000");
    constant C_AXI_CROSS_REGISTER  : t_axi_register := (RegxD => x"00ffffff");
    constant C_AXI_BG_REGISTER     : t_axi_register := (RegxD => x"00ff0000");
    ---------------------------------------------------------------------------
    -- Register addresses offsets
    ---------------------------------------------------------------------------
    constant C_ZIM_IN_OFFSET       : integer        := 0;
    constant C_ZRE_IN_OFFSET       : integer        := 4;
    constant C_CROSS_OFFSET        : integer        := 8;
    constant C_BG_OFFSET           : integer        := 12;
    ---------------------------------------------------------------------------

    -- Signals
    -- AXI inout
    signal AxiSlvxD          : t_axi_lite                   := C_AXI_LITE_IDLE;
    -- AXI registers
    signal ReadM2SRegPortxD  : t_axi_read_ctrl_regfile_ms2  := C_AXI_READ_CTRL_REGFILE_M2S_IDLE;
    signal ReadS2MRegPortxD  : t_axi_read_ctrl_regfile_s2m  := C_AXI_READ_CTRL_REGFILE_S2M_IDLE;
    signal WriteM2SRegPortxD : t_axi_write_ctrl_regfile_ms2 := C_AXI_WRITE_CTRL_REGFILE_M2S_IDLE;
    signal WriteHandshakesxD : t_axi_write_handshakes       := C_AXI_WRITE_HANDSHAKES_IDLE;
    signal ReadStatexD       : t_read_states                := C_READ_WAITING_ON_VALID_ADDR;
    signal WriteStatexD      : t_write_states               := C_WRITE_WAITING_ON_VALID_ADDR_DATA;
    ---------------------------------------------------------------------------
    -- Registers
    ---------------------------------------------------------------------------
    signal ZImInPortxD       : t_axi_register               := C_AXI_ZIM_IN_REGISTER;
    signal ZReInPortxD       : t_axi_register               := C_AXI_ZRE_IN_REGISTER;

    ---------------------------------------------------------------------------
    -- Output registers
    ---------------------------------------------------------------------------
    signal PatternPortsxD : t_axi_bunch_of_registers(1 downto 0) := (0 => C_AXI_BG_REGISTER,
                                                                     1 => C_AXI_CROSS_REGISTER);
    ---------------------------------------------------------------------------

    -- Attributes
    attribute mark_debug : string;
    attribute keep       : string;
    --
    attribute mark_debug of AxiSlvxD          : signal is "true";
    attribute keep of AxiSlvxD                : signal is "true";
    attribute mark_debug of ReadM2SRegPortxD  : signal is "true";
    attribute keep of ReadM2SRegPortxD        : signal is "true";
    attribute mark_debug of ReadS2MRegPortxD  : signal is "true";
    attribute keep of ReadS2MRegPortxD        : signal is "true";
    attribute mark_debug of WriteM2SRegPortxD : signal is "true";
    attribute keep of WriteM2SRegPortxD       : signal is "true";
    attribute mark_debug of ReadStatexD       : signal is "true";
    attribute keep of ReadStatexD             : signal is "true";
    attribute mark_debug of WriteStatexD      : signal is "true";
    attribute keep of WriteStatexD            : signal is "true";

begin

    assert C_AXI_RDATA_SIZE = C_AXI_DATA_SIZE
        report "RDATA and DATA vectors must be the same" severity failure;

    assert C_AXI_ARADDR_SIZE >= C_AXI_ADDR_SIZE
        report "ARADDR and ADDR vectors must be the same" severity failure;

    assert C_AXI_WDATA_SIZE = C_AXI_DATA_SIZE
        report "WDATA and DATA vectors must be the same" severity failure;

    assert C_AXI_AWADDR_SIZE >= C_AXI_ADDR_SIZE
        report "AWADDR and ADDR vectors must be the same" severity failure;

    EntityIOxB : block is
    begin  -- block EntityIOxB

        -----------------------------------------------------------------------
        -- Clock and reset
        -----------------------------------------------------------------------
        AxiClockM2SxAS  : AxiSlvxD.ClockxC             <= AxiSlvxDIO.ClockxC;
        -----------------------------------------------------------------------
        -- Read channel
        -----------------------------------------------------------------------
        AxiRdAddrM2SxAS : AxiSlvxD.RdxD.AddrxD.M2SxD   <= AxiSlvxDIO.RdxD.AddrxD.M2SxD;
        AxiRdDataM2SxAS : AxiSlvxD.RdxD.DataxD.M2SxD   <= AxiSlvxDIO.RdxD.DataxD.M2SxD;
        AxiRdAddrS2MxAS : AxiSlvxDIO.RdxD.AddrxD.S2MxD <= AxiSlvxD.RdxD.AddrxD.S2MxD;
        AxiRdDataS2MxAS : AxiSlvxDIO.RdxD.DataxD.S2MxD <= AxiSlvxD.RdxD.DataxD.S2MxD;
        -----------------------------------------------------------------------
        -- Write channel
        -----------------------------------------------------------------------
        AxiWrAddrM2SxAS : AxiSlvxD.WrxD.AddrxD.M2SxD   <= AxiSlvxDIO.WrxD.AddrxD.M2SxD;
        AxiWrDataM2SxAS : AxiSlvxD.WrxD.DataxD.M2SxD   <= AxiSlvxDIO.WrxD.DataxD.M2SxD;
        AxiWrRespM2SxAS : AxiSlvxD.WrxD.RespxD.M2SxD   <= AxiSlvxDIO.WrxD.RespxD.M2SxD;
        AxiWrAddrS2MxAS : AxiSlvxDIO.WrxD.AddrxD.S2MxD <= AxiSlvxD.WrxD.AddrxD.S2MxD;
        AxiWrDataS2MxAS : AxiSlvxDIO.WrxD.DataxD.S2MxD <= AxiSlvxD.WrxD.DataxD.S2MxD;
        AxiWrRestS2MxAS : AxiSlvxDIO.WrxD.RespxD.S2MxD <= AxiSlvxD.WrxD.RespxD.S2MxD;

        -----------------------------------------------------------------------
        -- Output register ports
        -----------------------------------------------------------------------
        OutRegPortsxAS  : RegPortsxDO(1 downto 0) <= PatternPortsxD;
        OutZImInPortxAS : RegPortsxDO(2)          <= ZImInPortxD;
        OutZReInPortxAS : RegPortsxDO(3)          <= ZReInPortxD;
        -----------------------------------------------------------------------

    end block EntityIOxB;

    AxiLitexB : block is
    begin  -- block AxiLitexB

        ReadChanxB : block is
        begin  -- block ReadChanxB
            ReadRegFileCtrlxP : process (AxiSlvxD.RdxD.AddrxD.M2SxD.ARAddrxD,
                                         AxiSlvxD.RdxD.AddrxD.M2SxD.ARValidxS) is
            begin  -- process ReadRegFileCtrlxP
                if AxiSlvxD.RdxD.AddrxD.M2SxD.ARValidxS = '1' then
                    -- The master puts an address on the read address channel.
                    ReadM2SRegPortxD.RdAddrxD  <= AxiSlvxD.RdxD.AddrxD.M2SxD.ARAddrxD;
                    ReadM2SRegPortxD.RdValidxS <= '1';
                else
                    ReadM2SRegPortxD <= C_AXI_READ_CTRL_REGFILE_M2S_IDLE;
                end if;
            end process ReadRegFileCtrlxP;

            ReadTransactionxP : process (AxiSlvxD.ClockxC.ClkxC,
                                         AxiSlvxD.ResetxR.RstxRAN) is
            begin  -- process ReadTransactionxP
                if AxiSlvxD.ResetxR.RstxRAN = '0' then  -- asynchronous reset (active low)
                    AxiSlvxD.RdxD.AddrxD.S2MxD <= C_AXI_RAC_S2M_IDLE;
                    AxiSlvxD.RdxD.DataxD.S2MxD <= C_AXI_RDC_S2M_IDLE;
                    ReadStatexD                <= C_READ_WAITING_ON_VALID_ADDR;
                elsif rising_edge(AxiSlvxD.ClockxC.ClkxC) then  -- rising clock edge

                    case ReadStatexD is
                        when C_READ_WAITING_ON_VALID_ADDR =>
                            -- The address is valid and the master is ready to
                            -- receive data.

                            if AxiSlvxD.RdxD.AddrxD.M2SxD.ARValidxS = '1' and
                                AxiSlvxD.RdxD.DataxD.M2SxD.RReadyxS = '1' then
                                -- The slave is ready to receive the address.
                                -- We therefore immediately read the data.
                                AxiSlvxD.RdxD.AddrxD.S2MxD.ARReadyxS <= '1';
                                -- Go to next state.
                                ReadStatexD                          <= C_READ_WAITING_ON_HANDSHAKE;
                            end if;

                        when C_READ_WAITING_ON_HANDSHAKE =>
                            -- The handshake occurs.
                            if AxiSlvxD.RdxD.AddrxD.M2SxD.ARValidxS = '1' and
                                AxiSlvxD.RdxD.AddrxD.S2MxD.ARReadyxS = '1' then
                                -- At this point, we've read the address and got the data.
                                AxiSlvxD.RdxD.AddrxD.S2MxD.ARReadyxS <= '0';
                                -- We put the data on the bus and we assert the rvalid
                                -- signal.
                                AxiSlvxD.RdxD.DataxD.S2MxD.RDataxD   <= ReadS2MRegPortxD.RdDataxD;
                                AxiSlvxD.RdxD.DataxD.S2MxD.RValidxS  <= '1';
                                -- We can also put data on the rresp bus.
                                AxiSlvxD.RdxD.DataxD.S2MxD.RRespxD   <= C_AXI_RRESP_OKAY;
                                -- Go to next state.
                                ReadStatexD                          <= C_READ_COMPLETE_TRANSACTION;
                            end if;

                        when C_READ_COMPLETE_TRANSACTION =>
                            -- Here, we complete the transaction.
                            if AxiSlvxD.RdxD.DataxD.M2SxD.RReadyxS = '1' and
                                AxiSlvxD.RdxD.DataxD.S2MxD.RValidxS = '1' then
                                -- We desassert the rvalid signal.
                                AxiSlvxD.RdxD.DataxD.S2MxD.RDataxD  <= (others => '0');
                                AxiSlvxD.RdxD.DataxD.S2MxD.RValidxS <= '0';
                                -- Go to initial state.
                                ReadStatexD                         <= C_READ_WAITING_ON_VALID_ADDR;
                            end if;

                        when others => null;
                    end case;

                end if;
            end process ReadTransactionxP;

        end block ReadChanxB;

        WriteChanxB : block is
        begin  -- block WriteChanxB

            WriteTransactionxP : process (AxiSlvxD.ClockxC.ClkxC,
                                          AxiSlvxD.ResetxR.RstxRAN) is
            begin  -- process WriteTransactionxP
                if AxiSlvxD.ResetxR.RstxRAN = '0' then  -- asynchronous reset (active low)
                    AxiSlvxD.WrxD.AddrxD.S2MxD <= C_AXI_WAC_S2M_IDLE;
                    AxiSlvxD.WrxD.DataxD.S2MxD <= C_AXI_WDC_S2M_IDLE;
                    AxiSlvxD.WrxD.RespxD.S2MxD <= C_AXI_WRC_S2M_IDLE;
                    WriteHandshakesxD          <= C_AXI_WRITE_HANDSHAKES_IDLE;
                    WriteStatexD               <= C_WRITE_WAITING_ON_VALID_ADDR_DATA;
                    WriteM2SRegPortxD          <= C_AXI_WRITE_CTRL_REGFILE_M2S_IDLE;
                elsif rising_edge(AxiSlvxD.ClockxC.ClkxC) then  -- rising clock edge

                    WriteM2SRegPortxD <= WriteM2SRegPortxD;

                    case WriteStatexD is
                        when C_WRITE_WAITING_ON_VALID_ADDR_DATA =>
                            -- The address and the data are valid and the
                            -- master is ready to receive a response.
                            if AxiSlvxD.WrxD.AddrxD.M2SxD.AWValidxS = '1' and
                                AxiSlvxD.WrxD.DataxD.M2SxD.WValidxS = '1' and
                                AxiSlvxD.WrxD.RespxD.M2SxD.BReadyxS = '1' then
                                -- The slave is ready to receive the address
                                -- and the data. We therefore immediately write the
                                -- data to the address.
                                AxiSlvxD.WrxD.AddrxD.S2MxD.AWReadyxS <= '1';
                                AxiSlvxD.WrxD.DataxD.S2MxD.WReadyxS  <= '1';
                                WriteM2SRegPortxD.WrAddrxD           <= AxiSlvxD.WrxD.AddrxD.M2SxD.AWAddrxD;
                                WriteM2SRegPortxD.WrDataxD           <= AxiSlvxD.WrxD.DataxD.M2SxD.WDataxD;
                                WriteM2SRegPortxD.WrStrbxD           <= AxiSlvxD.WrxD.DataxD.M2SxD.WStrbxD;
                                -- Go to next state.
                                WriteStatexD                         <= C_WRITE_WAITING_ON_HANDSHAKE;
                            end if;

                        when C_WRITE_WAITING_ON_HANDSHAKE =>
                            -- The address hanshake occurs.
                            if AxiSlvxD.WrxD.AddrxD.M2SxD.AWValidxS = '1' and
                                AxiSlvxD.WrxD.AddrxD.S2MxD.AWReadyxS = '1' then
                                WriteHandshakesxD.AddressxS <= '1';
                            end if;
                            -- The data hanshake occurs.
                            if AxiSlvxD.WrxD.DataxD.M2SxD.WValidxS = '1' and
                                AxiSlvxD.WrxD.DataxD.S2MxD.WReadyxS = '1' then
                                WriteHandshakesxD.DataxS <= '1';
                            end if;
                            -- Both handshakes must occur before the slave can
                            -- send a write response.
                            if WriteHandshakesxD.AddressxS = '1' and WriteHandshakesxD.DataxS = '1' then
                                -- At this point we've read the address and the
                                -- data.
                                AxiSlvxD.WrxD.AddrxD.S2MxD.AWReadyxS <= '0';
                                AxiSlvxD.WrxD.DataxD.S2MxD.WReadyxS  <= '0';
                                -- We store the data in the register bank.
                                AxiSlvxD.WrxD.RespxD.S2MxD.BRespxD   <= C_AXI_BRESP_OKAY;
                                AxiSlvxD.WrxD.RespxD.S2MxD.BValidxS  <= '1';
                                WriteM2SRegPortxD.WrValidxS          <= '1';
                                -- Go to initial state.
                                WriteStatexD                         <= C_WRITE_COMPLETE_TRANSACTION;
                            end if;

                        when C_WRITE_COMPLETE_TRANSACTION =>
                            -- Here we complete the transaction.
                            if AxiSlvxD.WrxD.RespxD.M2SxD.BReadyxS = '1' and
                                AxiSlvxD.WrxD.RespxD.S2MxD.BValidxS = '1' then
                                -- We desassert the bvalid signal.
                                AxiSlvxD.WrxD.RespxD.S2MxD.BValidxS <= '0';
                                WriteM2SRegPortxD.WrValidxS         <= '0';
                                -- We clean the WriteM2S and WriteHanshakes registers
                                WriteHandshakesxD                   <= C_AXI_WRITE_HANDSHAKES_IDLE;
                                -- Go to initial state.
                                WriteStatexD                        <= C_WRITE_WAITING_ON_VALID_ADDR_DATA;
                            end if;

                        when others => null;
                    end case;

                end if;
            end process WriteTransactionxP;

        end block WriteChanxB;

    end block AxiLitexB;

    CplxNumRegFilexB : block is
    begin  -- block CplxNumRegFilexB

        RegFilexP : process (AxiSlvxD.ClockxC.ClkxC, AxiSlvxD.ResetxR.RstxRAN) is
        begin  -- process RegFilexP
            if AxiSlvxD.ResetxR.RstxRAN = '0' then  -- asynchronous reset (active low)
                ---------------------------------------------------------------
                -- Initial states
                ---------------------------------------------------------------
                ReadS2MRegPortxD  <= C_AXI_READ_CTRL_REGFILE_S2M_IDLE;
                ---------------------------------------------------------------
                ZImInPortxD       <= C_AXI_ZIM_IN_REGISTER;
                ZReInPortxD       <= C_AXI_ZRE_IN_REGISTER;
                PatternPortsxD(0) <= C_AXI_CROSS_REGISTER;
                PatternPortsxD(1) <= C_AXI_BG_REGISTER;

            elsif rising_edge(AxiSlvxD.ClockxC.ClkxC) then  -- rising clock edge
                ---------------------------------------------------------------
                -- Update register
                ---------------------------------------------------------------
                ReadS2MRegPortxD <= ReadS2MRegPortxD;
                ---------------------------------------------------------------
                ZImInPortxD      <= ZImInPortxD;
                ZReInPortxD      <= ZReInPortxD;
                PatternPortsxD   <= PatternPortsxD;

                ---------------------------------------------------------------
                -- Read side
                ---------------------------------------------------------------
                if ReadM2SRegPortxD.RdValidxS = '1' then
                    case ReadM2SRegPortxD.RdAddrxD((C_REGS_ADDR_BIT_SIZE - 1) downto 0) is
                        when std_logic_vector(to_unsigned(C_ZIM_IN_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= ZImInPortxD.RegxD;
                        when std_logic_vector(to_unsigned(C_ZRE_IN_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= ZReInPortxD.RegxD;
                        when std_logic_vector(to_unsigned(C_CROSS_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= PatternPortsxD(0).RegxD;
                        when std_logic_vector(to_unsigned(C_BG_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= PatternPortsxD(1).RegxD;
                        when others => ReadS2MRegPortxD.RdDataxD <= (others => '0');
                    end case;
                end if;

                ---------------------------------------------------------------
                -- Write side
                ---------------------------------------------------------------
                if WriteM2SRegPortxD.WrValidxS = '1' then
                    case WriteM2SRegPortxD.WrAddrxD((C_REGS_ADDR_BIT_SIZE - 1) downto 0) is
                        when std_logic_vector(to_unsigned(C_ZIM_IN_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            -- ZImInPortxD.RegxD <= WriteM2SRegPortxD.WrDataxD;
                            ZImInPortxD <=
                                axi_wr_valid_bytes(WriteM2SRegPortxD.WrDataxD, WriteM2SRegPortxD.WrStrbxD, ZImInPortxD);
                        when std_logic_vector(to_unsigned(C_ZRE_IN_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            -- ZReInPortxD.RegxD <= WriteM2SRegPortxD.WrDataxD;
                            ZReInPortxD <=
                                axi_wr_valid_bytes(WriteM2SRegPortxD.WrDataxD, WriteM2SRegPortxD.WrStrbxD, ZReInPortxD);
                        when std_logic_vector(to_unsigned(C_CROSS_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            -- PatternPortsxD(0).RegxD <= WriteM2SRegPortxD.WrDataxD;
                            PatternPortsxD(0) <=
                                axi_wr_valid_bytes(WriteM2SRegPortxD.WrDataxD, WriteM2SRegPortxD.WrStrbxD, PatternPortsxD(0));
                        when std_logic_vector(to_unsigned(C_BG_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            -- PatternPortsxD(1).RegxD <= WriteM2SRegPortxD.WrDataxD;
                            PatternPortsxD(1) <=
                                axi_wr_valid_bytes(WriteM2SRegPortxD.WrDataxD, WriteM2SRegPortxD.WrStrbxD, PatternPortsxD(0));
                        when others => null;
                    end case;
                end if;

            end if;
        end process RegFilexP;

    end block CplxNumRegFilexB;

end arch;
