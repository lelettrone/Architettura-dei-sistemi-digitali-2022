----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2021 12:42:18
-- Design Name: 
-- Module Name: manager - Behavioral
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

entity manager is
 Port (
    clock: in std_logic;
    cronoVec: in std_logic_vector(0 to 16);
    interVec: in std_logic_vector(0 to 16);
    displayOut: out std_logic_vector(0 to 16);
    sel: in std_logic
  );
end manager;

architecture Behavioral of manager is

begin
process(clock)
begin
    if rising_edge(clock) then
        if(sel = '1') then
            displayOut <= interVec;
        else displayOut <= cronoVec;
        end if;
     end if;   
end process;
end Behavioral;
