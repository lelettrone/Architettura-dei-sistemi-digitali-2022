library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SysAB_TB is

end SysAB_TB;

architecture beh of SysAB_TB is
component SystemAB is
generic(
        N: integer --Numero di byte della ROM
    );
    Port(
    VOUT1: out std_logic_vector(7 downto 0);
        VOUT2: out std_logic_vector(7 downto 0);
        
    CLK: in std_logic;
    RST: std_logic;
    Start: in std_logic
    );
end component;


signal VOUT1: std_logic_vector(7 downto 0);
signal VOUT2: std_logic_vector(7 downto 0);
signal CLK: std_logic;
signal RST: std_logic;
constant CLK_period : time := 10 ns;
signal Start : std_logic;
begin

DUT : SystemAB 
    generic map(
        N => 5
       )
    port map ( 
                VOUT1 =>VOUT1, VOUT2=>VOUT2,
                CLK => CLK, 
                RST=>RST, 
                Start=>Start);
                
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

      Start <= '1';
      wait for 30 ns;
      Start <= '0';
      
      
      wait;
      
    end process;
 
end beh;