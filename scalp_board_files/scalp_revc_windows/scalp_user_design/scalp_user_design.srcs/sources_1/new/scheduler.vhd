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
entity scheduler is
    Port ( 
        x_screen : in std_logic;
        y_screen : in std_logic;
        screen_width : in std_logic;
        screen_height : in std_logic;
        saved : in std_logic;
        z0 : out std_logic;
        x : out std_logic;
        y :out std_logic
    );
end scheduler;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
entity coordinate_tracker is
    Generic(
        LIMIT_X : integer range 0 to 2047 := 1024;
        LIMIT_Y : integer range 0 to 2047 := 1024
    );
    Port (
        min_re, min_im, screen_width, screen_height : in std_logic_vector(15 downto 0); -- 3 bits decimal
        nrst, get_next : in std_logic;
        z0_re, z0_im : inout std_logic_vector(15 downto 0); -- 3 bits decimal
        x, y : inout std_logic_vector(9 downto 0)
    );
end coordinate_tracker;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
entity dispatcher is
    Port (
        z0_in : in std_logic;
        x_in : in std_logic;
        y_in : in std_logic
        -- setup for nb compute blocks
    );
end dispatcher;

-- architecture

architecture behave_scheduler of scheduler is

begin
end behave_scheduler;

architecture behave_coordinate_tracker of coordinate_tracker is
    signal step_re, step_im : std_logic_vector(15 downto 0);
begin
    process(nrst, get_next)
    begin
        if nrst = '0' then
            z0_re <= min_re;
            z0_im <= min_im;
            x <= (others => '0');
            y <= (others => '0');
            step_re <= std_logic_vector(unsigned(screen_width) / LIMIT_X);
            step_im <= std_logic_vector(unsigned(screen_height) / LIMIT_Y);
        elsif rising_edge(get_next) then
            if (unsigned(y) < LIMIT_Y) then
                if (unsigned(x) < (LIMIT_X-1)) then
                    x <= std_logic_vector(unsigned(x) + "1");
                    z0_re <= std_logic_vector(unsigned(z0_re) + unsigned(step_re));
                else
                    x <= (others => '0');
                    z0_re <= min_re;
                    y <= std_logic_vector(unsigned(y) + "1");
                    z0_im <= std_logic_vector(unsigned(z0_im) + unsigned(step_im));
                end if;
            end if;
        end if;
    end process;
end behave_coordinate_tracker;

architecture behave_dispatcher of dispatcher is

begin
end behave_dispatcher;


