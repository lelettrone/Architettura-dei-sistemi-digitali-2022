----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2021 17:37:22
-- Design Name: 
-- Module Name: codec - Behavioral
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

entity codec is
        Port ( clock : in  STD_LOGIC; --CLOCK DIVISORE 0.5 S
               reset : in  STD_LOGIC;
               input : in  STD_LOGIC_VECTOR (7 downto 0);
               data : out  STD_LOGIC_VECTOR (4 downto 0);
               endSeq : out STD_LOGIC;
               enable: in STD_LOGIC);
end codec;

architecture Behavioral of codec is
begin
process(clock, reset)
variable count: integer := 0;
variable flag: integer := 0;
begin
    if reset = '1' then
        count := 0;
        endSeq <= '0';
        data <= "01010"; --SPEGNI 
    elsif rising_edge(clock) then
       if enable = '1' then
            if(flag = 1) then
                data <= "01010";
                flag := 0;
            else
                if(count > 7) then
                    endSeq <= '1';
                    count := 0;
                else endSeq <= '0';
                    if(input(count)='0' and input(count+1)='0') then
                        data <= "01100"; --SX
                        flag := 1;
                    elsif (input(count)='0' and input(count+1)='1') then
                        data <= "01101"; --DX
                        flag := 1;
                    elsif (input(count)='1' and input(count+1)='0') then
                        data <= "01110"; --DW
                        flag := 1;
                    elsif (input(count)='1' and input(count+1)='1') then
                        data <= "01111"; --UP
                        flag := 1;
                    end if; 
                   count := count + 2;
                end if;
            end if;
       end if;
    end if;
end process;


end Behavioral;
