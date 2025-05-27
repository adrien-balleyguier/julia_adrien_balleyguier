----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2025 04:36:38 PM
-- Design Name: 
-- Module Name: prio_encoder - Behavioral
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

entity prio_encoder is
    Generic(
        NB_COMP : integer range 0 to 31 := 1
    );
    Port ( 
        listener : in std_logic_vector(NB_COMP-1 downto 0);
        selected : out integer range 0 to 31;
        none_avail : out std_logic
    );
end prio_encoder;

architecture Behavioral of prio_encoder is
    constant highest_listener : integer range 0 to 31 := NB_COMP-1;
begin
    process(listener)
    begin
        for i in 0 to highest_listener loop
            if (listener(i) = '1') then
                selected <= i;
            end if;
            if (unsigned(listener) = 0) then
                none_avail <= '0';
            else
                none_avail <= '1';
            end if;
        end loop;
    end process;
end Behavioral;
