----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 17:02:08
-- Design Name: 
-- Module Name: dem_14 - Behavioral
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

entity dem_14 is
  port(X: in std_logic_vector(1 downto 0);
            s: in std_logic_vector(1 downto 0);
            Y0, Y1, Y2, Y3: out std_logic_vector(1 downto 0));
end dem_14;

architecture Behavioral of dem_14 is
begin
    Y0 <= X when s="00" else "00";
    Y1 <= X when s="01" else "00";
    Y2 <= X when s="10" else "00";
    Y3 <= X when s="11" else "00";

end Behavioral;
