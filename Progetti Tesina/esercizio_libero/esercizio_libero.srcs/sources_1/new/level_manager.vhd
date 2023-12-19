----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.12.2021 15:09:30
-- Design Name: 
-- Module Name: level_manager - Behavioral
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

entity level_manager is
  Port (
    clock_div1: in std_logic;
    clock_div2: in std_logic;
    clock_div3: in std_logic;
    clock_div4: in std_logic;
    score: in std_logic_vector(4 downto 0);
    clock_out: out std_logic
   );
end level_manager;

architecture Behavioral of level_manager is

begin
process(score)
variable count: integer := 0;
begin
    count := to_integer(unsigned(score));
    if(count >=0 and count < 3) then
        clock_out <= clock_div1;
    elsif(count >= 3 and count < 6) then
        clock_out <= clock_div2;
    elsif(count >= 6 and count < 8) then
        clock_out <= clock_div3;
    elsif(count >= 8 and count < 10) then
        clock_out <= clock_div4;
    end if; 
end process;
end Behavioral;
