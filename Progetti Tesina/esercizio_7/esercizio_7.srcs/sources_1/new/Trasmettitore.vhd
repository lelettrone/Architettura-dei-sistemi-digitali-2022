----------------------------------------------------------------------------------
-- Company: TESINE RANDOM
-- Engineers: RMO LELE VINC 
-- 
-- Create Date: 05.12.2021 16:50:44
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
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Trasmettitore is
    generic(
        N : integer := 10;
        M : integer := 10
       );
 Port ( 
    clock: in std_logic;
    rts_out: out std_logic;
    count: in integer;
    ready_in: in std_logic;
    fine_in: in std_logic;
    enCount: out std_logic;
    start: in std_logic
   );
end Trasmettitore;

architecture Behavioral of Trasmettitore is


type stato is (q0,q1,q2,q3,q4);
signal stato_corrente : stato := q0;

begin
process(clock)
begin
    if rising_edge(clock) then
         case stato_corrente is 
                when q0 =>
                    if(start = '1') then
                        rts_out <= '1';
                        stato_corrente <= q1;
                    else
                        stato_corrente <= q0;
                    end if;
                when q1 =>
                    if(ready_in = '1') then stato_corrente <= q2;
                    else stato_corrente <= q1;
                    end if;
                when q2 =>
                    rts_out <= '0';
                    enCount <= '1';
                    stato_corrente <= q3;
                when q3 =>
                    enCount <= '0';
                    if(count < N-1 and fine_in = '1') then
                        stato_corrente <= q4;
                    elsif( count = N-1 and fine_in = '1') then stato_corrente <= q0;
                    else  stato_corrente <= q3;
                    end if;
                when q4 =>
                    rts_out <= '1';
                    stato_corrente <= q1;
                end case;
    end if;
end process;
end Behavioral;
