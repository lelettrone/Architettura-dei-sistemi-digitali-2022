----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2021 10:46:08
-- Design Name: 
-- Module Name: TB_encoder_BCD - Behavioral
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

entity TB_encoder_BCD is
end TB_encoder_BCD;

architecture Behavioral of TB_encoder_BCD is

component encoder_BCD
    port(
        ing: std_logic_vector(0 to 9);
        u: out std_logic_vector(0 to 3)
        );
end component;

signal input: std_logic_vector(0 to 9);
signal output: std_logic_vector(0 to 3);

begin

   --Unit Under Test
uut: encoder_BCD
  Port map ( 
  ing => input,
  u => output
  );

stim_proc: process

begin

--selezione linea
wait for 10 ns;
input <= "0000100000";
wait for 10 ns;
assert output <= "0101"
report "errore0"
severity failure;



wait;

end process;

end Behavioral;
