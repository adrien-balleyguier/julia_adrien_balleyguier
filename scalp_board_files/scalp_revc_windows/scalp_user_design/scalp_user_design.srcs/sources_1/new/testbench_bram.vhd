----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2025 04:45:26 PM
-- Design Name: 
-- Module Name: testbench_bram - Behavioral
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

entity testbench_bram is
    generic(
        TEST_ELT_SIZE : integer range 0 to 15 := 10;
        TEST_NB_ELT : integer range 0 to 524288 := 15
    );
end testbench_bram;

architecture Behavioral of testbench_bram is
    component bram is
        Generic(
            ELT_SIZE : integer range 0 to 15 := 1;
            NB_ELT : integer range 0 to 52288 := 514800 -- 720x720
        );
        Port(
            clk_w, clk_r, nrst, we, re : in std_logic := '0';
            addr_w, addr_r : in std_logic_vector(18 downto 0) := (others => '0');
            data_w : in std_logic_vector(ELT_SIZE-1 downto 0) := (others => '0');
            data_r : out std_logic_vector(ELT_SIZE-1 downto 0) := (others => '0')
        );
    end component;
    signal clk_w, clk_r, nrst, we, re : std_logic;
    signal addr_w, addr_r : std_logic_vector(18 downto 0);
    signal data_w, data_r : std_logic_vector(TEST_ELT_SIZE-1 downto 0);
    constant CLK_W_PERIOD : time := 3 ns;
    constant CLK_R_PERIOD : time := 2 ns;
begin
    bram_instance : bram
        generic map(ELT_SIZE => TEST_ELT_SIZE, NB_ELT => TEST_NB_ELT)
        port map(
            clk_w => clk_w, clk_r => clk_r, nrst => nrst, we => we, re => re,
            addr_w => addr_w, addr_r => addr_r,
            data_w => data_w, data_r => data_r
        );
    clk_w_process : process
    begin
        clk_w <= '0';
        wait for CLK_W_PERIOD/2;
        clk_w <= '1';
        wait for CLK_W_PERIOD/2;
    end process clk_w_process;
    clk_r_process : process
    begin
        clk_r <= '0';
        wait for CLK_R_PERIOD/2;
        clk_r <= '1';
        wait for CLK_R_PERIOD/2;
    end process clk_r_process;

    rst_process : process
    begin
        nrst <= '0';
        wait for CLK_W_PERIOD;
        nrst <= '1';
        wait;
    end process rst_process;

    test_w_process : process
    begin
        wait for CLK_W_PERIOD;
        addr_w <= "0000000000000000010";
        data_w <= "0010001010";
        we <= '1';
        wait for CLK_W_PERIOD;
        we <= '0';
        addr_w <= "0000000000000000011";
        data_w <= "0000101001";
        wait;
    end process test_w_process;

    test_r_process : process
    begin
        wait for CLK_W_PERIOD;
        wait for CLK_R_PERIOD;
        addr_r <= "0000000000000000010";
        re <= '1';
        wait for CLK_R_PERIOD;
        re <= '0';
        addr_r <= "0000000000000000011";
        wait;
    end process test_r_process;

end Behavioral;
