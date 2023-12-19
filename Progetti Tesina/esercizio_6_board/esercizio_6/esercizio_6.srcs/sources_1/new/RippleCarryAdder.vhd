----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.12.2021 12:13:21
-- Design Name: 
-- Module Name: RippleCarryAdder - Structural
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

entity RippleCarryAdder is
 Port (
    b0: in std_logic;
    b1: in std_logic;
    a0: in std_logic;
    a1: in std_logic;
    c_out: out std_logic;
    s0: out std_logic;
    s1: out std_logic
  );
end RippleCarryAdder;

architecture Structural of RippleCarryAdder is

component FullAdder is   
   Port ( 
      a: in std_logic;
      b: in std_logic;
      carry_in: in std_logic;
      carry_out: out std_logic;
      ris: out std_logic
  );
end component;

signal carry_temp: std_logic;
        
begin

F1: FullAdder 
    port map(
        a => a0,
        b => b0,
        carry_in => '0',
        carry_out => carry_temp,
        ris => s0
    );
    
F2: FullAdder 
    port map(
        a => a1,
        b => b1,
        carry_in => carry_temp,
        carry_out => c_out,
        ris => s1
    );


end Structural;
