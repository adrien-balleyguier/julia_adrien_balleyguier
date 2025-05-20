----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/20/2025 03:47:00 PM
-- Design Name: 
-- Module Name: coordinate_tracker - Behavioral
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

entity coordinate_tracker is
    Generic(
        LIMIT_X: integer range 0 to 2047 := 1024;
        LIMIT_Y: integer range 0 to 2047 := 1024
    );
    Port ( 
        min_re, min_im, step_re, step_im : std_logic_vector(15 downto 0); -- 3 bits decimal
        rst, get_next : in std_logic;
        z0_re, z0_im : out std_logic_vector(15 downto 0); -- 3 bits decimal
        x, y : out std_logic_vector(9 downto 0)
    );
end coordinate_tracker;

architecture arch of coordinate_tracker is
    signal tmp_z0_re, tmp_z0_im : std_logic_vector(15 downto 0); -- 3 bits decimal
    signal tmp_x, tmp_y : std_logic_vector(9 downto 0);
begin
    process(rst, get_next)
    begin
        if (rst = '1') then
            z0_re <= min_re;
            tmp_z0_re <= min_re;
            z0_im <= min_im;
            tmp_z0_im <= min_im;
            tmp_x <= "0";
            x <= "0";
            tmp_y <= "0";
            y <= "0";
        elsif rising_edge(get_next) then
            if (unsigned(tmp_y) < LIMIT_Y) then
                z0_re <= tmp_z0_re;
                z0_im <= tmp_z0_im;
                x <= tmp_x;
                y <= tmp_y;
                if (unsigned(tmp_x) < LIMIT_X) then
                    tmp_x <= std_logic_vector(signed(tmp_x) + 1);
                    tmp_z0_re  <= std_logic_vector(unsigned(tmp_z0_re) + unsigned(step_re));
                else
                    tmp_x <= "0";
                    tmp_z0_re <= min_re;
                    tmp_y <= std_logic_vector(signed(tmp_y) + 1);
                    tmp_z0_im <= std_logic_vector(unsigned(tmp_z0_im) + unsigned(step_im));
                end if;
            end if;
        end if;
    end process;
end arch;
