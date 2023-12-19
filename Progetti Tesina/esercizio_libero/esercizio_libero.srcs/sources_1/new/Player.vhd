----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2021 13:34:01
-- Design Name: 
-- Module Name: Player - Structural
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

entity Player is
	Port (
		clock: in std_logic;
		reset: in std_logic; 
		enP: in std_logic;
		btn1: in std_logic;  --up
		btn2: in std_logic;  --down
		btn3: in std_logic;  --right
		btn4: in std_logic;  --left
		data_fp: in std_logic_vector(7 downto 0);
		nextLevel: out std_logic;
		resultGame: out std_logic
		);
end Player;

architecture Structural of Player is

component button_interface is
  Port ( 
    clock: in std_logic;
    btn_up: in std_logic;
    btn_dx: in std_logic;
    btn_sx: in std_logic;
    btn_dw: in std_logic;
    out_btn: out std_logic_vector(1 downto 0)
  );
end component;

component comparator is
  Port ( 
    clock: in std_logic;
    reset: in std_logic;
    enable: in std_logic;
    data_ff: in std_logic_vector(7 downto 0);
    data_btn: in std_logic_vector(1 downto 0);
    timeout: in std_logic;
    result_game: out std_logic; --pass o fail
    next_level: out std_logic -- finito livello
  );
end component;

component timer is
    generic(
        M: integer := 7
    );
 Port ( 
    clock: in std_logic;
    reset: in std_logic;
    end_time: out std_logic;
    enable: in std_logic
 );
end component;

component mux_21 is
        port(X0: in std_logic;
            X1: in std_logic;
            s: in std_logic;
            Y: out std_logic
         );
end component;

component Debauncer_block is
	Port ( 
		reset: in std_logic;
		clock: in std_logic;
		btn: in std_logic_vector(3 downto 0);
		btn_out: out std_logic_vector(3 downto 0)
		);
end component;


signal out_btn_temp: std_logic_vector(1 downto 0);
signal timeout_temp: std_logic := '0';
signal result_game_temp: std_logic;
signal btn_out_temp: std_logic_vector(3 downto 0);
signal enable_comp: std_logic;
signal next_level_temp: std_logic;


begin

	DB: Debauncer_block 
		port map (
			reset => reset,
			clock => clock,
			btn(0) => btn1,
			btn(1) => btn2,
			btn(2) => btn3,
			btn(3) => btn4,
			btn_out => btn_out_temp 
		);


BI: button_interface
	port map (
		clock => clock,
		btn_up => btn_out_temp(0),
		btn_dx => btn_out_temp(1),   --ci vorrebbe 2 ma mettiamo 1 per l'inversione dx dw
		btn_sx => btn_out_temp(3),
		btn_dw => btn_out_temp(2),    --ci vorrebbe 1 ma mettiamo 2 per l'inversione dx dw
		out_btn => out_btn_temp
	);

enable_comp <= enP and (btn_out_temp(0) or btn_out_temp(1) or btn_out_temp(2) or btn_out_temp(3));

CMP: comparator
	port map (
		clock => clock,
		reset => reset,
		enable => enable_comp,
		data_ff => data_fp,
		data_btn => out_btn_temp,
		timeout => timeout_temp,
		result_game => result_game_temp,
		next_level => next_level_temp
	);

MUX: mux_21
	port map (
		X0 => result_game_temp,
		X1 => '0',
		s => timeout_temp,
		Y => resultGame
	);

MUX2: mux_21
	port map (
		X0 => next_level_temp,
		X1 => '1',
		s => timeout_temp,
		Y => nextLevel
	);

TM: timer 
	port map (
		clock => clock,
		reset => reset,
		end_time => timeout_temp,
		enable => enP
	);

end Structural;
