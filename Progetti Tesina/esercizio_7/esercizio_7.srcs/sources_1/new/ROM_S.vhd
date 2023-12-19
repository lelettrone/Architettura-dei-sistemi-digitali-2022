----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2021 13:08:36
-- Design Name: 
-- Module Name: ROM_S - Behavioral
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

entity ROM_S is
   generic(
        N: integer := 10;
        M: integer := 3
        );
  Port ( 
    clock: in std_logic;
    count: in integer;
    data: in std_logic_vector(0 to M-1)
  );
end ROM_S;

architecture Behavioral of ROM_S is

type rom_type is array (N-1 downto 0) of std_logic_vector(0 to M-1);
signal ROM : rom_type;

begin
process(clock,count)
begin
    if rising_edge(clock) then
        ROM(count) <= data;
    end if;
 
end process;
end Behavioral;
