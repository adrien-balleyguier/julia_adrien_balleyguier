----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/29/2025 03:44:16 PM
-- Design Name: 
-- Module Name: bram - Behavioral
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

entity bram is
    Generic(
        ELT_SIZE : integer range 0 to 15 := 1;
        NB_ELT : integer range 0 to 524288 := 514800 -- 720x720
    );
    Port(
        clk_w, clk_r, nrst, we : in std_logic;
        addr_w, addr_r : in std_logic_vector(18 downto 0); -- log_2(720x720) = 19
        data_w : in std_logic_vector(ELT_SIZE-1 downto 0);
        data_r : out std_logic_vector(ELT_SIZE-1 downto 0)
    );
end bram;

architecture Behavioral of bram is
    type BRAM_t is array(NB_ELT-1 downto 0) of std_logic_vector(ELT_SIZE-1 downto 0);
    signal datas : BRAM_t;
begin
    write_process : process(nrst, clk_w)
    begin
        if (nrst = '0') then
        elsif rising_edge(clk_w) then
            if (we = '1') then
                datas(to_integer(unsigned(addr_w))) <= data_w;
            end if;
        end if;
    end process write_process;

    read_process : process(clk_r)
    begin
        if rising_edge(clk_r) then
            data_r <= datas(to_integer(unsigned(addr_r)));
        end if;
    end process read_process;

end Behavioral;
