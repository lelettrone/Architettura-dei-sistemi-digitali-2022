----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2021 17:56:12
-- Design Name: 
-- Module Name: UnitaOperativa - Structural
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

entity UnitaOperativa is
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
end UnitaOperativa;

architecture Structural of UnitaOperativa is


component Adder is
	port(
	M: in std_logic_vector(7 downto 0);
	X: in std_logic_vector(7 downto 0);
	Y: out std_logic_vector(7 downto 0);
	carry_in: in std_logic;
	carry_out: out std_logic
	);
end component;

component Mux_21 is
	Port ( 
		v1: in std_logic_vector(7 downto 0);
		v2: in std_logic_vector(7 downto 0);
		sel: in std_logic;
		y0: out std_logic_vector(7 downto 0)
		);
end component;

component ShiftRegister is
	Port ( 
		clk: in std_logic;
		rst: in std_logic;
		en: in std_logic;
		data: in std_logic_vector(15 downto 0);
		y: out std_logic_vector(15 downto 0);
		v_add: in std_logic_vector(7 downto 0);
		shift: in std_logic;
		f_shift: in std_logic;
		load: in std_logic;
		load_sp: in std_logic;
		F: in std_logic
		);
end component;

component Registro is
	Port ( 
		Input: in std_logic_vector(7 downto 0);
		Output: out std_logic_vector(7 downto 0);
		enable: in std_logic;
		rst: in std_logic;
		clk: in std_logic
		);
end component;

component  FlipFlop is
	Port ( 
		R: in std_logic;
		Clk: in std_logic;
		D: in std_logic;
		E: in std_logic;
		Q: out std_logic
		);
end component;

component contatore is
    generic(
        N: integer := 8
    );
  Port ( 
    clk: in std_logic;
    rst: in std_logic;
    enable: in std_logic;
    count_end: out std_logic;
    count_out: out integer
  );
end component;


signal mux_out_temp: std_logic_vector(7 downto 0); --uscita del mux
signal shift_out_temp: std_logic_vector(15 downto 0); --uscita shiftRegister 
signal carry_out_temp: std_logic; --riporto non utilizzato
signal mux_in_temp: std_logic_vector(7 downto 0); --tra registro e mux
signal data_sr_temp: std_logic_vector(15 downto 0); --input in sr
signal v_add_sr_temp: std_logic_vector(7 downto 0); --uscita dell'adder
signal F_out_temp: std_logic; -- valore in uscita al flip flop
signal data_in_F: std_logic; -- ingresso del registro


begin

ADD: Adder 
	port map (
		M => mux_out_temp,
		X => shift_out_temp(15 downto 8),
		Y => v_add_sr_temp,
		carry_in => sub,
		carry_out => carry_out_temp
	);

Mux: Mux_21
	port map (
		v1 => "00000000",
		v2 => mux_in_temp,
		sel => sel,
		y0 => mux_out_temp
	);


data_sr_temp <= "00000000" & X;

shiftR: ShiftRegister
	port map (
		clk => clk,
		rst => rst,
		en => en_SR,
		data => data_sr_temp,
		y => shift_out_temp,
		v_add => v_add_sr_temp,
		shift => shift,
		f_shift => f_shift,
		load => load,
		load_sp => load_sp,
		F => F_out_temp
	);

y_out <= shift_out_temp;


reg: Registro
	port map (
		Input => Y,
		Output => mux_in_temp,
		enable => en_R,
		rst => rst,
		clk => clk
	);

cont: contatore
	port map (
		clk => clk,
		rst => rst,
		enable => en_C,
		count_end => count_end,
		count_out => count
	);


data_in_F <= (mux_in_temp(7) and shift_out_temp(0)) or F_out_temp;

flipflopD: FlipFlop
	port map (
		R => rst,
		Clk => clk,
		D => data_in_F,
		E => en_FP,
		Q => F_out_temp
	);

end Structural;
