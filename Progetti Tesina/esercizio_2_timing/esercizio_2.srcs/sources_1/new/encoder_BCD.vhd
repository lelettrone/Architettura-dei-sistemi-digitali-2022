----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2021 10:08:23
-- Design Name: 
-- Module Name: encoder_BCD - Behavioral
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

entity encoder_BCD is
  Port ( 
    ing: in std_logic_vector(9 downto 0); --mettere downto per vedere gli ingressi in ordine sulla board
    u: out std_logic_vector(9 downto 0) --anche qua stessa cosa
  );
end encoder_BCD;

architecture Behavioral of encoder_BCD is

begin
       with ing select
            u <= "0000000000" when "0000000001",
                 "0000000001" when "0000000010",
                 "0000000010" when "0000000100",
                 "0000000011" when "0000001000",
                 "0000000100" when "0000010000",
                 "0000000101" when "0000100000",
                 "0000000110" when "0001000000",
                 "0000000111" when "0010000000",
                 "0000001000" when "0100000000",
                 "0000001001" when "1000000000",
                 "0000001111" when others;
end Behavioral;
