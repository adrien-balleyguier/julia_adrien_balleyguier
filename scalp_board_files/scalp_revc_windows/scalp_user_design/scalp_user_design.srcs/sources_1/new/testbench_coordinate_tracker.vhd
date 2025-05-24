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
        TEST_LIMIT_Y : integer range 0 to 1024 := 10
    );
end testbench_coordinate_tracker;

architecture Behavioral of testbench_coordinate_tracker is
    component coordinate_tracker is
        Generic (
            LIMIT_X : integer range 0 to 2047 := 1024;
            LIMIT_Y : integer range 0 to 2047 := 1024
        );
        Port (
            min_re, min_im, step_re, step_im : in std_logic_vector(15 downto 0);
            nrst, get_next : in std_logic;
            z0_re, z0_im : inout std_logic_vector(15 downto 0);
            x, y : inout std_logic_vector(9 downto 0)
        );
    end component;
    signal clk, nrst, get_next : std_logic := '0';
    signal min_re, min_im, step_re, step_im, z0_re, z0_im : std_logic_vector(15 downto 0);
    signal x, y : std_logic_vector(9 downto 0) := (others => '0');
    constant CLK_PERIOD : time := 1 ns;
begin
    tracker : coordinate_tracker
        generic map(
            LIMIT_X => TEST_LIMIT_X,
            LIMIT_Y => TEST_LIMIT_Y
        )
        port map(
            min_re => min_re, min_im => min_im, step_re => step_re, step_im => step_im,
            nrst => nrst, get_next => get_next,
            z0_re => z0_re, z0_im => z0_im,
            x => x, y => y
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
        for i in 0 to (TEST_LIMIT_X*TEST_LIMIT_Y) loop
            get_next <= '0';
            wait for CLK_PERIOD;
            get_next <= '1';
            wait for CLK_PERIOD;
        end loop;
        wait; -- forever
    end process test_process;
end Behavioral;
