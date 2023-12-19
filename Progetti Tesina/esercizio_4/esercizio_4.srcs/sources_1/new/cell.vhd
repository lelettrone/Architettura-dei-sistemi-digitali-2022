----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2021 17:00:04
-- Design Name: 
-- Module Name: cell - Behavioral
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

entity cell is 
    Port(
    ing: in std_logic;
    usc: out std_logic;
    clk: in std_logic;
    enable: in std_logic;
    rst: in std_logic
    );
end cell;

architecture Behavioral of cell is
signal lastEnable : std_logic := '0';
begin
process(clk) 
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                        usc <= '0';
            end if;
            if (enable = '1' and lastEnable = '0') then --cosi risolto il problema di sincronismo tra clock e enable
                    usc <= ing;
            end if;
            lastEnable <= enable;
        end if;
        
end process;  
    



end Behavioral;
