----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.01.2022 15:42:04
-- Design Name: 
-- Module Name: riconoscitore_seq - Behavioral
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

entity riconoscitore_seq is
 Port ( 
    clk: in std_logic;
    m: in std_logic;
    x: in std_logic;
    y: out std_logic
 );
end riconoscitore_seq;

architecture Behavioral of riconoscitore_seq is

type stato is (q0,q1,q2,q3,q11,q22,q33);
signal stato_corrente : stato := q0;

begin
process(clk)
    begin 
        if rising_edge (clk) then
        if m' event then 
            stato_corrente <= q0;
            y <= '0';
         end if;
            if(m= '1') then    --riconoscitore un bit alla volta
            case stato_corrente is 
                when q0 =>
                    if(x = '1') then stato_corrente <= q1; y <= '0';
                    else stato_corrente <= q0; y <= '0';
                    end if;
                when q1 =>
                    if(x = '1') then stato_corrente <= q1; y <= '0';
                    else stato_corrente <= q2; y <= '0';
                    end if;
                when q2 =>
                    if(x = '1') then stato_corrente <= q1; y <= '0';
                    else stato_corrente <= q3; y <= '0';
                    end if;
                when q3 =>
                    if(x = '1') then stato_corrente <= q0; y <= '1';
                    else stato_corrente <= q0; y <= '0';
                    end if;
               when others =>
			      stato_corrente <= q0;
			      y <= '0';
            end case;
            else case stato_corrente is   
                when q0 =>
                    if(x = '1') then stato_corrente <= q1; y <= '0';
                    else stato_corrente <= q11; y <= '0';
                    end if;
                when q1 =>
                    if(x = '1') then stato_corrente <= q22; y <= '0';
                    else stato_corrente <= q2; y <= '0';
                    end if; 
                when q2 =>
                    if(x = '1') then stato_corrente <= q33; y <= '0';
                    else stato_corrente <= q3; y <= '0';
                    end if;
                when q3 =>
                    if(x = '1') then stato_corrente <= q0; y <= '1';
                    else stato_corrente <= q0; y <= '0';
                    end if;
                when q11 =>
                    stato_corrente <= q22; y <= '0';
                when q22 =>
                    stato_corrente <= q33; y <= '0';  
                when q33 =>
                    stato_corrente <= q0; y <= '0';
                 when others =>
			        stato_corrente <= q0;
			        y <= '0';
                 end case;           
        end if;
        end if;
end process;
end Behavioral;