----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/30/2025 11:05:47 AM
-- Design Name: 
-- Module Name: julia_compute - Behavioral
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

entity julia_compute is
    Generic(
        NB_COMP_BLOCK : integer range 0 to 31 := 1;
        C_RE : std_logic_vector(15 downto 0) := "1111110000010000";
        C_IM : std_logic_vector(15 downto 0) := "0001011111011111"
    );
    port(
        clk, nrst : in std_logic;
        min_re, min_im, screen_h, screen_w : in std_logic_vector(15 downto 0);
        we : out std_logic;
        data_write : out std_logic;
        addr_write : out std_logic_vector(18 downto 0)
    );
end julia_compute;

architecture Behavioral of julia_compute is
    component coordinate_tracker is
        Generic(
            LIMIT_X : integer range 0 to 2047 := 720;
            LIMIT_Y : integer range 0 to 2047 := 720
        );
        port(
            min_re, min_im, screen_width, screen_height : in std_logic_vector(15 downto 0);
            nrst, get_next, clk : in std_logic;
            z0_re, z0_im : inout std_logic_vector(15 downto 0);
            pixel_index : inout std_logic_vector(18 downto 0)
        );
    end component;
    component prio_encoder is
        Generic(
            NB_COMP : integer range 0 to 31 := 1
        );
        port(
            listener : in std_logic_vector(NB_COMP-1 downto 0);
            selected : out integer range 0 to 31;
            avail : out std_logic
        );
    end component;
    component compute_encapsulate is
        port(
            nrst, clk : in std_logic;
            saved, done : inout std_logic;
            lux : out std_logic;
            c_re, c_im, z_n_re, z_n_im : in std_logic_vector(15 downto 0);
            pixel_index : inout std_logic_vector(18 downto 0)
        );
    end component;
    type z0_re_t is array(NB_COMP_BLOCK-1 downto 0) of std_logic_vector(15 downto 0);
    type z0_im_t is array(NB_COMP_BLOCK-1 downto 0) of std_logic_vector(15 downto 0);
    type pixel_t is array(NB_COMP_BLOCK-1 downto 0) of std_logic_vector(18 downto 0);
    signal done_selected, saved_selected : integer range 0 to NB_COMP_BLOCK;
    signal done_avail, saved_avail : std_logic;
    signal z0_re,  z0_im : std_logic_vector(15 downto 0);
    signal pixel_index : std_logic_vector(18 downto 0);
    signal z0_re_tab : z0_re_t;
    signal z0_im_tab : z0_im_t;
    signal pixel_tab : pixel_t;
    signal saved_tab : std_logic_vector(NB_COMP_BLOCK-1 downto 0);
    signal done_tab : std_logic_vector(NB_COMP_BLOCK-1 downto 0);
    signal lux_tab : std_logic_vector(NB_COMP_BLOCK-1 downto 0);
    signal nrst_tab : std_logic_vector(NB_COMP_BLOCK-1 downto 0);
    constant LIMIT_X : integer range 0 to 1023 := 720;
    constant LIMIT_Y : integer range 0 to 1023 := 720;
begin
    gen_compute:
    for i in 0 to NB_COMP_BLOCK generate
        computeX : compute_encapsulate
        port map(
            nrst => nrst_tab(i), clk => clk, saved => saved_tab(i), lux => lux_tab(i), done => done_tab(i),
            c_re => C_RE, c_im => C_IM, z_n_re => z0_re_tab(i), z_n_im => z0_im_tab(i),
            pixel_index => pixel_tab(i)
        );
    end generate gen_compute;
    tracker : coordinate_tracker
        generic map(LIMIT_X => LIMIT_X, LIMIT_Y => LIMIT_Y)
        port map(
            min_re => min_re, min_im => min_im, screen_width => screen_w, screen_height => screen_h,
            nrst => nrst, get_next => saved_avail, clk => clk,
            z0_re => z0_re, z0_im => z0_im,
            pixel_index => pixel_index
        );
    dispatcher : prio_encoder
        generic map(NB_COMP => NB_COMP_BLOCK)
        port map(listener => saved_tab, selected => saved_selected, avail => saved_avail);
    bram_r : prio_encoder
        generic map(NB_COMP => NB_COMP_BLOCK)
        port map(listener => done_tab, selected => done_selected, avail => done_avail);

    process(clk)
    begin
        if nrst = '1' then
            nrst_tab <= (others => '0');
        elsif rising_edge(clk) then
            if saved_avail = '1' then
                z0_re_tab(saved_selected) <= z0_re;
                z0_im_tab(saved_selected) <= z0_im;
                pixel_tab(saved_selected) <= pixel_index;
                nrst_tab <= (others => '0');
                nrst_tab(saved_selected) <= '1';
            else
                nrst_tab <= (others => '0');
            end if;
            if done_avail = '1' then
                data_write <= lux_tab(done_selected);
                addr_write <= std_logic_vector(pixel_tab(done_selected));
                we <= '1';
                saved_tab(done_selected) <= '1';
            else
                we <= '0';
            end if;
        end if;
    end process;
end Behavioral;
