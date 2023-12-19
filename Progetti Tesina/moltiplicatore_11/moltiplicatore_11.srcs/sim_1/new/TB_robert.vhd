library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity TB_robert is
end TB_robert;


architecture Behavioral of TB_robert is

component Robertson is
	port (
		clock_in: in std_logic;
		reset_in: in std_logic;
		Stop: out std_logic;
		Stop_cu: out std_logic;
		X: in std_logic_vector(7 downto 0);
		Y: in std_logic_vector(7 downto 0);
		start: in std_logic;
		result: out std_logic_vector(15 downto 0)
	);
end component;

signal clk: std_logic;
signal rst: std_logic;
signal st: std_logic;
signal st_cu: std_logic;
signal sta: std_logic := '0';
signal x1: std_logic_vector(7 downto 0) := "01100000";
signal x2: std_logic_vector(7 downto 0) := "00000011";
signal output: std_logic_vector(15 downto 0);
constant CLK_period : time := 10 ns;

begin

uut: Robertson
	port map(
	clock_in => clk,
	reset_in => rst,
	Stop => st,
	Stop_cu => st_cu,
	X => x1,
	Y => x2,
	start => sta,
	result => output
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

      sta <= '1';
      
      wait for 50 ns;
      sta <= '0';
	
      wait;
   end process;

	
end architecture Behavioral;