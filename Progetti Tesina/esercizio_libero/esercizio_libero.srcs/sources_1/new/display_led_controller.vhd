----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.12.2021 18:45:54
-- Design Name: 
-- Module Name: display_led_controller - Behavioral
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

entity display_led_controller is
  Port ( 
    clock: in std_logic;
    arrow: in std_logic_vector(4 downto 0);
    score: in std_logic_vector(4 downto 0);
    result_game: in std_logic;
    enable_result: in std_logic;
    enable_digit: out std_logic_vector(7 downto 0);
    led: out std_logic_vector(2 downto 0);
    output: out std_logic_vector(39 downto 0)
  );
end display_led_controller;

architecture Behavioral of display_led_controller is

begin
process(clock)
begin
    if rising_edge(clock) then
        if(enable_result = '1') then
            if(result_game = '1') then
                led <= "001";
                enable_digit <= "11110000";
                output <= "1000010001100101001000000000000000000000";
            else 
            led <= "010";
            output <= "0000000000000000000010011100011010010101";
            enable_digit <= "00001111";
            end if;
        else 
            led <= "000";
            enable_digit <= "10000001";
            output(39 downto 35) <= score;
            output(34 downto 5) <= "000000000000000000000000000000";
            output(4 downto 0) <= arrow;
        end if;       
    end if;
end process;
end Behavioral;