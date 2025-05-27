----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2025 11:22:43 AM
-- Design Name: 
-- Module Name: compute - Behavioral
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

entity compute is
    Port ( 
        nrst, clk : in std_logic;
        saved, done : inout std_logic;
        lux: out std_logic;
        c_re, c_im, z_n_re, z_n_im : in std_logic_vector(15 downto 0); -- 3 bits decimal
        x, y : inout std_logic_vector(9 downto 0);
        watcher : inout std_logic_vector(31 downto 0);
        watcher_2 : out std_logic_vector(15 downto 0);
        z_np1_re : out std_logic_vector(15 downto 0);
        z_np1_im : out std_logic_vector(15 downto 0) -- 3 bits decimal
    );
end compute;

architecture Behavioral of compute is
    signal z_n_re_im : std_logic_vector(31 downto 0); -- 6 bits decimal
    signal z_n_re_im_double : std_logic_vector(15 downto 0); -- 3 bits decimal, includes x2
    signal z_n_re_sqrd : std_logic_vector(31 downto 0); -- 6 bits decimal
    signal z_n_im_sqrd : std_logic_vector(31 downto 0); -- 6 bits decimal
    signal norm : std_logic_vector(5 downto 0); 
    signal z_n_sqrd_sub : std_logic_vector(31 downto 0);
    signal z_n_sqrd_sub_slice : std_logic_vector(15 downto 0); -- 3 bits decimal
    signal cntr : std_logic_vector(8 downto 0);
    signal z_np1_im_delay : std_logic_vector(15 downto 0);
    constant NORM_DIVERGE : integer range 0 to 7 := 4;
    constant CNTR_LIMIT : integer range 0 to 511 := 300;
begin
    process(clk, nrst)
    begin
        if (nrst = '0') then
            cntr <= (others => '0');
        elsif rising_edge(clk) then
            if not (done = '1') then
                z_n_re_im <= std_logic_vector(signed(z_n_re) * signed(z_n_im));
                z_n_re_im_double <= z_n_re_im(27 downto 12);
                watcher <= std_logic_vector(signed(z_n_re) * signed(z_n_im));
                watcher_2<= z_n_re_im_double;
                z_n_re_sqrd <= std_logic_vector(signed(z_n_re) * signed(z_n_re));
                z_n_im_sqrd <= std_logic_vector(signed(z_n_im) * signed(z_n_im));
                norm <= std_logic_vector(unsigned(z_n_re_sqrd) + unsigned(z_n_im_sqrd));
                z_n_sqrd_sub <= std_logic_vector(unsigned(z_n_re_sqrd) - unsigned(z_n_im_sqrd));
                z_n_sqrd_sub_slice <= z_n_sqrd_sub(31 downto 16);
                cntr <= std_logic_vector(unsigned(cntr) + "1");
                z_np1_im_delay <= std_logic_vector(signed(z_n_re_im_double) + signed(c_im));
                -- out
                if (unsigned(norm) >= NORM_DIVERGE) then
                    lux <= '0';
                    done <= '1';
                else
                    lux <= '1';
                    if (unsigned(cntr) >= CNTR_LIMIT) then
                        done <= '1';
                    else
                        done <= '0';
                    end if;
                end if;
                z_np1_im <= z_np1_im_delay;
                z_np1_re <= std_logic_vector(signed(z_n_sqrd_sub_slice) + signed(c_re));
            end if;
        end if;
    end process;
end Behavioral;
