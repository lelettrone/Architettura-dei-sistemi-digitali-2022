----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 13:53:07
-- Design Name: 
-- Module Name: mux_21 - Behavioral
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

entity mux_21 is
        port(X0, X1: in std_logic_vector(1 downto 0);
            s: in std_logic;
            Y: out std_logic_vector(1 downto 0));
end mux_21;

architecture dataflow of mux_21 is

begin
    with s select
    Y <= X0 when '0',
         X1 when '1',
         "00" when others;
         
end dataflow;
