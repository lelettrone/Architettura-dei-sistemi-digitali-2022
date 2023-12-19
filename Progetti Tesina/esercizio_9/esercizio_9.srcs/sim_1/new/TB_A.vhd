----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2021 17:59:07
-- Design Name: 
-- Module Name: TB_A - Behavioral
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

entity TB_A is
--  Port ( );
end TB_A;

architecture Behavioral of TB_A is

component SystemA is
    Port ( 
    clock: in std_logic;
    reset: in std_logic;
    input: in std_logic_vector( 0 to 7);
    write: in std_logic;
    --read: in std_logic;
    output: out std_logic
  );
end component;

signal clk: std_logic;
constant CLK_period : time := 37.593984962406 ns;
signal rst: std_logic := '0';
signal ingresso: std_logic_vector(0 to 7) := "00101001";
signal w: std_logic;
signal uscita: std_logic;
--signal rd: std_logic;

begin

uut: SystemA 
    port map(
        clock => clk,
        reset => rst,
        input => ingresso,
        write => w,
        --read => rd,
        output => uscita
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;
      
        w<='0';
        --rd <= '0';
		wait for CLK_period;
		 w<='1';
        --rd <= '0';
		wait for CLK_period;
		 w<='0';
        --rd <= '0';
		wait for CLK_period;
		
		
      wait;
   end process;


end Behavioral;
