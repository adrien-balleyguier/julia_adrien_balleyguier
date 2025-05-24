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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- entity 
entity scheduler is
    Port ( x_screen : in std_logic;
           y_screen : in std_logic;
           screen_width : in std_logic;
           screen_height : in std_logic;
           saved : in std_logic;
           z0 : out std_logic;
           x : out std_logic;
           y :out std_logic);
end scheduler;

entity screen_dim_extractor is
    Port (
        x_screen : in std_logic;
        y_screen : in std_logic;
        screen_width : in std_logic;
        screen_height : in std_logic;
        step_re : out std_logic;
        std_im : out std_logic
    );
end screen_dim_extractor;

entity coordinate_tracker is
    Port (
        step_re : in std_logic;
        step_im : in std_logic;
        rst : in std_logic;
        get_next : in std_logic;
        z0 : out std_logic;
        x : out std_logic;
        y : out std_logic
    );
end coordinate_tracker;

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

architecture behave_screen_dim_extractor of screen_dim_extractor is

begin
end behave_screen_dim_extractor;

architecture behave_coordinate_tracker of coordinate_tracker is

begin
end behave_coordinate_tracker;

architecture behave_dispatcher of dispatcher is

begin
end behave_dispatcher;


