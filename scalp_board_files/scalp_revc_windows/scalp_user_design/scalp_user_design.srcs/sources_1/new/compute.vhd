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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- TODO : add counter

entity compute is
    Port ( zn_re : in std_logic_vector (15 downto 0) := (others => '0');
           zn_im : in std_logic_vector (15 downto 0) := (others => '0');
           c_re : in std_logic_vector (15 downto 0) := (others => '0');
           c_im : in std_logic_vector (15 downto 0) := (others => '0');
           znp1_re : out std_logic_vector (15 downto 0) := (others => '0');
           znp1_im : out std_logic_vector (15 downto 0) := (others => '0');
           lux : out std_logic := '0';
           done : out std_logic := '0';
           x : inout std_logic_vector (9 downto 0) := (others => '0');
           y : inout std_logic_vector (9 downto 0) := (others => '0')
    );
end compute;

architecture behave_compute of compute is
    signal zn_re_sq: std_logic_vector (31 downto 0) := (others => '0');
    signal zn_im_sq: std_logic_vector (31 downto 0) := (others => '0');
    signal zn_re_im: std_logic_vector (31 downto 0) := (others => '0');
    signal zn_re_im_slice: std_logic_vector (17 downto 2) := (others => '0');
    signal zn_re_im_sub: std_logic_vector (31 downto 0) := (others => '0');
    signal zn_re_im_sub_slice: std_logic_vector (18 downto 3) := (others => '0');
    signal norm: std_logic_vector (31 downto 0) := (others => '0');
    signal norm_slice: std_logic_vector (18 downto 2) := (others => '0');
begin
    
end Behavioral;
