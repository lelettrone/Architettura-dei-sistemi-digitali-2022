----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2021 12:50:38
-- Design Name: 
-- Module Name: contatore_timer - Behavioral
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

entity contatore_timer is
    generic(
        N: integer := 5
    );
 Port (  clock: in std_Logic;
         enable : in std_logic;
         reset: in std_logic;
         timeout: out std_logic
         );
end contatore_timer;

architecture Behavioral of contatore_timer is

begin
process(clock, reset)
variable count : integer := 0;
begin
    if reset = '1' then
        count := 0;
        timeout <= '0';
    elsif rising_edge(clock) then
        if enable = '1' then
            if (count = N) then
                count := 0;
                timeout <= '1';
            else count := count +1;
                timeout <= '0';
            end if;
        else
            count := 0;
            timeout <= '0'; 
        end if;
    end if;
end process;
end Behavioral;
