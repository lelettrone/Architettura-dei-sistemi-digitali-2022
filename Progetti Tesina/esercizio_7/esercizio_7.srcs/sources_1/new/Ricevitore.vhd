----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2021 16:50:44
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ricevitore is
    generic(
        N : integer := 10;
        M : integer := 10
       );
  Port ( 
    clk: in std_logic;
    rts_in : in std_logic;
    fine_out: out std_logic; 
    ready_out: out std_logic;
    enCountR: out std_logic;
    enableS: out std_logic;
    endop: in std_logic;
    countR: in integer
  );
end Ricevitore;

architecture Behavioral of Ricevitore is


type stato is (q0,q1,q2,q3,q4);
signal stato_corrente : stato := q0;

begin
process(clk)
variable data_temp: integer := 0;
begin
    if rising_edge (clk) then
        case stato_corrente is 
                when q0 =>
                    if(rts_in = '1') then stato_corrente <= q1;
                    else stato_corrente <= q0;
                    end if;
                when q1 =>
                    ready_out <= '1';
                    enableS <= '1';
                    stato_corrente <= q2;
                 when q2 =>
                    if(endop = '1') then
                        enableS <= '0';
                        ready_out <= '0';
                        enCountR <= '1';
                        stato_corrente <= q3;
                    else stato_corrente <= q2;
                    end if;
                 when q3 =>
                    enCountR <= '0';
                    if(countR < N-1) then 
                        fine_out <= '1';
                        stato_corrente <= q4;
                    else 
                        fine_out <= '1';
                        stato_corrente <= q0;
                     end if;
                 when q4 =>
                    if(rts_in = '1') then stato_corrente <= q1;
                    else stato_corrente <= q4;
                    end if;
                end case;
    end if;
end process;
end Behavioral;
