----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/24/2025 09:17:42 AM
-- Design Name: 
-- Module Name: testbench_coordinate_tracker - Behavioral
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

entity testbench_coordinate_tracker is
    Generic(
        TEST_LIMIT_X : integer range 0 to 1024 := 10;
        TEST_LIMIT_Y : integer range 0 to 1024 := 10;
        TEST_MIN_RE : std_logic_vector := "1100000000000000"; -- -2
        TEST_MIN_IM : std_logic_vector := "0110000000000000"; -- -1
        TEST_STEP_RE: std_logic_vector := "0110000000000000"; -- 3
        TEST_STEP_IM: std_logic_vector := "0100000000000000" -- 2
    );
end testbench_coordinate_tracker;

architecture Behavioral of testbench_coordinate_tracker is
    component coordinate_tracker is
        Generic (
            LIMIT_X : integer range 0 to 2047 := 1024;
            LIMIT_Y : integer range 0 to 2047 := 1024
        );
        Port (
            min_re, min_im, screen_width, screen_height: in std_logic_vector(15 downto 0);
            nrst, get_next, clk : in std_logic;
            z0_re, z0_im : inout std_logic_vector(15 downto 0);
            pixel_index : inout std_logic_vector(18 downto 0)
        );
    end component;
    signal z0_re, z0_im : std_logic_vector(15 downto 0);
    signal clk, nrst, get_next : std_logic := '0';
    signal pixel_index : std_logic_vector(18 downto 0) := (others => '0');
    constant CLK_PERIOD : time := 1 ns;
begin
    tracker : coordinate_tracker
        generic map(
            LIMIT_X => TEST_LIMIT_X,
            LIMIT_Y => TEST_LIMIT_Y
        )
        port map(
            min_re => TEST_MIN_RE, min_im => TEST_MIN_IM, screen_width => TEST_STEP_RE, screen_height => TEST_STEP_IM,
            nrst => nrst, get_next => get_next, clk => clk,
            z0_re => z0_re, z0_im => z0_im,
            pixel_index => pixel_index
        );

    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process clk_process;

    rst_process: process
    begin
        nrst <= '0';
        wait for CLK_PERIOD;
        nrst <= '1';
        wait; -- forever
    end process rst_process;

    test_process: process
    begin
        wait for CLK_PERIOD;
        get_next <= '1';
        for i in 0 to (TEST_LIMIT_X*TEST_LIMIT_Y+10) loop
            wait for CLK_PERIOD;
        end loop;
        wait; -- forever
    end process test_process;
end Behavioral;
