----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2021 17:24:22
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
end UnitaOperativa;

architecture Structural of UnitaOperativa is


component visual is
    Port ( 
    	 clock: in std_logic;
         reset: in std_logic;
         enSH: in std_logic;  
         enFFD: in std_logic;
         rstSH: in std_logic;
         enScore: in std_logic;
         data: out std_logic_vector(7 downto 0);
         anodes_out: out std_logic_vector(7 downto 0);
         cathodes_out: out std_logic_vector(7 downto 0);
         end_game: out std_logic;
         result: in std_logic;
         en_result: in std_logic;
         endtimer: out std_logic;
         led: out std_logic_vector(2 downto 0);
         fine: out std_logic
    );
end component;

component Player is
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
end component;


signal data_fp_temp: std_logic_vector(7 downto 0);
signal resultGame_temp: std_logic;

begin


PLY: Player
	port map (
		clock => clock,
		reset => reset,
		enP => en_Player,
		btn1 => btn1,
		btn2 => btn2,
		btn3 => btn3,
		btn4 => btn4,
		data_fp => data_fp_temp,
		nextLevel => nextLevel,
		resultGame => resultGame_temp
	);


VS: visual
	port map (
		clock => clock,
		reset => reset,
		enSh => en_shift,
		enFFD => enFFD,
		rstSH => rstSH,
		enScore => enScore,
		data => data_fp_temp,
		anodes_out => anodes_out,
		cathodes_out => cathodes_out,
		end_game => end_game,
		result => resultGame_temp,
		en_result => en_result,
		endtimer => end_timer,
		led => led,
		fine => end_visual
	);

resultGame <= resultGame_temp;

end Structural;
