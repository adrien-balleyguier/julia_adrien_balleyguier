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
    Generic(
        NB_COLOR : integer range 0 to 15 := 1
    );
    Port ( 
        nrst, clk : in std_logic;
        diverge : inout std_logic;
        c_re, c_im, z_n_re, z_n_im : in std_logic_vector(15 downto 0); -- 3 bits decimal
        z_np1_re : out std_logic_vector(15 downto 0);
        z_np1_im : out std_logic_vector(15 downto 0) -- 3 bits decimal
    );
end compute;

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity compute_encapsulate is
    Generic(
        NB_COLOR : integer range 0 to 15 := 1
    );
    Port(
        nrst, clk, saved : in std_logic;
        done : out std_logic;
        ready: out std_logic;
        lux : out std_logic_vector(NB_COLOR-1 downto 0);
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
    signal z_np1_im_delay : std_logic_vector(15 downto 0);
    constant NORM_DIVERGE : std_logic_vector(31 downto 0) := X"10000000"; -- 4 in 6 bits decimal context
begin
    process(clk, nrst)
    begin
        if (nrst = '0') then
            diverge <= '0';
        elsif rising_edge(clk) then
            if diverge = '0' then
                z_n_re_im <= std_logic_vector(signed(z_n_re) * signed(z_n_im));
                z_n_re_im_double <= z_n_re_im(27 downto 12);
                z_n_re_sqrd <= std_logic_vector(signed(z_n_re) * signed(z_n_re));
                z_n_im_sqrd <= std_logic_vector(signed(z_n_im) * signed(z_n_im));
                norm <= std_logic_vector(unsigned(z_n_re_sqrd) + unsigned(z_n_im_sqrd));
                z_n_sqrd_sub <= std_logic_vector(unsigned(z_n_re_sqrd) - unsigned(z_n_im_sqrd));
                z_n_sqrd_sub_slice <= z_n_sqrd_sub(28 downto 13);
                z_np1_im_delay <= std_logic_vector(signed(z_n_re_im_double) + signed(c_im));
                -- out
                if (unsigned(norm) >= unsigned(NORM_DIVERGE)) then
                    diverge <= '1';
                end if;
                z_np1_im <= z_np1_im_delay;
                z_np1_re <= std_logic_vector(signed(z_n_sqrd_sub_slice) + signed(c_re));
            end if;
        end if;
    end process;
end Behavioral;

architecture Behavioral_encapsulate of compute_encapsulate is
    component compute is
        generic(
            NB_COLOR : integer range 0 to 15 := 1
        );
        Port(
            nrst, clk : in std_logic;
            diverge : inout std_logic;
            c_re, c_im, z_n_re, z_n_im : in std_logic_vector(15 downto 0);
            z_np1_re, z_np1_im : out std_logic_vector(15 downto 0)
        );
    end component;
    signal z_n_re_holder, z_n_im_holder : std_logic_vector(15 downto 0);
    signal z_np1_re, z_np1_im : std_logic_vector(15 downto 0);
    signal cntr : integer range 0 to 3;
    signal cntr_iter : integer range 0 to 127;
    signal diverge : std_logic;
    constant NB_MAX_ITER : integer range 0 to 127 := 100;
    constant Z_COMPUTE_TIME : integer range 0 to 3 := 3;
begin
    comp : compute
    generic map(NB_COLOR => NB_COLOR)
    port map(
        nrst => nrst, clk => clk, diverge => diverge,
        c_re => C_RE, c_im => C_IM, z_n_re => z_n_re_holder, z_n_im => z_n_im_holder,
        z_np1_re => z_np1_re, z_np1_im => z_np1_im
    );
    process(clk, nrst)
    begin
        if (nrst = '0') then
            z_n_re_holder <= z_n_re;
            z_n_im_holder <= z_n_im;
            cntr <= 0;
            cntr_iter <= 0;
            ready <= '0';
            done <= '0';
        elsif rising_edge(clk) then
            if saved = '1' then
                ready <= '1';
            else
                cntr <= cntr + 1;
                if(cntr >= Z_COMPUTE_TIME) then
                    cntr <= 0;
                    z_n_re_holder <= z_np1_re;
                    z_n_im_holder <= z_np1_im;
                    if diverge = '1' or cntr_iter >= NB_MAX_ITER then
                        done <= '1';
                        lux <= std_logic_vector(to_unsigned((NB_MAX_ITER-cntr_iter)*15/NB_MAX_ITER, lux'length));
                    else
                        cntr_iter <= cntr_iter + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
end Behavioral_encapsulate;
