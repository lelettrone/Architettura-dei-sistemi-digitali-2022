----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2021 12:40:09
-- Design Name: 
-- Module Name: Memoria - Behavioral
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

entity Memoria is
    generic(
        N: integer := 10
     );
  Port ( 
    clk: in std_logic;
    rst: in std_logic;
    enSet: in std_logic;
    head: in integer;
    TxData: in std_logic_vector(7 downto 0);
    mem_out: out std_logic_vector(7 downto 0)
  );
end Memoria;

architecture Behavioral of Memoria is

signal last_enset: std_logic := '0';

type rom_type is array (N-1 downto 0) of std_logic_vector(7 downto 0);
signal ROM_3 : rom_type := (
"00000000", 
"00000000", 
"00000000", --
"00000000", --
"00000000", --
"00000000",
"00000000", --
"00000000", --
"00000000",
"00000000");

begin
process(clk)
variable tail: integer := 0;
begin
    if rising_edge(clk) then
            ROM_3(head) <= TxData;
            if(enSet = '1' and last_enset = '0') then
            last_enset <= '1';
            mem_out <= ROM_3(tail);
            if(tail = N-1) then
                tail := 0;
            else tail := tail +1;
            end if;
            else last_enset <= '0';
         end if;
     end if;
end process;

end Behavioral;
