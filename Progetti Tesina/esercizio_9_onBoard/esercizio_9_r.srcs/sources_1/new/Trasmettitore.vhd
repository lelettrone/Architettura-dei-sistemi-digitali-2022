----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2021 15:43:15
-- Design Name: 
-- Module Name: Trasmettitore - Behavioral
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

entity Trasmettitore is
	generic (
		N: integer := 10
	);
	Port (
		clock: in std_logic;
		start: in std_logic;
		wr: out std_logic;
		tbe: in std_logic;
		read: out std_logic := '1';
		endOp: in std_logic := '0';
		rtsT: out std_logic;
		enCount: out std_logic;
		countT: in integer;
		data: out std_logic_vector(7 downto 0)
		);
end Trasmettitore;

architecture Behavioral of Trasmettitore is

type rom_type is array (N-1 downto 0) of std_logic_vector(7 downto 0);
signal ROM : rom_type := (
"01101011", 
"01101010",
"01101001", 
"01101110",
"01101111", 
"01101000",
"01101111",
"01000000", 
"00010101",
"00000001");

type stato is (idle,load,stopWR,StopWait,Request, waitTrasm);
signal stato_corrente: stato := idle;

signal last_start: std_logic := '0';

begin
process(clock)

begin
	if rising_edge(clock) then
		case stato_corrente is
			when idle =>
				wr <= '0';
				read <= '0';
				rtsT <= '0';
				enCount <= '0';
				if(start = '1' and last_start = '0') then
				    last_start <= '1';
					stato_corrente <= load;
				else 
				    last_start <= '0';
					stato_corrente <= idle;
				end if;
			when load =>
			    wr <= '1';
			    read <= '0';
			    rtsT <= '0';
				enCount <= '0'; 
				data <= ROM(countT);
				stato_corrente <= stopWR;
			when stopWR =>
				read <= '0';
				rtsT <= '0';
				enCount <= '0';
				wr <= '0';
				stato_corrente <= StopWait;
			when StopWait =>
				read <= '0';
				rtsT <= '0';
				enCount <= '0';
				wr <= '0';
				if(tbe = '1') then
					stato_corrente <= Request;
				else 
					stato_corrente <= StopWait;
				end if;
			when Request =>
				rtsT <= '1';
				enCount <= '1';
				wr <= '0';
				read <= '0';
				stato_corrente <= waitTrasm;
			when waitTrasm =>
				rtsT <= '0';
				enCount <= '0';
				wr <= '0';
				if(countT < N-1 and endOp = '1') then
					read <= '1';
					stato_corrente <= load;
				elsif (countT = N-1 and endOp = '1') then
					read <= '1';							
					stato_corrente <= idle;
				else  
					stato_corrente <= waitTrasm;
				end if;
            end case;
    end if;
end process;
end Behavioral;