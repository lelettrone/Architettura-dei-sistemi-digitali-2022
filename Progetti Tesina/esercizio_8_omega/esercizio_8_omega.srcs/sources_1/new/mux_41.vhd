----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 16:59:11
-- Design Name: 
-- Module Name: mux_41 - Behavioral
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

entity mux_41 is
 port(X0, X1, X2, X3: in std_logic_vector(1 downto 0);
            s: in std_logic_vector(1 downto 0);
            Y: out std_logic_vector(1 downto 0));
end mux_41;

architecture dataflow of mux_41 is

begin
    with s select
    Y <= X0 when "00",
         X1 when "01",
         X2 when "10",
         X3 when "11",
         "00" when others;
         
end dataflow;
