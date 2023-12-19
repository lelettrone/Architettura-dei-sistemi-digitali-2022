----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.11.2021 16:46:33
-- Design Name: 
-- Module Name: TB_demux_1_4 - Behavioral
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

entity TB_demux_1_4 is
end TB_demux_1_4;

architecture Behavioral of TB_demux_1_4 is

  component demux_1_4 is
  Port ( 
    b0: in std_logic;
    s: in std_logic_vector(1 downto 0);
    y: out std_logic_vector(0 to 3)
  );
end component;
    
    signal inputs: std_logic;
    signal selections1: STD_LOGIC_VECTOR(1 downto 0);
    signal outputs: STD_LOGIC_VECTOR(0 to 3);

begin
 --Unit Under Test
uut: demux_1_4
  Port map ( 
  b0 => inputs,
  s=> selections1,
  y => outputs
  );

stim_proc: process

begin

--selezione linea
wait for 10 ns;
selections1 <= "10";
inputs <= '1';
wait for 10 ns;
assert outputs <= "0010"
report "errore0"
severity failure;
wait for 10 ns;
selections1 <= "01";
inputs <= '1';
wait for 10 ns;
assert outputs <= "0100"
report "errore0"
severity failure;
wait for 10 ns;
selections1 <= "11";
inputs <= '0';
wait for 10 ns;
assert outputs <= "0000"
report "errore0"
severity failure;

wait;

end process;



end Behavioral;
