----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2021 12:13:21
-- Design Name: 
-- Module Name: FullAdder - Behavioral
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

entity FullAdder is
  Port ( 
      a: in std_logic;
      b: in std_logic;
      carry_in: in std_logic;
      carry_out: out std_logic;
      ris: out std_logic
  );
end FullAdder;

architecture Dataflow of FullAdder is

begin
    ris <= ((a xor b) xor carry_in);
    carry_out <= ((a and b) or (carry_in and (a xor b)));
end Dataflow;
