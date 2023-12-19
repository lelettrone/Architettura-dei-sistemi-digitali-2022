----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2021 15:14:48
-- Design Name: 
-- Module Name: contatore - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity contatore is
    generic(
        N: integer := 2;
        L: integer := 1
    );
  Port ( 
    clk: in std_logic;
    rst: in std_logic;
    set: in std_logic_vector(0 to L-1);
    enSet: in std_logic;
    y: out std_logic;
    number: out std_logic_vector(0 to L-1);
    enable: in std_logic
  );
end contatore;

architecture Behavioral of contatore is

begin
process(clk,rst,enSet)
variable count: integer  := 0;
variable setted: integer := 0;
    begin
        if(rst = '1') then
            count := 0;
        elsif(enSet = '1') then
            count := TO_INTEGER(unsigned(set));
            setted := 1;
        elsif falling_edge (clk) then
            if(enable='1') then
                y <= '0';
                if(setted = 1 and count=N-1) then
                    y <= '1';
                    setted := 0;
                end if;
                if(count = N-2) then
                    y <= '1';
                end if;
                if(count = N-1) then
                    count := 0;
                else 
                    count := count +1;   
                end if;
            end if;
         end if;
         number <= std_logic_vector(TO_UNSIGNED(count,L));
end process;

end Behavioral;
