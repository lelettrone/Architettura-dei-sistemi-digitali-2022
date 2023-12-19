----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.11.2021 16:19:27
-- Design Name: 
-- Module Name: TB_rete_16_4 - Behavioral
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

entity TB_rete_16_4 is
--  Port ( );
end TB_rete_16_4;

architecture Behavioral of TB_rete_16_4 is
    
  component rete_16_4 is
  Port ( 
  ing : in STD_LOGIC_VECTOR(0 to 15);
  sel : in STD_LOGIC_VECTOR(5 downto 0);
  y : out STD_LOGIC_VECTOR(0 to 3)
  );
end component;

signal inputs: STD_LOGIC_VECTOR(0 to 15);
signal selections1: STD_LOGIC_VECTOR(5 downto 0);
signal outputs: STD_LOGIC_VECTOR(0 to 3);

begin
    --Unit Under Test


uut: rete_16_4
  Port map ( 
  ing => inputs,
  sel => selections1,
  y => outputs
  );
  
stim_proc: process
begin

wait for 10 ns;
inputs <= "0000000001000000";
selections1 <= "100100";
wait for 10 ns;
assert outputs <= "1000"
report "errore0"
severity failure;
wait for 10 ns;
inputs <= "0100010001001100";
selections1 <= "000110";
wait for 10 ns;
assert outputs <= "0100"
report "errore0"
severity failure;

wait;

end process;
end Behavioral;

