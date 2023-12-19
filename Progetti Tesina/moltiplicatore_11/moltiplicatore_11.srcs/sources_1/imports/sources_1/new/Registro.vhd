----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2021 17:30:13
-- Design Name: 
-- Module Name: Registro - Behavioral
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

entity Registro is
	Port ( 
		Input: in std_logic_vector(7 downto 0);
		Output: out std_logic_vector(7 downto 0);
		enable: in std_logic;
		rst: in std_logic;
		clk: in std_logic
		);
end Registro;

architecture Behavioral of Registro is

begin
process(clk, rst)
begin	

		if(enable = '1') then
			if(rst = '1') then
				Output <= "00000000";
			elsif rising_edge(clk) then
				Output <= Input;
			end if;
		end if;

end process;
end Behavioral;
