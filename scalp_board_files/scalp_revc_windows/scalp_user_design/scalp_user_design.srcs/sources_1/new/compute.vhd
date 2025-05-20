----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/06/2025 02:44:23 PM
-- Design Name: 
-- Module Name: compute - arch
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

entity compute is
    Generic (
        NORM_LIMIT: integer range 0 to 15 := 4;
        CNTR_ADD: integer range 0 to 1 := 1;
        CNTR_LIMIT: integer range 0 to 511 := 300
    );
    Port ( 
        clk, rst: in std_logic;
        c_re, c_im, z_n_re, z_n_im: in std_logic_vector(15 downto 0); -- 3 bits decimal
        lux, done: out std_logic;
        z_np1_re, z_np1_im: out std_logic_vector(15 downto 0) -- 3 bits decimal
    );
end compute;

architecture arch of compute is
    signal z_n_re_im: std_logic_vector(27 downto 12); -- 3 bits decimal, includes *2
    signal z_n_re_sqrd: std_logic_vector(31 downto 0); -- 6 bits decimal
    signal z_n_im_sqrd: std_logic_vector(31 downto 0); -- 6 bits decimal
    signal norm: std_logic_vector(31 downto 28); -- 4 bits decimal (full vector)
    signal z_n_sqrd_sub: std_logic_vector(16 downto 1); -- 3 bits decimal
    signal cntr: std_logic_vector(8 downto 0); -- int up to 512
    signal z_np1_im_delay: std_logic_vector(15 downto 0); -- 3 bits decimal
    -- to check : slicing does not lose the value sign
begin
    process (clk, rst)
    begin
        if rst='1' then
            cntr <= "0";
        elsif rising_edge(clk) then
            z_n_re_im <= std_logic_vector(signed(z_n_re) * signed(z_n_im));
            z_n_re_sqrd <= std_logic_vector(signed(z_n_re) * signed(z_n_re));
            z_n_im_sqrd <= std_logic_vector(signed(z_n_im) * signed(z_n_im));
            norm <= std_logic_vector(signed(z_n_re_sqrd) + signed(z_n_im_sqrd));
            z_n_sqrd_sub <= std_logic_vector(signed(z_n_re_sqrd) - signed(z_n_im_sqrd));
            cntr <= std_logic_vector(unsigned(cntr) + CNTR_ADD);
            z_np1_im_delay <= std_logic_vector(unsigned(z_n_re_im) + unsigned(c_im));
            -- out
            if (signed(norm) >= NORM_LIMIT) then
                lux <= '1';
            else
                lux <= '0';
            end if;
            z_np1_im <= z_np1_im_delay;
            z_np1_re <= std_logic_vector(signed(z_n_sqrd_sub) + signed(c_re));
            if ((signed(norm) >= NORM_LIMIT) or (unsigned(cntr) >= CNTR_LIMIT)) then
                done <= '1';
            else
                done <= '0';
            end if;
        end if;
    end process;
end arch;
