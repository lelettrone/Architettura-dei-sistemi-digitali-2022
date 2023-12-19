----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2021 12:10:01
-- Design Name: 
-- Module Name: TB_testing - Behavioral
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

entity TB_testing is
end TB_testing;

architecture Behavioral of TB_testing is

component SistemaTesting is
    Port ( 
    clock_in: in std_logic;
    reset_in: in std_logic;
    start: in std_logic;
    reset_mem: in std_logic;
    output: out std_logic_vector(2 downto 0);
    test: out std_logic
 );
end component;

signal clk: std_logic;
signal start: std_logic := '0';
signal reset_mem: std_logic := '0';
signal rst: std_logic := '0';
signal uscita: std_logic_vector(2 downto 0);
signal uscita_test: std_logic := '0';
--signal ing: std_logic_vector(3 downto 0);
constant CLK_period : time := 10 ns;
--signal uscita_rom_out: std_logic_vector(2 downto 0);

begin

uut: SistemaTesting
    port map(
        clock_in => clk,
        reset_in => rst,
        start => start,
        reset_mem => reset_mem,
        output => uscita,
        test => uscita_test
     );
  
-- Clock process definitions
   CLK_process :process
   begin
		clk <= '0';
		wait for CLK_period/2;
		clk <= '1';
		wait for CLK_period/2;
   end process;


stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;
      
      start <= '1';
      
      wait for 50 ns;
      
      start <= '0';
      
    
     wait;
   end process;
end Behavioral;
