----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2021 15:51:19
-- Design Name: 
-- Module Name: TB_ss - Behavioral
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

entity TB_ss is
--  Port ( );
end TB_ss;

architecture Behavioral of TB_ss is

component SerialSystem is
     Port ( 
        clock_in: in std_logic;
        reset_in: std_logic;
        btn: in std_logic;
        cont_S: out integer;
        tbeS: out std_logic;
        stato_trasm: out integer;
        stato_ric: out integer;
        rda_ricevitore: out std_logic;
        cont_R: out integer;
        y_out: out std_logic_vector(7 downto 0)
    );
end component;

signal clk: std_logic;
signal rst: std_logic;
signal btn_s: std_logic;
signal uscita: std_logic_vector(7 downto 0);
constant CLK_period : time := 10 ns;
signal cont_tras: integer;
signal tbe_tras: std_logic;
signal stato_t: integer;
signal stato_r: integer;
signal rdaRicevitore: std_logic;
signal cont_ricev: integer;

begin

uut: SerialSystem 
    port map(
        clock_in => clk,
        reset_in => rst,
        btn => btn_s,
        cont_S => cont_tras,
        tbeS => tbe_tras,
        stato_trasm => stato_t,
        stato_ric => stato_r,
        rda_ricevitore => rdaRicevitore,
        cont_R => cont_ricev,
        y_out => uscita
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
		btn_s<='0';
		wait for 10 ns;
		btn_s<='1';
		wait for 100 ns;
		btn_s<='0';
		
      wait;
   end process;
   
end Behavioral;
