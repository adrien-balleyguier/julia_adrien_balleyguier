----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/30/2025 03:30:43 PM
-- Design Name: 
-- Module Name: testbench_julia_compute - Behavioral
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

entity testbench_julia_compute is
    Generic(
        NB_COLOR : integer range 0 to 15 := 4;
        NB_COMP_BLOCK : integer range 0 to 31 := 16;
        C_RE : std_logic_vector(15 downto 0) := "1111110000010000"; -- -0.123
        C_IM : std_logic_vector(15 downto 0) := "0001011111011111"; -- +0.745
        MIN_RE : std_logic_vector(15 downto 0) := "0000000000000000"; -- -2
        MIN_IM : std_logic_vector(15 downto 0) := "0000000000000000"; -- +1
        SCREEN_H : std_logic_vector(15 downto 0) := "0100000000000000"; -- 2
        SCREEN_W : std_logic_vector(15 downto 0) := "0110000000000000" -- 3
    );
end testbench_julia_compute;

architecture Behavioral of testbench_julia_compute is
    component julia_compute is
        Generic(
            NB_COLOR : integer range 0 to 15 := 1;
            NB_COMP_BLOCK : integer range 0 to 31 := 1;
            LIMIT_X : integer range 0 to 2047 := 720;
            LIMIT_Y : integer range 0 to 2047 := 720;
            C_RE : std_logic_vector(15 downto 0) := "1111110000010000"; -- -0.123
            C_IM : std_logic_vector(15 downto 0) := "0001011111011111" -- +0.745
        );
        port(
            clk, nrst : in std_logic;
            min_re, min_im, screen_h, screen_w : in std_logic_vector(15 downto 0);
            we : out std_logic;
            data_write : out std_logic_vector(NB_COLOR-1 downto 0);
            addr_write : out std_logic_vector(18 downto 0)
        );
    end component;
    signal nrst, clk : std_logic;
    signal we : std_logic := '0';
    signal data_write : std_logic_vector(NB_COLOR-1 downto 0);
    signal addr_write : std_logic_vector(18 downto 0);
    constant LIMIT_X : integer range 0 to 2047 := 720;
    constant LIMIT_Y : integer range 0 to 2047 := 720;
    constant NB_MAX_ITER : integer range 0 to 1023 := 700;
    constant CLK_PERIOD : time := 1 ns;
begin
    julia_compute_instance : julia_compute
        generic map(
            NB_COLOR => NB_COLOR, NB_COMP_BLOCK => NB_COMP_BLOCK, LIMIT_X => LIMIT_X, LIMIT_Y => LIMIT_Y,
            C_RE => C_RE, C_IM => C_IM
        )
        port map(
            clk => clk, nrst => nrst,
            min_re => MIN_RE, min_im => MIN_IM, screen_h => SCREEN_H, screen_w => SCREEN_W,
            we => we,
            data_write => data_write,
            addr_write => addr_write
        );
    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process clk_process;

    rst_process : process
    begin
        nrst <= '0';
        wait for CLK_PERIOD;
        nrst <= '1';
        wait;
    end process rst_process;

    test_process : process
    begin
        wait for CLK_PERIOD;
        wait;
    end process test_process;
end Behavioral;
