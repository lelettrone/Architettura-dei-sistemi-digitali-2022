----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 13:53:07
-- Design Name: 
-- Module Name: mux_21 - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dem_12 is
        port(X: in std_logic_vector(1 downto 0);
            s: in std_logic;
            Y0, Y1: out std_logic_vector(1 downto 0));
end dem_12;

architecture behavioral of dem_12 is

begin

    Y0 <= X when s='0' else "00";
    Y1 <= X when s='1' else "00";
    
end behavioral;
