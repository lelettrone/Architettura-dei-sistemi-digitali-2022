----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2021 17:49:05
-- Design Name: 
-- Module Name: TB_cronometroo - Behavioral
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

entity TB_cronometroo is
--  Port ( );
end TB_cronometroo;

architecture Behavioral of TB_cronometroo is

component cronometro is
    Port ( 
    clock: in std_logic;
    reset: in std_logic;
    SET: in std_logic_vector(0 to 5);
    sel_demux: in std_logic_vector(0 to 1);
    enable_set: in std_logic;
    hours: out std_logic_vector(0 to 4);
    minute: out std_logic_vector(0 to 5);
    second: out std_logic_vector(0 to 5)
 );
 end component;
 
signal CLK : std_logic;
signal RST: std_logic := '0';
signal SEL_DEMUX: std_logic_vector(0 to 1):= "00";
--signal Y: std_logic;
--signal NUMBER : std_logic_vector(0 to 5);
signal SET : std_logic_vector(0 to 5) := "000000";
constant CLK_period : time := 0.1 ns;
signal ENSET : std_logic := '0';
signal ORE: std_logic_vector(0 to 4);
signal MINUTI: std_logic_vector(0 to 5);
signal SECONDI: std_logic_vector(0 to 5);

begin

uut: cronometro
port map(
        clock => CLK,
        reset => RST,
        SET => SET,
        enable_set => ENSET,
        sel_demux => SEL_DEMUX,
        hours => ORE,
        minute => MINUTI,
        second => SECONDI
);

CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
  
stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
      ENSET <= '0';
      
      wait for 10 ns;

      -- insert stimulus here 
   
   
end process;
end Behavioral;
