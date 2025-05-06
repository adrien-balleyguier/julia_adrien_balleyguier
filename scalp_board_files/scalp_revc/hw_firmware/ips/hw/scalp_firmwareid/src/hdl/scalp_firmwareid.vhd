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
-- Module Name: scalp_firmwareid - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: scalp_firmwareid
--
-- Last update: 2024-03-25
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

entity scalp_firmwareid is

    generic (
        C_REGS_ADDR_SIZE : integer := 4096;
        C_NB_REGS_IN     : integer := 0;
        C_NB_REGS_OUT    : integer := 2);

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

end scalp_firmwareid;

architecture behavioral of scalp_firmwareid is

    -- Constants
    constant C_REGS_ADDR_BIT_SIZE              : integer        := integer(ceil(log2(real(C_REGS_ADDR_SIZE))));
    --<static_constants>
    constant C_AXI_BOARD_NAME_HIGH_REGISTER    : t_axi_register := (RegxD => x"00000053");
    constant C_AXI_BOARD_NAME_LOW_REGISTER     : t_axi_register := (RegxD => x"63616C70");
    constant C_AXI_BOARD_REVISION_REGISTER     : t_axi_register := (RegxD => x"00000043");
    constant C_AXI_FIRMWARE_LED_COLOR_REGISTER : t_axi_register := (RegxD => x"00C3EB34");
    --<mutable_constants>
    --<firmware_type>
    constant C_AXI_FIRMWARE_TYPE_REGISTER      : t_axi_register := (RegxD => x"00000000");
    --<firmware_id>
    constant C_AXI_FIRMWARE_ID_REGISTER        : t_axi_register := (RegxD => x"00000000");
    --<firmware_date>
    constant C_AXI_FIRMWARE_DATE_REGISTER      : t_axi_register := (RegxD => x"00000000");
    --<firmware_username>
    constant C_AXI_FIRMWARE_USERNAME_REGISTER  : t_axi_register := (RegxD => x"00000000");
    ---------------------------------------------------------------------------
    -- Register addresses offsets
    ---------------------------------------------------------------------------
    constant C_BOARD_NAME_HIGH_OFFSET          : integer        := 0;
    constant C_BOARD_NAME_LOW_OFFSET           : integer        := 4;
    constant C_BOARD_REVISION_OFFSET           : integer        := 8;
    constant C_BOARD_ID_OFFSET                 : integer        := 12;
    constant C_FIRMWARE_TYPE_OFFSET            : integer        := 16;
    constant C_FIRMWARE_MODE_OFFSET            : integer        := 20;
    constant C_FIRMWARE_ID_OFFSET              : integer        := 24;
    constant C_FIRMWARE_DATE_OFFSET            : integer        := 28;
    constant C_FIRMWARE_USERNAME_OFFSET        : integer        := 32;
    constant C_FIRMWARE_LED1_COLOR_OFFSET      : integer        := 260;
    constant C_FIRMWARE_LED2_COLOR_OFFSET      : integer        := 264;
    ---------------------------------------------------------------------------

    -- Signals
    -- AXI inout
    signal AxiSlvxD                : t_axi_lite                   := C_AXI_LITE_IDLE;
    -- AXI registers
    signal ReadM2SRegPortxD        : t_axi_read_ctrl_regfile_ms2  := C_AXI_READ_CTRL_REGFILE_M2S_IDLE;
    signal ReadS2MRegPortxD        : t_axi_read_ctrl_regfile_s2m  := C_AXI_READ_CTRL_REGFILE_S2M_IDLE;
    signal WriteM2SRegPortxD       : t_axi_write_ctrl_regfile_ms2 := C_AXI_WRITE_CTRL_REGFILE_M2S_IDLE;
    signal WriteHandshakesxD       : t_axi_write_handshakes       := C_AXI_WRITE_HANDSHAKES_IDLE;
    signal ReadStatexD             : t_read_states                := C_READ_WAITING_ON_VALID_ADDR;
    signal WriteStatexD            : t_write_states               := C_WRITE_WAITING_ON_VALID_ADDR_DATA;
    ---------------------------------------------------------------------------
    -- Registers
    ---------------------------------------------------------------------------
    signal BoardNameHighPortxD     : t_axi_register               := C_AXI_BOARD_NAME_HIGH_REGISTER;
    signal BoardNameLowPortxD      : t_axi_register               := C_AXI_BOARD_NAME_LOW_REGISTER;
    signal BoardRevisionPortxD     : t_axi_register               := C_AXI_BOARD_REVISION_REGISTER;
    signal BoardIdPortxD           : t_axi_register               := C_AXI_REGISTER_IDLE;
    signal FirmwareTypePortxD      : t_axi_register               := C_AXI_FIRMWARE_TYPE_REGISTER;
    signal FirmwareModePortxD      : t_axi_register               := C_AXI_REGISTER_IDLE;
    signal FirmwareIDPortxD        : t_axi_register               := C_AXI_FIRMWARE_ID_REGISTER;
    signal FirmwareDatePortxD      : t_axi_register               := C_AXI_FIRMWARE_DATE_REGISTER;
    signal FirmwareUsernamePortxD  : t_axi_register               := C_AXI_FIRMWARE_USERNAME_REGISTER;
    ---------------------------------------------------------------------------
    -- Output registers
    ---------------------------------------------------------------------------
    signal FirmwareLedColorPortsxD : t_axi_bunch_of_registers((C_NB_REGS_OUT - 1) downto 0) :=
        (others => C_AXI_FIRMWARE_LED_COLOR_REGISTER);
    ---------------------------------------------------------------------------

    -- Attributes
    attribute mark_debug : string;
    attribute keep       : string;
    --
    -- attribute mark_debug of : signal is "true";
    -- attribute keep of       : signal is "true";

