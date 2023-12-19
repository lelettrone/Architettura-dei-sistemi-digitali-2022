----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2021 15:43:15
-- Design Name: 
-- Module Name: Ricevitore - Behavioral
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

entity Ricevitore is
	generic (
		N: integer := 10
	);
	Port (
		clk: in std_logic;
		rda: in std_logic;
		dato_in: in std_logic_vector(7 downto 0);
		endOpR: out std_logic;
		rts: in std_logic;
		enCountR: out std_logic;
		countR: in integer;
		y0: out std_logic_vector(7 downto 0)
	);
end Ricevitore;

architecture Behavioral of Ricevitore is


type stato is (idle,store,endTrasm);
signal stato_corrente : stato := idle;

begin
process(clk)

begin
	
	if rising_edge(clk) then
		case stato_corrente is
			when idle =>
				endOpR <= '0';
				enCountR <= '0';
				if(rts = '1') then
					stato_corrente <= store;
				else 
					stato_corrente <= idle;
				end if;
			when store =>
				endOpR <= '0';
				enCountR <= '0';
				y0 <= dato_in;
				stato_corrente <= endTrasm;
			when endTrasm =>
			    enCountR <= '1';
				endOpR <= '1';
				stato_corrente <= idle;
        end case;
    end if;
end process;
end Behavioral;
