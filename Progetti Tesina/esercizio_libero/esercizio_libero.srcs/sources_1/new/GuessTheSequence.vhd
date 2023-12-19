----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2021 18:59:07
-- Design Name: 
-- Module Name: GuessTheSequence - Structural
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

entity GuessTheSequence is
	Port ( 
		clock_in: std_logic;
		reset_in: std_logic;
		anodes_out: out std_logic_vector(7 downto 0);
 		cathodes_out: out std_logic_vector(7 downto 0);
		btn1: in std_logic;  --up
		btn2: in std_logic;  --down
		btn3: in std_logic;  --right
		btn4: in std_logic;  --left
		led_outb: out std_logic;
		led_outg: out std_logic;
		led_outr: out std_logic;
		btn_start: in std_logic
		);
end GuessTheSequence;

architecture Structural of GuessTheSequence is

component UnitaDiControllo is
	Port ( 
		clock: in std_logic;
		reset: in std_logic;
		reset_out: out std_logic;
		end_game: in std_logic;
		en_Player: out std_logic;
		end_visual: in std_logic;
		en_shift: out std_logic;
		rstSH: out std_logic;
 		enFFD: out std_logic;
 		enScore: out std_logic;
		nextLevel: in std_logic;
		start: in std_logic;
		en_result: out std_logic;
		end_timer: in std_logic;
		resultGame: in std_logic		 		
		);
end component;

component UnitaOperativa is
	Port ( 
		clock: in std_logic;
		reset: in std_logic;
		end_game: out std_logic;
		en_Player: in std_logic;
		end_visual: out std_logic;
		en_shift: in std_logic;
		rstSH: in std_logic;
 		enFFD: in std_logic;
 		enScore: in std_logic;
 		anodes_out: out std_logic_vector(7 downto 0);
 		cathodes_out: out std_logic_vector(7 downto 0);
		btn1: in std_logic;  --up
		btn2: in std_logic;  --down
		btn3: in std_logic;  --right
		btn4: in std_logic;  --left
		nextLevel: out std_logic;
		en_result: in std_logic;
		end_timer: out std_logic;
		led: out std_logic_vector(2 downto 0);
		resultGame: out std_logic		 		
		);
end component;

component ButtonDebouncer is
    generic (                       
        CLK_period:   integer := 10;  -- periodo del clock della board 10 nanosecondi
        btn_noise_time:   integer := 650000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                         --assumo che duri 6.5ms=6500microsec=6500000ns
    );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC);
end component;


signal reset_out_temp: std_logic;
signal end_game_temp: std_logic;
signal en_Player_temp: std_logic;
signal end_visual_temp: std_logic;
signal en_shift_temp: std_logic;
signal rstSH_temp : std_logic;
signal enFFD_temp : std_logic;
signal enScore_temp : std_logic;
signal nextLevel_temp : std_logic;
signal start_read_temp : std_logic;
signal resultGame_temp : std_logic;
signal en_result_temp: std_logic;
signal end_timer_temp: std_logic;

signal reset_n : std_logic;

begin

reset_n <= not reset_in;

Controllo: UnitaDiControllo
	port map (
		clock => clock_in,
		reset => reset_n,
		reset_out => reset_out_temp,
		end_game => end_game_temp,
		en_Player => en_Player_temp,
		end_visual => end_visual_temp,
		en_shift => en_shift_temp,
		rstSH => rstSH_temp,
		enFFD => enFFD_temp,
		enScore => enScore_temp,
		nextLevel => nextLevel_temp,
		start => start_read_temp,
		en_result => en_result_temp,
		end_timer => end_timer_temp,
		resultGame => resultGame_temp
	);

Operativa: UnitaOperativa
	port map (
		clock => clock_in,
		reset => reset_out_temp,
		end_game => end_game_temp,
		en_Player => en_Player_temp,
		end_visual => end_visual_temp,
		en_shift => en_shift_temp,
		rstSH => rstSH_temp,
		enFFD => enFFD_temp,
		enScore => enScore_temp,
		anodes_out => anodes_out,
		cathodes_out => cathodes_out,
		btn1 => btn1,
		btn2 => btn2,
		btn3 => btn3,
		btn4 => btn4,
		nextLevel => nextLevel_temp,
		en_result => en_result_temp,
		end_timer => end_timer_temp,
		led(2) => led_outb,
		led(0) => led_outg,
		led(1) => led_outr,
		resultGame => resultGame_temp
	);

BTND: ButtonDebouncer
	port map (
		RST => reset_n,
		CLK => clock_in,
		BTN => btn_start,
		CLEARED_BTN => start_read_temp
	);

end Structural;
