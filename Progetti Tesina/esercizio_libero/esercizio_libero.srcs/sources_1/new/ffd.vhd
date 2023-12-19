----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2021 17:27:42
-- Design Name: 
-- Module Name: ffd - Behavioral
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

entity ffd is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (7 downto 0);
           data : out  STD_LOGIC_VECTOR (7 downto 0);
           enable: in STD_LOGIC);
end ffd;

architecture Behavioral of ffd is

begin
process(clock, reset)
begin
    if reset = '1' then
        data <= "00000000";
    elsif rising_edge(clock) then
       if enable = '1' then
            data <= input;
       end if;
    end if;
    
end process;

end Behavioral;
