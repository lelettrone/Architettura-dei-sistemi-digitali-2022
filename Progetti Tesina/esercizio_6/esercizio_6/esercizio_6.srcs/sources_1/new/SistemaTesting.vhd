----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2021 11:18:18
-- Design Name: 
-- Module Name: SistemaTesting - Structural
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

entity SistemaTesting is
 Port ( 
    clock_in: in std_logic;
    reset_in: in std_logic;
    start: in std_logic;
    reset_mem: in std_logic;
    test: out std_logic
 );
end SistemaTesting;

architecture Structural of SistemaTesting is

component Unita_Operativa is
    Port ( 
    clock_in: in std_logic;
    reset_in: in std_logic;
    reset_mem: in std_logic;
    read_rom: in std_logic;
    read_rom_out: in std_logic;
    write_mem_out: in std_logic;
    load: in std_logic;
    enable: in std_logic;
    enCount: in std_logic;
    fine: out std_logic;
    test: out std_logic
 );
end component;

component Unita_Controllo is
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
    fine: in std_logic;
    enable: out std_logic
  );
end component;

signal read_rom_temp: std_logic;
signal read_rom_out_temp: std_logic;
signal write_mem_out_temp: std_logic;
signal load_temp: std_logic;
signal enable_temp: std_logic;
signal reset_temp: std_logic;
signal enCount_temp: std_logic;
signal fine_temp: std_logic;

begin

UO: Unita_Operativa
    port map(
        clock_in => clock_in,
        reset_in => reset_temp,
        reset_mem => reset_mem,
        read_rom => read_rom_temp,
        read_rom_out => read_rom_out_temp,
        write_mem_out => write_mem_out_temp,
        load => load_temp,
        enable => enable_temp,
        enCount => enCount_temp,
        fine => fine_temp,
        test => test
    );
    
UC: Unita_Controllo
    port map(
        clock => clock_in,
        reset => reset_in,
        start => start,
        reset_out => reset_temp,
        read_rom => read_rom_temp,
        read_rom_out => read_rom_out_temp,
        write_mem_out => write_mem_out_temp,
        load => load_temp,
        enCount => enCount_temp,
        fine => fine_temp,
        enable => enable_temp
    );
        

end Structural;
