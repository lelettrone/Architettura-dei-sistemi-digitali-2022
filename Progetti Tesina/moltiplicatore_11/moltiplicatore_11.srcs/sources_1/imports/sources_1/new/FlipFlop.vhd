----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2021 17:18:17
-- Design Name: 
-- Module Name: FlipFlop - Behavioral
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

entity FlipFlop is
	Port ( 
		R: in std_logic;
		Clk: in std_logic;
		D: in std_logic;
		E: in std_logic;
		Q: out std_logic
		);
end FlipFlop;

architecture Behavioral of FlipFlop is

begin
process(clk, R)
begin
	
	if(E = '1') then
		if(R = '1') then
			Q <= '0';
		elsif rising_edge(Clk) then
			Q <= D;
		end if;
	end if;
end process;

end Behavioral;
