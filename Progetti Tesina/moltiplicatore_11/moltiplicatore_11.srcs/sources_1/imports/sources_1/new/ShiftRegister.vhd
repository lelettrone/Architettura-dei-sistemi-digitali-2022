----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2021 17:36:31
-- Design Name: 
-- Module Name: ShiftRegister - Behavioral
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

entity ShiftRegister is
	Port ( 
		clk: in std_logic;
		rst: in std_logic;
		en: in std_logic;
		data: in std_logic_vector(15 downto 0);
		y: out std_logic_vector(15 downto 0);
		v_add: in std_logic_vector(7 downto 0);
		shift: in std_logic;
		f_shift: in std_logic;
		load: in std_logic;
		load_sp: in std_logic;
		F: in std_logic
		);
end ShiftRegister;

architecture Behavioral of ShiftRegister is

signal value_temp: std_logic_vector(15 downto 0);

begin
process(clk, rst)
begin

	if(en = '1') then
		if(rst = '1') then
			value_temp <= "0000000000000000";
		elsif rising_edge(clk) then
			if(load = '1') then
				value_temp <= data;
			elsif(load_sp = '1') then
				value_temp(15 downto 8) <= v_add;
			elsif(shift = '1') then
				value_temp(14 downto 0) <= value_temp(15 downto 1);
				value_temp(15) <= F;
			elsif(f_shift = '1') then
				value_temp(14 downto 0) <= value_temp(15 downto 1);
			end if;
		end if;
	end if;

y <= value_temp; 
end process;
end Behavioral;
