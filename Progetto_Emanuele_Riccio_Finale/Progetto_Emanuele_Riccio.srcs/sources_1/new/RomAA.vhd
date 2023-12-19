----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2021 12:47:44
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

entity RomAA is
    generic(
        N: integer := 5
    );
port(
    CLK : in std_logic;
    RST : in std_logic;
    READ : in std_logic;
    COUNT: in integer; 
    DATA : out std_logic_vector(7 downto 0)
    );
end RomAA;

architecture behavioral of RomAA is 
type rom_type is array (0 to N-1) of std_logic_vector(7 downto 0);
type init_rom is array (0 to N-1) of std_logic_vector(7 downto 0);
signal ROM : rom_type;
signal value : init_rom := (
"11110111", 
"00000101", 
"11110111",
"11110000",
"00000001"
);

begin
process(CLK)
begin
    if rising_edge(CLK) then
        init: for i in 0 to N-1 loop
                ROM(i) <= value(i);
         end loop init;
       if(READ = '1') then
            DATA <= ROM(COUNT);
       end if;
    end if;           
end process;
end Behavioral;
