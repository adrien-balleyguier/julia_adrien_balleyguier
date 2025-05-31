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
        done : inout std_logic;
        lux: out std_logic;
        c_re, c_im, z_n_re, z_n_im : in std_logic_vector(15 downto 0); -- 3 bits decimal
        z_np1_re : out std_logic_vector(15 downto 0);
        z_np1_im : out std_logic_vector(15 downto 0) -- 3 bits decimal
    );
end compute;

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity compute_encapsulate is
    Port(
        nrst, clk, saved : in std_logic;
        done : inout std_logic;
        ready, lux : out std_logic;
        c_re, c_im, z_n_re, z_n_im : in std_logic_vector(15 downto 0)
    );
end compute_encapsulate;

architecture Behavioral of compute is
    signal z_n_re_im : std_logic_vector(31 downto 0); -- 6 bits decimal
    signal z_n_re_im_double : std_logic_vector(15 downto 0); -- 3 bits decimal, includes x2
    signal z_n_re_sqrd : std_logic_vector(31 downto 0); -- 6 bits decimal
    signal z_n_im_sqrd : std_logic_vector(31 downto 0); -- 6 bits decimal
    signal norm : std_logic_vector(31 downto 0); 
    signal z_n_sqrd_sub : std_logic_vector(31 downto 0);
    signal z_n_sqrd_sub_slice : std_logic_vector(15 downto 0); -- 3 bits decimal
    signal cntr : std_logic_vector(8 downto 0);
    signal z_np1_im_delay : std_logic_vector(15 downto 0);
    constant NORM_DIVERGE : std_logic_vector(31 downto 0) := X"10000000"; -- 4 in 6 bits decimal context
    constant CNTR_LIMIT : integer range 0 to 511 := 300;
begin
    process(clk, nrst)
    begin
        if (nrst = '0') then
            cntr <= (others => '0');
            done <= '0';
        elsif rising_edge(clk) then
            if done = '0' then
                z_n_re_im <= std_logic_vector(signed(z_n_re) * signed(z_n_im));
                z_n_re_im_double <= z_n_re_im(27 downto 12);
                z_n_re_sqrd <= std_logic_vector(signed(z_n_re) * signed(z_n_re));
                z_n_im_sqrd <= std_logic_vector(signed(z_n_im) * signed(z_n_im));
                norm <= std_logic_vector(unsigned(z_n_re_sqrd) + unsigned(z_n_im_sqrd));
                z_n_sqrd_sub <= std_logic_vector(unsigned(z_n_re_sqrd) - unsigned(z_n_im_sqrd));
                z_n_sqrd_sub_slice <= z_n_sqrd_sub(28 downto 13);
                cntr <= std_logic_vector(unsigned(cntr) + "1");
                z_np1_im_delay <= std_logic_vector(signed(z_n_re_im_double) + signed(c_im));
                -- out
                if (unsigned(norm) >= unsigned(NORM_DIVERGE)) then
                    lux <= '1';
                    done <= '1';
                else
                    lux <= '0';
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

architecture Behavioral_encapsulate of compute_encapsulate is
    component compute is
        Port(
            nrst, clk : in std_logic;
            done : inout std_logic;
            lux : out std_logic;
            c_re, c_im, z_n_re, z_n_im : in std_logic_vector(15 downto 0);
            z_np1_re, z_np1_im : out std_logic_vector(15 downto 0)
        );
    end component;
    signal z_n_re_holder, z_n_im_holder : std_logic_vector(15 downto 0);
    signal z_np1_re, z_np1_im : std_logic_vector(15 downto 0);
    signal cntr : std_logic_vector(2 downto 0);
    constant Z_COMPUTE_TIME : integer range 0 to 3 := 2;
begin
    comp : compute
    port map(
        nrst => nrst, clk => clk, lux => lux, done => done,
        c_re => C_RE, c_im => C_IM, z_n_re => z_n_re_holder, z_n_im => z_n_im_holder,
        z_np1_re => z_np1_re, z_np1_im => z_np1_im
    );
    process(clk, nrst)
    begin
        if (nrst = '0') then
            z_n_re_holder <= z_n_re;
            z_n_im_holder <= z_n_im;
            cntr <= (others => '0');
            ready <= '0';
        elsif rising_edge(clk) then
            if saved = '1' then
                ready <= '1';
            else
                cntr <= std_logic_vector(unsigned(cntr) + "1");
                if(unsigned(cntr) >= Z_COMPUTE_TIME) then
                    cntr <= (others => '0');
                    z_n_re_holder <= z_np1_re;
                    z_n_im_holder <= z_np1_im;
                end if;
            end if;
        end if;
    end process;
end Behavioral_encapsulate;
