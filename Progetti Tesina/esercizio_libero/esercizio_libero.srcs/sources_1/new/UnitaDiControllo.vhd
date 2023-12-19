----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2021 17:55:56
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
end UnitaDiControllo;

architecture Behavioral of UnitaDiControllo is

type stato is (idle,startGame,visualize, match, evaluatetMatch, endMatch,viewResult);
signal stato_corrente : stato := idle;

begin
process(clock, reset)
begin
	if(reset = '1') then
		stato_corrente <= idle;
	end if;
	if rising_edge(clock) then
		case stato_corrente is 
			when idle =>
				reset_out <= '1';
				en_Player <= '0';
				en_shift <= '0';
				rstSH <= '0';
		 		enFFD <= '0';
		 		enScore <= '0';
		 		en_result <= '0';
		 		if(start = '1') then
		 			stato_corrente <= startGame;
		 		else 
		 			stato_corrente <= idle;
		 		end if;
		 	when startGame => 
		 		reset_out <= '0';
		 		en_Player <= '0';
				en_shift <= '0';
				rstSH <= '0';
		 		enFFD <= '1';
		 		enScore <= '0';
		 		en_result <= '0';
		 		stato_corrente <= visualize;
		 	when visualize =>
		 		reset_out <= '0';
		 		en_Player <= '0';
				en_shift <= '1';
		 		enFFD <= '0';
		 		enScore <= '0';
		 		en_result <= '0';
		 		if(end_visual = '1') then
		 			en_shift <= '0';
		 			rstSH <= '1';
		 			stato_corrente <= match;
		 		else
		 			stato_corrente <= visualize;
		 		end if;
		 	when match =>
		 		reset_out <= '0';
		 		en_Player <= '1';
				en_shift <= '0';
				rstSH <= '1';
		 		enFFD <= '0';
		 		enScore <= '0';
		 		if(nextLevel = '1') then
		 		    en_result <= '1';
		 			stato_corrente <= viewResult;
		 		else
		 			stato_corrente <= match;
		 		end if;
		 	when viewResult =>
		 	    reset_out <= '0';
		 		en_Player <= '0';
				en_shift <= '0';
				rstSH <= '1';
		 		enFFD <= '0';
		 		enScore <= '0';
		 		if(end_timer = '1') then
		 		   en_result <= '0';
		 		   stato_corrente <= evaluatetMatch;
		 		 else stato_corrente <= viewResult;	
		 		 end if;
		 	when evaluatetMatch =>
		 		reset_out <= '0';
		 		en_Player <= '0';
				en_shift <= '0';
				rstSH <= '1';
		 		enFFD <= '0';
		 		en_result <= '0'; 		
               if(resultGame = '0') then
                  enScore <= '0';
                  stato_corrente <= idle;
               else    
                  enScore <= '1';
                  stato_corrente <= endMatch;
               end if;  
		 	when endMatch =>
		 		reset_out <= '0';
		 		en_Player <= '0';
				en_shift <= '0';
		 		enFFD <= '0';
		 		enScore <= '0';
		 		rstSH <= '0';
		 		en_result <= '0';
		 		if(end_game = '1') then
		 		    reset_out <= '1';
		 			stato_corrente <= idle;
		 		else
		 			stato_corrente <= startGame;
		 		end if;    
        end case;
    end if;
end process;
end Behavioral;
