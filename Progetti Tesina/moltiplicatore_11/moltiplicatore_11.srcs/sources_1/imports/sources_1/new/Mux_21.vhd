----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2021 17:01:57
-- Design Name: 
-- Module Name: Mux_21 - Behavioral
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

entity Mux_21 is
	Port ( 
		v1: in std_logic_vector(7 downto 0);
		v2: in std_logic_vector(7 downto 0);
		sel: in std_logic;
		y0: out std_logic_vector(7 downto 0)
		);
end Mux_21;

architecture Behavioral of Mux_21 is

begin

y0 <= v1 when sel = '0' else 
	  v2 when sel = '1' else
	  "--------";


end Behavioral;
