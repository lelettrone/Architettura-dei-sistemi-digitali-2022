----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.02.2022 10:15:06
-- Design Name: 
-- Module Name: CompB - Behavioral
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

entity CompB is
    Port ( 
        x: in std_logic_vector(7 downto 0);
        ris: out std_logic
    );
end CompB;

architecture Behavioral of CompB is

begin
process(X)
begin
    if(x(7)='1' or x="00000000") then --negativo o tutto nullo
        ris <= '1';
    else
        ris <= '0'; --positivo
    end if;
end process;
end Behavioral;
