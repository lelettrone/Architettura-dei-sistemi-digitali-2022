----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2021 16:00:47
-- Design Name: 
-- Module Name: TB_contatore - Behavioral
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

entity TB_contatore is
--  Port ( );
end TB_contatore;

architecture Behavioral of TB_contatore is

component contatore is
    generic(
            N : integer := 24;
            L : integer := 5
         );
    port(
        clk: in std_logic;
        rst: in std_logic;
        set: in std_logic_vector(0 to L-1);
        enSet: in std_logic;
        y: out std_logic;
        number: out std_logic_vector(0 to L-1)
     );
 end component;

signal CLK : std_logic;
signal RST: std_logic := '0';
signal SET : std_logic_vector(0 to 5) := "110101";
constant CLK_period : time := 0.1 ns;
signal ENSET : std_logic := '0';
signal Y: std_logic;
signal NUMBER: std_logic_vector(0 to 5);

begin
uut: contatore
    generic map(
        N => 60,
        L => 6
        )
port map(
        clk => CLK,
        rst => RST,
        set => SET,
        enSet => ENSET,
        y => Y,
        number => NUMBER
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
