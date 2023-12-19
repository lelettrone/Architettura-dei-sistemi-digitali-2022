----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2021 16:49:30
-- Design Name: 
-- Module Name: demux_1_4 - Behavioral
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

entity demux_1_4 is
 Port (
    b0: in std_logic;
    s: in std_logic_vector(1 downto 0);
    y: out std_logic_vector(0 to 3)
  );
end demux_1_4;

architecture Behavioral of demux_1_4 is

begin
process (s,b0) is
begin
  
 if (s(0) ='0' and s(1) = '0') then
 y(0) <= b0;  y(1) <= '0';  y(2) <= '0';  y(3) <= '0';
 elsif (s(0) ='1' and s(1) = '0') then
 y(1) <= b0; y(0) <= '0';  y(2) <= '0';  y(3) <= '0';
 elsif (s(0) ='0' and s(1) = '1') then
 y(2) <= b0; y(0) <= '0';  y(1) <= '0';  y(3) <= '0';
 else
 y(3) <= b0; y(0) <= '0';  y(1) <= '0';  y(2) <= '0';
 end if;
 
end process;
end Behavioral;
