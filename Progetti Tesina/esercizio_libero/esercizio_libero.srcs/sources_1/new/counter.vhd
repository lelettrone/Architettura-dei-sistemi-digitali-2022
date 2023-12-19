----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2021 18:54:08
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
 Port (  clock: in std_Logic;
         enable : in std_logic;
         reset: in std_logic;
         topscore: out std_logic;
         output: out std_logic_vector(4 downto 0));
 
end counter;

architecture Behavioral of counter is

begin
process(clock, reset)
variable count : integer := 0;
begin
    if reset = '1' then
        count := 0;
        topscore <= '0';
    elsif rising_edge(clock) then
        if enable = '1' then
            if (count = 8) then
                topscore <= '1';
                count := count +1;
            elsif (count = 9) then
                count := 0;
            else count := count +1;
                topscore <= '0';
            end if;  
        end if;
    end if;
    output <= std_logic_vector(TO_UNSIGNED(count,5));
end process;



end Behavioral;
