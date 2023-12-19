----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2022 15:43:11
-- Design Name: 
-- Module Name: TB_riconoscitore_seq - Behavioral
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

entity TB_riconoscitore_seq is
--  Port ( );
end TB_riconoscitore_seq;

architecture Behavioral of TB_riconoscitore_seq is

component riconoscitore_seq 
    port(
         clk: in std_logic;
         m: in std_logic;
         x: in std_logic;
         y: out std_logic
 );
end component; 

--Inputs
   signal x : std_logic := '0';
   signal clk: std_logic := '0';
   signal m: std_logic := '1';

 	--Outputs
   signal y : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	-- qui specifico quale architecture simulare di quelle definite
   uut: riconoscitore_seq port map(
          x => x,
          clk => clk,
          m => m,
          y => y
        );

   -- Clock process definitions
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

      -- insert stimulus here 
		x<='0';
		wait for 10 ns;
		x<='1';
		wait for 10 ns;
		x<='0';
		wait for 10 ns;
		x<='0';
		wait for 10 ns;
		x<='1';
		wait for 10 ns;
		x<='0';
		wait for 10 ns;
		x<='1';
		
      wait;
   end process;
   
end Behavioral;
