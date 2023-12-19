----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2021 13:17:09
-- Design Name: 
-- Module Name: ROM_output - Behavioral
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

entity ROM_output is
    generic(
        N: integer := 5
    );
port(
    CLK : in std_logic;
    RST : in std_logic;
    READ : in std_logic; 
    count: in integer;
    DATA : out std_logic_vector(2 downto 0)
    );
end ROM_output;

architecture Behavioral of ROM_output is
type rom_type is array (0 to N-1) of std_logic_vector(2 downto 0);
type init_rom is array (0 to 15) of std_logic_vector(2 downto 0);
signal ROM : rom_type;
signal value : init_rom := (
"010",
"011", 
"001", --- valore errato per vedere se il flag si abbassa (doveva essere 011)
"100",
"011",
"100",
"000",
"100",
"101",
"001",
"010",
"101",
"110",
"010",
"001",
"011");


begin
process(clk)
begin
    if rising_edge(clk) then
        init: for i in 0 to N-1 loop
                ROM(i) <= value(i);
         end loop init;
       if(READ = '1') then
            DATA <= ROM(count);
       end if;
    end if;           
end process;
end Behavioral;

