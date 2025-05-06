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
-- Module Name: scalp_pwm - arch
-- Target Device: hepia-cores.ch:scalp_node:part0:0.2 xc7z015clg485-2
-- Tool version: 2023.2
-- Description: scalp_pwm
--
-- Last update: 2024-03-07
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

entity scalp_pwm is

    generic (
        C_PWM_SIZE    : integer  := 8;
        C_CLK_CNT_LEN : positive := 256);

    port (
        ClkxCI       : in  std_logic;
        RstxRANI     : in  std_logic;
        DutyCyclexDI : in  unsigned((C_PWM_SIZE - 1) downto 0);
        PwmxSO       : out std_logic);

end scalp_pwm;

architecture arch of scalp_pwm is

    signal PwmCounterxD : unsigned((C_PWM_SIZE - 1) downto 0)    := (others => '0');
    signal ClkCounterxD : integer range 0 to (C_CLK_CNT_LEN - 1) := 0;

begin

    CountxB : block is
    begin  -- block CountxB

        ClockCountxP : process (ClkxCI, RstxRANI) is
        begin  -- process ClockCountxP
            if RstxRANI = '0' then          -- asynchronous reset (active high)
                ClkCounterxD <= 0;
            elsif rising_edge(ClkxCI) then  -- rising clock edge
                if ClkCounterxD < (C_CLK_CNT_LEN - 1) then
                    ClkCounterxD <= ClkCounterxD + 1;
                else
                    ClkCounterxD <= 0;
                end if;
            end if;
        end process ClockCountxP;

    end block CountxB;

    PwmxB : block is
    begin  -- block PwmxB

        PwmOutxP : process (ClkxCI, RstxRANI) is
        begin  -- process PwmOutxP
            if RstxRANI = '0' then          -- asynchronous reset (active high)
                PwmCounterxD <= (others => '0');
                PwmxSO       <= '0';
            elsif rising_edge(ClkxCI) then  -- rising clock edge
                if (C_CLK_CNT_LEN = 1) or (ClkCounterxD = 0) then
                    PwmCounterxD <= PwmCounterxD + 1;
                    PwmxSO       <= '0';

                    if PwmCounterxD = unsigned(to_signed(-2, PwmCounterxD'length)) then
                        PwmCounterxD <= (others => '0');
                    end if;

                    if PwmCounterxD < DutyCyclexDI then
                        PwmxSO <= '1';
                    end if;
                end if;
            end if;
        end process PwmOutxP;

    end block PwmxB;

end arch;
