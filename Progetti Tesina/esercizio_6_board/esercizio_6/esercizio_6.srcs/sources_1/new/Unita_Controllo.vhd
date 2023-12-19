----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.12.2021 12:53:54
-- Design Name: 
-- Module Name: Unita_Controllo - Behavioral
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

entity Unita_Controllo is
  Port ( 
    clock: in std_logic;
    reset: in std_logic;
    start: in std_logic;
    reset_out: out std_logic;
    read_rom: out std_logic;
    read_rom_out: out std_logic;
    write_mem_out: out std_logic;
    load: out std_logic;
    enCount: out std_logic;
    read: in std_logic;
    fine: in std_logic;
    enable: out std_logic
  );
end Unita_Controllo;

architecture Behavioral of Unita_Controllo is

type stato is (idle,readROM,acquisition,compare,memorization,endtest, increase);
signal stato_corrente : stato := idle;

signal last_read: std_logic;
signal last_start: std_logic;

begin
process(clock, reset)
begin
	if(reset = '1') then
		stato_corrente <= idle;
	end if;
	if rising_edge(clock) then
	   case stato_corrente is 
	   when idle =>
	       reset_out <= '1';
	       read_rom <= '0';
	       read_rom_out <= '0';
	       write_mem_out <= '0';
	       load <= '0';
	       enCount <= '0';
	       enable <= '0';
	       if(start = '1' and last_start = '0') then
	       		last_start <= '1';
	          stato_corrente <= readROM;
	       else 
	       		last_start <= '0';
	       		stato_corrente <= idle;
	       end if;
	   when readROM =>
	       reset_out <= '0';
	       write_mem_out <= '0';
	       load <= '0';
	       enCount <= '0';
	       enable <= '0';
	       if(read = '1' and last_read = '0') then
	       	 last_read <= '1';
		       read_rom <= '1';
		       read_rom_out <= '1';
		       stato_corrente <= acquisition;
		     else
		     	 last_read <= '0';
		     	 stato_corrente <= readROM;
		     end if;
	   when acquisition =>
	       reset_out <= '0';
	       read_rom <= '0';
	       read_rom_out <= '0';
	       write_mem_out <= '0';
	       load <= '1';
	       enCount <= '0';
	       enable <= '0';
	       stato_corrente <= compare;
	   when compare =>
	       reset_out <= '0';
	       read_rom <= '0';
	       read_rom_out <= '0';
	       write_mem_out <= '0';
	       load <= '0';
	       enCount <= '0';
	       enable <= '1';
	       stato_corrente <= memorization;
	   when memorization =>
	       reset_out <= '0';
	       read_rom <= '0';
	       read_rom_out <= '0';
	       write_mem_out <= '1';
	       load <= '0';
	       enCount <= '1';
	       enable <= '0';
	       stato_corrente <= increase;
	    when increase =>
	       reset_out <= '0';
	       read_rom <= '0';
	       read_rom_out <= '0';
	       write_mem_out <= '0';
	       load <= '0';
	       enCount <= '1'; --INCREMENTA IL VALORE DI COUNT
	       enable <= '0';
	       stato_corrente <= endtest;
	    when endtest =>
	       reset_out <= '0';
	       read_rom <= '0';
	       read_rom_out <= '0';
	       write_mem_out <= '0';
	       load <= '0';
	       enCount <= '0';
	       enable <= '0';
	       if(fine = '1') then 
	           stato_corrente <= idle;
	       else stato_corrente <= readROM;
	       end if;
	    end case;
	  end if;
end process;
end Behavioral;
