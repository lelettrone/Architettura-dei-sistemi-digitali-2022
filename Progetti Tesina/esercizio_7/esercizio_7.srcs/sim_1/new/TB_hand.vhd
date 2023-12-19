----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.12.2021 18:15:30
-- Design Name: 
-- Module Name: TB_hand - Behavioral
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
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_hand is
--  Port ( );
end TB_hand;

architecture Behavioral of TB_hand is

component Handshaking_system is
    generic(
        M: integer := 3
     );
 Port ( 
    clock_in: in std_logic;
    reset_in: std_logic;
    start: in std_logic;
    y_out: out std_logic_vector(0 to M-1)
 );
end component;

signal clk: std_logic;
signal rst: std_logic;
signal start: std_logic := '0';
signal y: std_logic_vector(0 to 2);
constant CLK_period : time := 10 ns;

begin

uut: Handshaking_system
    generic map(
        M => 3
    )
    port map(
        clock_in => clk,
        reset_in => rst,
        start => start,
        y_out => y
    );
CLK_process :process
   begin
		clk <= '0';
		wait for CLK_period/2;
		clk <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 100 ns;	

      wait for CLK_period*10; 
      
      start <= '1';
      
      wait for 50 ns;
       
      start <= '0';
      
       wait;
      
    end process;
end Behavioral;
