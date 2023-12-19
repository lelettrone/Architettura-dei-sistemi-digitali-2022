----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2021 17:05:13
-- Design Name: 
-- Module Name: UnitaDiControllo - Behavioral
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

entity UnitaDiControllo is
 	Port ( 
 		clock: in std_logic;
 		reset: in std_logic;
 		q0: in std_logic;
 		start: in std_logic;
 		count_end: in std_logic;
 		en_C: out std_logic;
 		en_SR: out std_logic;
 		en_R: out std_logic;
 		en_FP: out std_logic;
 		load_sp: out std_logic;
 		load: out std_logic;
 		sel: out std_logic;
 		reset_out: out std_logic;
 		sub: out std_logic;
 		stop: out std_logic;
 		shift: out std_logic;
 		f_shift: out std_logic;
 		stop_cu: out std_logic
 		);
end UnitaDiControllo;

architecture Behavioral of UnitaDiControllo is
type state is (idle, init, acquisiione, add, shift_s, correzione, f_shift_s);
signal current_state: state := idle;


begin
process(clock, reset)
begin
	if rising_edge(clock) then
		if(reset = '1') then
			current_state <= init;
		end if;
		case current_state is
			when idle => 
				reset_out <= '1'; 
				en_SR <= '1';
				en_R <= '1';
				en_FP <= '1';
				en_C <= '0';
				sub <= '0';
				load <= '0';
				load_sp <= '0';
				stop <= '0';
				stop_cu <= '0';
				shift <= '0';
				f_shift <= '0';
				if(start = '1') then
					current_state <= init;
				else
					current_state <= idle;
				end if;

			when init => 
				reset_out <= '0';
				en_C <= '0';
				load_sp <= '0';
				en_R <= '1';
				en_FP <= '1';
				en_SR <= '1';
				load <= '1';
				sub <= '0';
				stop <= '0';
				sel <= q0;
				shift <= '0';
				f_shift <= '0';
				stop_cu <= '0';
				current_state <= acquisiione;

			when acquisiione => 
				reset_out <= '0';
				en_SR <= '1';
				en_R <= '1';
				en_FP <= '1';
				load <= '0';
				load_sp <= '1';
				en_C <= '1';
				sub <= '0';
				sel <= q0;
				stop <= '0';
				stop_cu <= '0';
				shift <= '0';
				f_shift <= '0';
				if(count_end = '1') then
					sub <= '1';
					current_state <= correzione;
				else 
					current_state <= add;
				end if;

			when add => 
				reset_out <= '0';
				en_SR <= '1';
				en_FP <= '0';
				en_C <= '0';
				en_R <= '1';
				sel <= 	q0;
				sub <= '0';
				load_sp <= '0';
				load <= '0';
				shift <= '1';
				stop_cu <= '0';
				stop <= '0';
				f_shift <= '0';
				current_state <= shift_s;

			when shift_s => 
				reset_out <= '0';
				en_SR <= '1';
				en_C <= '0';
				en_R <= '1';
				en_FP <= '0';
				sel <= q0;
				load <= '0';
				load_sp <= '0';
				sub <= '0';
				shift <= '0';
				f_shift <= '0';
				stop_cu <= '0';
				stop <= '0';
				current_state <= acquisiione;

			when correzione =>
				reset_out <= '0';
				en_SR <= '1';
				en_C <= '0';
				en_FP <= '0';
				en_R <= '1';
				shift <= '0';
				f_shift <= '1';
				sub <= '0';
				load <= '0';
				load_sp <= '0';
				sel <= q0;
				stop <= '1';
				stop_cu <= '0';
				current_state <= f_shift_s;

			when f_shift_s =>
				reset_out <= '0';
				en_SR <= '0';
				en_FP <= '0';
				en_R <= '1';
				en_C <= '0';
				shift <= '0';
				f_shift <= '0';
				sel <= q0;
				stop <= '0';
				stop_cu <= '1';
				load <= '0';
				load_sp <= '0';
				sub <= '0';
				current_state <= idle;
		end case;
	end if;
end process;
end Behavioral;
