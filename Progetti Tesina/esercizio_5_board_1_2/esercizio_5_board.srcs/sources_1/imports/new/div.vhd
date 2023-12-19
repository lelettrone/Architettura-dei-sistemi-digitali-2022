----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2021 18:27:58
-- Design Name: 
-- Module Name: div - Behavioral
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

entity div is
generic(
clock_frequency_in : integer := 50000000;
clock_frequency_out : integer := 5000000
);
Port ( clk_in : in STD_LOGIC;
rst_in : in STD_LOGIC;
clk_out : out STD_LOGIC
);
end div;



architecture Behavioral of div is



signal clockfx : std_logic := '0';



constant count_max_value : integer := clock_frequency_in/(clock_frequency_out)-1;
signal counter : integer range 0 to count_max_value := 0;



begin



clk_out <= clockfx;
-- rst_in <= not rst_in_n;


count_for_division: process(clk_in, rst_in)
-- variable counter : integer range 0 to count_max_value := 0;



begin



if rst_in = '1' then
counter <= 0;
clockfx <= '0';
elsif rising_edge (clk_in) then
if counter = count_max_value then
clockfx <= '1';
counter <= 0;
else
clockfx <= '0';
counter <= counter + 1;
end if;
end if;



end process;




end Behavioral;
