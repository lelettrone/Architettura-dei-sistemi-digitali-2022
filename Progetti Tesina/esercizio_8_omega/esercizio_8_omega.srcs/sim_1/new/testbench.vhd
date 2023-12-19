----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 16:10:47
-- Design Name: 
-- Module Name: testbench - Behavioral
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

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is
component OmegaNetwork is
 Port (S0, S1,S2, S3: in std_logic_vector(5 downto 0);
 E: in std_logic_vector(3 downto 0) ;
 Y0, Y1, Y2, Y3: out std_Logic_vector(1 downto 0));
end component;

signal start: std_logic;
signal S0: std_logic_vector(5 downto 0);
signal S1: std_logic_vector(5 downto 0);
signal S2: std_logic_vector(5 downto 0);
signal S3: std_logic_vector(5 downto 0);
signal Y0: std_logic_vector(1 downto 0);
signal Y1: std_logic_vector(1 downto 0);
signal Y2: std_logic_vector(1 downto 0);
signal Y3: std_logic_vector(1 downto 0);
signal E: std_logic_vector(3 downto 0);
begin

uut: OmegaNetwork
port map(
    S0,S1,S2,S3,
    E,
    Y0,Y1,Y2,Y3
);

proc: process
begin
wait for 10 ns;
-----s0,s1,d0,d1
S0 <= "001011";
S1 <= "011010";
S2 <= "101001";
S3 <= "111101";
E <= "1001"; --da SX-DX il X3,X2,X1,X0
wait;
end process;
end Behavioral;
