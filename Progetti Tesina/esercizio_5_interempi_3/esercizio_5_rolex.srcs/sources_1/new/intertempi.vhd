----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2021 12:42:18
-- Design Name: 
-- Module Name: intertempi - Behavioral
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

entity intertempi is
  Port ( 
    clk: in std_logic;
    rst: in std_logic;
    enSet: in std_logic;
    memSet: in std_logic;
    crono: in std_logic_vector(0 to 16);
    interOut: out std_logic_vector(0 to 16)
  );
end intertempi;

architecture Behavioral of intertempi is

signal last_enset: std_logic := '0';

type rom_type is array (7 downto 0) of std_logic_vector(16 downto 0);
signal ROM : rom_type;
signal lastMemSet : std_logic;
begin
process(clk)
variable head : integer := 0;
variable tail: integer := 0;
begin
    if rising_edge(clk) then
        if(memSet='1' and lastMemSet='0') then
            ROM(head) <= crono;
            if(head = 7) then
                head := 0;
            else head := head +1;
            end if;
        end if;
        if(enSet = '1' and last_enset = '0') then
            last_enset <= '1';
            interOut <= ROM(tail);
            if(tail = 7) then
                tail := 0;
            else tail := tail +1;
            end if;
         else last_enset <= '0';
         end if;
         lastMemSet <= memSet;
     end if;
end process;

end Behavioral;
