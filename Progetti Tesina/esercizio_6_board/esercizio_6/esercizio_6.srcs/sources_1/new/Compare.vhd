----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2021 13:31:29
-- Design Name: 
-- Module Name: Compare - Behavioral
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

entity Compare is
  Port ( 
    clk: in std_logic;
    value1: in std_logic_vector(2 downto 0);
    value2: in std_logic_vector(2 downto 0);
    load: in std_logic;
    enable: in std_logic;
    comp: out std_logic
  );
end Compare;

architecture Behavioral of Compare is

signal value1_temp: std_logic_vector(2 downto 0);
signal value2_temp: std_logic_vector(2 downto 0);

begin
process(clk)
begin
    if rising_edge(clk) then
        if(load = '1') then
            value1_temp <= value1;
            value2_temp <= value2;
        elsif(enable = '1') then
            if((value1_temp(0) = value2_temp(0)) and (value1_temp(1) = value2_temp(1)) and (value1_temp(2) = value2_temp(2))) then
                comp <= '1';
            else comp <= '0';
            end if;
        end if;
     end if;
end process;
end Behavioral;
