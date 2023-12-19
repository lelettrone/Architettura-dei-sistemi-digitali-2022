----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2021 20:30:52
-- Design Name: 
-- Module Name: comparator - Behavioral
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

entity comparator is
  Port ( 
    clock: in std_logic;
    reset: in std_logic;
    enable: in std_logic;
    data_ff: in std_logic_vector(7 downto 0);
    data_btn: in std_logic_vector(1 downto 0);
    timeout: in std_logic;
    result_game: out std_logic := '0'; --pass o fail
    next_level: out std_logic -- finito livello
  );
end comparator;

architecture Behavioral of comparator is


type stato is (q0,q1,q2);
signal stato_corrente : stato := q0;

begin
process(clock,reset,timeout)
variable count: integer := 0;
begin
     if(timeout = '1') then
        result_game <= '0';
     end if;
     if(reset = '1') then
            stato_corrente <= q0;
        end if;
    if rising_edge(clock) then
        case stato_corrente is
            when q0 =>
                if(enable = '1') then
                    stato_corrente <= q1;
                else stato_corrente <= q0;
                end if;
             when q1 =>
                if(data_ff(count) = data_btn(0) and data_ff(count +1) = data_btn(1)) then
                    if(count = 6) then
                        count := 0;
                        result_game <= '1';
                        next_level <= '1';
                        stato_corrente <= q2;
                     else count := count +2;
                          stato_corrente <= q0;
                     end if;
                 else count := 0;
                      result_game <= '0';
                      next_level <= '1';
                      stato_corrente <= q2;        
                 end if;
               when q2 =>
                  next_level <= '0';
                  stato_corrente <= q0;
               when others => report "failure" severity failure;
                  end case; 
    end if;
end process;
end Behavioral;
