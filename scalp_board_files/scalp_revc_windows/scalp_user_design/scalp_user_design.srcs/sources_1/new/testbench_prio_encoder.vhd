----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2025 04:42:18 PM
-- Design Name: 
-- Module Name: testbench_prio_encoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench_prio_encoder is
    Generic(NB_COMP : integer range 0 to 31 := 10);
end testbench_prio_encoder;

architecture Behavioral of testbench_prio_encoder is
    component prio_encoder is 
        Generic (NB_COMP : integer range 0 to 31 := 1);
        port (
            listener : in std_logic_vector(NB_COMP-1  downto 0);
            selected : out integer range 0 to 31;
            avail : out std_logic
        );
    end component;
    signal listener : std_logic_vector(NB_COMP-1 downto 0);
    signal selected : integer range 0 to 31;
    signal avail : std_logic;
    constant CLK_PERIOD : time := 1 ns;
begin
    prio : prio_encoder
        generic map(NB_COMP => NB_COMP)
        port map(listener => listener, selected => selected, avail => avail);
    test_process : process
    begin
        listener <= "1001011111";
        wait for CLK_PERIOD;
        listener <= "0000011111";
        wait for CLK_PERIOD;
        listener <= "0000000000";
        wait;
    end process test_process;
end Behavioral;
