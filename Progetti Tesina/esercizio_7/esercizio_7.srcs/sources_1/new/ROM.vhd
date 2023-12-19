----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.01.2022 15:48:34
-- Design Name: 
-- Module Name: ROM - Behavioral
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

entity ROM is
 generic(
        N: integer := 10;
        M: integer := 3
        );
  Port ( 
    clock: in std_logic;
    count: in integer;
    data: out std_logic_vector(0 to M-1)
  );
end ROM;

architecture Behavioral of ROM is

type rom_type is array (N-1 downto 0) of std_logic_vector(0 to M-1);
signal ROM : rom_type := (
"101", 
"000", 
"011", 
"111",
"001", 
"001",
"101", 
"010",
"011",
"001");

begin
process(clock,count)
begin
    if rising_edge(clock) then
        data <= ROM(count);
    end if;

end process;
end Behavioral;
