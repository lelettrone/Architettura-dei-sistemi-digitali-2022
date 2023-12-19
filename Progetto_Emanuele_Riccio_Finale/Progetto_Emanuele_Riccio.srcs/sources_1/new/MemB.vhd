----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2021 13:20:55
-- Design Name: 
-- Module Name: Mem_output - Behavioral
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

entity MemB is
    generic(
        N: integer := 5
    );
  Port ( 
    VOUT : out std_logic_vector(7 downto 0);
    clock: in std_logic;
    reset: in std_logic;
    write: in std_logic;
    count: in integer;
    value: in std_logic_vector(7 downto 0) 
  );
end MemB;

architecture Behavioral of MemB is

type mem_type is array (0 to N-1) of std_logic_vector(7 downto 0);
signal MEM : mem_type;

signal last_read: std_logic;

begin
process(clock)
begin
    if rising_edge(clock) then
        if(reset = '1') then
            init: for i in 0 to N-1 loop
                MEM(i) <= "--------";
         end loop init;
        end if;
        if(write = '1') then
            MEM(count) <= value;
            VOUT <= value;
       end if;
    end if;           

end process;
end Behavioral;
