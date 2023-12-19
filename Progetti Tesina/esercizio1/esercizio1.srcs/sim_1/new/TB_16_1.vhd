----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 00:19:26
-- Design Name: 
-- Module Name: TB_16_1 - Behavioral
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

entity TB_mux_16_1 is
--  Port ( );
end TB_mux_16_1;

architecture Behavioral of TB_mux_16_1 is

component mux_16_1 is
    Port (
        b: in std_logic_vector(0 to 15);
        s: in std_logic_vector(3 downto 0);
        y0: out std_logic
    );
end component;

signal inputs: STD_LOGIC_VECTOR(0 to 15);
signal selections1: STD_LOGIC_VECTOR(3 downto 0);
signal outputs: STD_LOGIC;

begin
mux: mux_16_1
    port map (
        b => inputs,
        s => selections1,
        y0 => outputs
    );

stim_proc: process

begin

--selezione linea
wait for 10 ns;
inputs <= "1001000001011011";
selections1 <= "0011";
wait for 10 ns;
assert outputs = '1'
report "errore0"
severity failure;
wait for 10 ns;
inputs <= "1001000001011011";
selections1 <= "1110";
wait for 10 ns;
assert outputs = '1'
report "errore0"
severity failure;

wait;

end process;

end Behavioral;
