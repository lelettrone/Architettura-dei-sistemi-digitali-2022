----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.12.2021 16:47:22
-- Design Name: 
-- Module Name: Adder - Structural
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

entity Adder is
	port(
	M: in std_logic_vector(7 downto 0);
	X: in std_logic_vector(7 downto 0);
	Y: out std_logic_vector(7 downto 0);
	carry_in: in std_logic;
	carry_out: out std_logic
	);
end Adder;

architecture Structural of Adder is

component RippleCarryAdder is
 Port (
    A: std_logic_vector(7 downto 0);
    B: std_logic_vector(7 downto 0);
    c_in: in std_logic;
    c_out: out std_logic;
    s: out std_logic_vector(7 downto 0)
  );
end component;

signal value1_temp: std_logic_vector(7 downto 0);

begin

fortemp: for I in 0 to 7 generate 
	value1_temp(I) <= M(I) xor carry_in;
end generate fortemp;

Rip: RippleCarryAdder 
	port map (
		A => value1_temp,
		B => X,
		c_in => carry_in,
		c_out => carry_out,
		s => Y
	);


end Structural;
