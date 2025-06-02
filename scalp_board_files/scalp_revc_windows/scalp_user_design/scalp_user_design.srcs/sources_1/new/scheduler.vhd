----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2025 10:56:56 AM
-- Design Name: 
-- Module Name: scheduler - Behavioral
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
use IEEE.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- entity 
entity coordinate_tracker is
    Generic(
        LIMIT_X : integer range 0 to 2047 := 1024;
        LIMIT_Y : integer range 0 to 2047 := 1024
    );
    Port (
        min_re, min_im, screen_width, screen_height : in std_logic_vector(15 downto 0); -- 3 bits decimal
        nrst, get_next, clk : in std_logic;
        z0_re, z0_im : inout std_logic_vector(15 downto 0); -- 3 bits decimal
        pixel_index : inout std_logic_vector(18 downto 0)
    );
end coordinate_tracker;

-- architecture

architecture behave_coordinate_tracker of coordinate_tracker is
    signal step_re, step_im : std_logic_vector(15 downto 0);
    signal x, y : integer range 0 to 1024;
begin
    process(nrst, clk)
    begin
        if nrst = '0' then
            z0_re <= min_re;
            z0_im <= min_im;
            x <= 0;
            y <= 0;
            pixel_index <= (others => '0');
            step_re <= std_logic_vector(unsigned(screen_width) / LIMIT_X);
            step_im <= std_logic_vector(unsigned(screen_height) / LIMIT_Y);
        elsif rising_edge(clk) then
            if get_next = '1' then
                if (y < LIMIT_Y) then
                    if (x < (LIMIT_X-1)) then
                        x <= x+1;
                        pixel_index <= std_logic_vector(unsigned(pixel_index) + "1");
                        z0_re <= std_logic_vector(signed(z0_re) + signed(step_re));
                    else
                        x <= 0;
                        y <= y+1;
                        pixel_index <= std_logic_vector(unsigned(pixel_index) + "1");
                        z0_re <= min_re;
                        z0_im <= std_logic_vector(signed(z0_im) + signed(step_im));
                    end if;
                end if;
            end if;
        end if;
    end process;
end behave_coordinate_tracker;