begin

    assert C_AXI_RDATA_SIZE = C_AXI_DATA_SIZE
        report "RDATA and DATA vectors must be the same" severity failure;

    assert C_AXI_ARADDR_SIZE >= C_AXI_ADDR_SIZE
        report "ARADDR and ADDR vectors must be the same" severity failure;

    assert C_AXI_WDATA_SIZE = C_AXI_DATA_SIZE
        report "WDATA and DATA vectors must be the same" severity failure;

    assert C_AXI_AWADDR_SIZE >= C_AXI_ADDR_SIZE
        report "AWADDR and ADDR vectors must be the same" severity failure;

    IOxB : block is
    begin  -- block IOxB

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
        OutRegPortsxAS : RegPortsxDO((C_NB_REGS_OUT - 1) downto 0) <= FirmwareLedColorPortsxD;
        -----------------------------------------------------------------------

    end block IOxB;

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

    FirmwareIdRegFilexB : block is
    begin  -- block FirmwareIdRegFilexB

        RegFilexP : process (AxiSlvxD.ClockxC.ClkxC, AxiSlvxD.ResetxR.RstxRAN) is
        begin  -- process RegFilexP
            if AxiSlvxD.ResetxR.RstxRAN = '0' then  -- asynchronous reset (active low)
                ---------------------------------------------------------------
                -- Initial states
                ---------------------------------------------------------------
                ReadS2MRegPortxD        <= C_AXI_READ_CTRL_REGFILE_S2M_IDLE;
                ---------------------------------------------------------------
                BoardNameHighPortxD     <= C_AXI_BOARD_NAME_HIGH_REGISTER;
                BoardNameLowPortxD      <= C_AXI_BOARD_NAME_LOW_REGISTER;
                BoardRevisionPortxD     <= C_AXI_BOARD_REVISION_REGISTER;
                BoardIdPortxD           <= C_AXI_REGISTER_IDLE;
                FirmwareTypePortxD      <= C_AXI_FIRMWARE_TYPE_REGISTER;
                FirmwareModePortxD      <= C_AXI_REGISTER_IDLE;
                FirmwareIDPortxD        <= C_AXI_FIRMWARE_ID_REGISTER;
                FirmwareDatePortxD      <= C_AXI_FIRMWARE_DATE_REGISTER;
                FirmwareUsernamePortxD  <= C_AXI_FIRMWARE_USERNAME_REGISTER;
                FirmwareLedColorPortsxD <= (others => C_AXI_FIRMWARE_LED_COLOR_REGISTER);

            elsif rising_edge(AxiSlvxD.ClockxC.ClkxC) then  -- rising clock edge
                ---------------------------------------------------------------
                -- Update register
                ---------------------------------------------------------------
                ReadS2MRegPortxD        <= ReadS2MRegPortxD;
                ---------------------------------------------------------------
                BoardNameHighPortxD     <= BoardNameHighPortxD;
                BoardNameLowPortxD      <= BoardNameLowPortxD;
                BoardRevisionPortxD     <= BoardRevisionPortxD;
                BoardIdPortxD           <= BoardIdPortxD;
                FirmwareTypePortxD      <= FirmwareTypePortxD;
                FirmwareModePortxD      <= FirmwareModePortxD;
                FirmwareIDPortxD        <= FirmwareIDPortxD;
                FirmwareDatePortxD      <= FirmwareDatePortxD;
                FirmwareUsernamePortxD  <= FirmwareUsernamePortxD;
                FirmwareLedColorPortsxD <= FirmwareLedColorPortsxD;

                ---------------------------------------------------------------
                -- Read side
                ---------------------------------------------------------------
                if ReadM2SRegPortxD.RdValidxS = '1' then
                    case ReadM2SRegPortxD.RdAddrxD((C_REGS_ADDR_BIT_SIZE - 1) downto 0) is
                        when std_logic_vector(to_unsigned(C_BOARD_NAME_HIGH_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= BoardNameHighPortxD.RegxD;
                        when std_logic_vector(to_unsigned(C_BOARD_NAME_LOW_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= BoardNameLowPortxD.RegxD;
                        when std_logic_vector(to_unsigned(C_BOARD_REVISION_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= BoardRevisionPortxD.RegxD;
                        when std_logic_vector(to_unsigned(C_BOARD_ID_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= BoardIdPortxD.RegxD;
                        when std_logic_vector(to_unsigned(C_FIRMWARE_TYPE_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= FirmwareTypePortxD.RegxD;
                        when std_logic_vector(to_unsigned(C_FIRMWARE_MODE_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= FirmwareModePortxD.RegxD;
                        when std_logic_vector(to_unsigned(C_FIRMWARE_ID_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= FirmwareIDPortxD.RegxD;
                        when std_logic_vector(to_unsigned(C_FIRMWARE_DATE_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= FirmwareDatePortxD.RegxD;
                        when std_logic_vector(to_unsigned(C_FIRMWARE_USERNAME_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= FirmwareUsernamePortxD.RegxD;
                        when std_logic_vector(to_unsigned(C_FIRMWARE_LED1_COLOR_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= FirmwareLedColorPortsxD(0).RegxD;
                        when std_logic_vector(to_unsigned(C_FIRMWARE_LED2_COLOR_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            ReadS2MRegPortxD.RdDataxD <= FirmwareLedColorPortsxD(1).RegxD;
                        when others => ReadS2MRegPortxD.RdDataxD <= (others => '0');
                    end case;
                end if;

                ---------------------------------------------------------------
                -- Write side
                ---------------------------------------------------------------
                if WriteM2SRegPortxD.WrValidxS = '1' then
                    case WriteM2SRegPortxD.WrAddrxD((C_REGS_ADDR_BIT_SIZE - 1) downto 0) is
                        when std_logic_vector(to_unsigned(C_BOARD_ID_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            -- BoardIdPortxD.RegxD <= WriteM2SRegPortxD.WrDataxD;
                            BoardIdPortxD <=
                                axi_wr_valid_bytes(WriteM2SRegPortxD.WrDataxD, WriteM2SRegPortxD.WrStrbxD, BoardIdPortxD);
                        when std_logic_vector(to_unsigned(C_FIRMWARE_MODE_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            -- FirmwareModePortxD.RegxD <= WriteM2SRegPortxD.WrDataxD;
                            FirmwareModePortxD <=
                                axi_wr_valid_bytes(WriteM2SRegPortxD.WrDataxD, WriteM2SRegPortxD.WrStrbxD, BoardIdPortxD);
                        when std_logic_vector(to_unsigned(C_FIRMWARE_LED1_COLOR_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            -- FirmwareLedColorPortsxD(0).RegxD <= WriteM2SRegPortxD.WrDataxD;
                            FirmwareLedColorPortsxD(0) <=
                                axi_wr_valid_bytes(WriteM2SRegPortxD.WrDataxD, WriteM2SRegPortxD.WrStrbxD, BoardIdPortxD);
                        when std_logic_vector(to_unsigned(C_FIRMWARE_LED2_COLOR_OFFSET, C_REGS_ADDR_BIT_SIZE)) =>
                            -- FirmwareLedColorPortsxD(1).RegxD <= WriteM2SRegPortxD.WrDataxD;
                            FirmwareLedColorPortsxD(1) <=
                                axi_wr_valid_bytes(WriteM2SRegPortxD.WrDataxD, WriteM2SRegPortxD.WrStrbxD, BoardIdPortxD);
                        when others => null;
                    end case;
                end if;

            end if;
        end process RegFilexP;

    end block FirmwareIdRegFilexB;

end behavioral;
