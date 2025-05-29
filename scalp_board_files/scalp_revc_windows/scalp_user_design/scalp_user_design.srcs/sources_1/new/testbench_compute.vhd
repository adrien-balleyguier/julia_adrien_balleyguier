----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/26/2025 10:43:26 AM
-- Design Name: 
-- Module Name: testbench_compute - Behavioral
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

entity testbench_compute is
    generic(
        C_RE : std_logic_vector(15 downto 0) := "1111110000010000"; -- -0.123
        C_IM : std_logic_vector(15 downto 0) := "0001011111011111"; -- +0.745
        NB_ITER_MAX : integer range 0 to 127 := 127; -- computation goes to 100, going a bit more to check behaviour
        -- expecting test_A to diverge directly
        TEST_A_RE : std_logic_vector(15 downto 0) := "0100000000000000"; -- -2
        TEST_A_IM : std_logic_vector(15 downto 0) := "1100000000000000"; -- +2
        -- expecting test_B to converge
        TEST_B_RE : std_logic_vector(15 downto 0) := "0000000000000000"; -- 0
        TEST_B_IM : std_logic_vector(15 downto 0) := "0000000000000000"; -- 0
        -- expecting test_C to diverge around 50 iterations
        TEST_C_RE : std_logic_vector(15 downto 0) := "0000110000011101"; -- 0.3785400390625
        TEST_C_IM : std_logic_vector(15 downto 0) := "1111100110011111"; -- -0.1993408203125
        -- expecting test_D to diverge around 95 iterations
        TEST_D_RE : std_logic_vector(15 downto 0) := "1111100001110010"; -- -0.236083984375
        TEST_D_IM : std_logic_vector(15 downto 0) := "1111011110010011" -- -0.2633056640625
    );
end testbench_compute;

architecture Behavioral of testbench_compute is
    component compute is 
        port(
            nrst, clk : in std_logic;
            done : inout std_logic;
            lux: out std_logic;
            c_re, c_im, z_n_re, z_n_im : in std_logic_vector(15 downto 0);
            z_np1_re, z_np1_im : out std_logic_vector(15 downto 0)
        );
    end component;
    signal nrst, clk, saved, lux, done : std_logic;
    signal z_n_re, z_n_im, z_np1_re, z_np1_im : std_logic_vector(15 downto 0);
    constant CLK_PERIOD : time := 1 ns;
begin
    comp : compute
    port map(
        nrst => nrst, clk => clk, lux => lux, done => done,
        c_re => C_RE, c_im => C_IM, z_n_re => z_n_re, z_n_im => z_n_im,
        z_np1_re => z_np1_re, z_np1_im => z_np1_im
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
        wait; -- forever
    end process rst_process;

    test_process : process
    begin
        wait for CLK_PERIOD;
        z_n_re <= TEST_B_RE;
        z_n_im <= TEST_B_IM;
        for i in 0 to NB_ITER_MAX loop
            wait for CLK_PERIOD;
            wait for CLK_PERIOD;
            wait for CLK_PERIOD;
            z_n_re <= z_np1_re;
            z_n_im <= z_np1_im;
        end loop;
        wait;
    end process test_process;
end Behavioral;
