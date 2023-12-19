----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2021 12:41:44
-- Design Name: 
-- Module Name: adder - Behavioral
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

entity adder is
    generic(
        M: integer := 3
       );
  Port ( 
    clock: in std_logic;
    enable: in std_logic;
    data1: in std_logic_vector(0 to M-1);
    data2: in std_logic_vector(0 to M-1);
    somma: out std_logic_vector(0 to M-1);
    end_op: out std_logic
  );
end adder;

architecture Behavioral of adder is


begin
process(clock,enable)
variable data1_temp: integer := 0;
variable data2_temp: integer := 0;
variable somma_temp: integer;
begin
    if rising_edge(clock) then
        if(enable = '1') then   
            data1_temp := TO_INTEGER(unsigned(data1));
            data2_temp := TO_INTEGER(unsigned(data2));
            somma_temp := data1_temp + data2_temp;
            somma <= std_logic_vector(TO_UNSIGNED(somma_temp,M));
            end_op <= '1';
         end if;
    end if;
    

end process;
end Behavioral;
