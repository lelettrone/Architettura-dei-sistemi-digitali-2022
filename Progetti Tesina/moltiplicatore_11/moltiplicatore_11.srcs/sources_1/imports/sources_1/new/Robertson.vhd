----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.12.2021 18:19:45
-- Design Name: 
-- Module Name: Robertson - Structural
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

entity Robertson is
	Port ( 
		clock_in: in std_logic;
		reset_in: in std_logic;
		Stop: out std_logic;
		Stop_cu: out std_logic;
		X: in std_logic_vector(7 downto 0);
		Y: in std_logic_vector(7 downto 0);
		start: in std_logic;
		result: out std_logic_vector(15 downto 0)
		);
end Robertson;

architecture Structural of Robertson is


component UnitaOperativa is
	Port ( 
		clk: in std_logic;
		rst: in std_logic;
		X: in std_logic_vector(7 downto 0);
		Y: in std_logic_vector(7 downto 0);
		shift: in std_logic;
		f_shift: in std_logic;
		load: in std_logic;
		load_sp: in std_logic;
		en_SR: in std_logic;
		en_FP: in std_logic;
		en_R: in std_logic;
		en_C: in std_logic;
		count: out integer;
		count_end: out std_logic;
		sub: in std_logic;
		sel: in std_logic;
		y_out: out std_logic_vector(15 downto 0)
		);
end component;

component UnitaDiControllo is
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
end component;

signal q0_temp: std_logic;
signal count_end_temp: std_logic;
signal en_C_temp: std_logic;
signal en_SR_temp: std_logic;
signal en_R_temp: std_logic;
signal en_FP_temp: std_logic;
signal load_sp_temp: std_logic;
signal load_temp: std_logic;
signal sel_temp: std_logic;
signal reset_out_temp: std_logic;
signal sub_temp: std_logic;
signal shift_temp: std_logic;
signal f_shift_temp: std_logic;
signal count_temp: integer;
signal y_temp: std_logic_vector(15 downto 0);

begin

UO: UnitaOperativa 
	port map (
		clk => clock_in,
		rst => reset_out_temp,
		X => X,
		Y => Y,
		shift => shift_temp,
		f_shift => f_shift_temp,
		load => load_temp,
		load_sp => load_sp_temp,
		en_SR => en_SR_temp,
		en_FP => en_FP_temp,
		en_R => en_R_temp,
		en_C => en_C_temp,
		count => count_temp,
		count_end => count_end_temp,
		sub => sub_temp,
		sel => sel_temp,
		y_out => y_temp
	);

UC: UnitaDiControllo
	port map (
		clock => clock_in,
		reset => reset_in,
		q0 => q0_temp,
		start => start,
		count_end => count_end_temp,
		en_C => en_C_temp,
		en_SR => en_SR_temp,
		en_R => en_R_temp,
		en_FP => en_FP_temp,
		load_sp => load_sp_temp,
		load => load_temp,
		sel => sel_temp,
		reset_out => reset_out_temp,
		sub => sub_temp,
		stop => Stop,
		shift => shift_temp,
		f_shift => f_shift_temp,
		stop_cu => Stop_cu
	);

q0_temp <= y_temp(0);
result <= y_temp;


end Structural;
