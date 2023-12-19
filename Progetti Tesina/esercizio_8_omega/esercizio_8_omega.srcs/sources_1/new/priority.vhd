----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 16:12:15
-- Design Name: 
-- Module Name: priority - Behavioral
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

entity priority is
 Port (en0, en1, en2, en3: in std_logic;
 y: out std_logic_vector(1 downto 0) );
end priority;

architecture dataflow of priority is

begin
    y <= "00" when en0 = '1' else
        "01" when en1='1' else
        "10" when en2 = '1' else
        "11" when en3 = '1' else
        "--";

end dataflow;
