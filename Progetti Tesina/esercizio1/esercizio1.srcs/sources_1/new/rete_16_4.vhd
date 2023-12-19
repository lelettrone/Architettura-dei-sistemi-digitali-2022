----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.11.2021 15:29:37
-- Design Name: 
-- Module Name: rete_16_4 - Structural
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

entity rete_16_4 is
  Port ( 
    sel: in std_logic_vector(5 downto 0);
    y: out std_logic_vector(0 to 3)
  );
end rete_16_4;


architecture Structural of rete_16_4 is

signal u: std_logic;
signal ing: std_logic_vector(0 to 15) := "1010000111001010";

component mux_16_1
     port(
        b: in std_logic_vector(0 to 15);
        s: in std_logic_vector(3 downto 0);
        y0: out std_logic
     );
 end component;
    
component demux_1_4
    port(
        b0: in std_logic;
        s: in std_logic_vector(1 downto 0);
        y: out std_logic_vector(0 to 3)
  );
  end component;
  
begin
    comp1: mux_16_1
    port map(
        b(0 to 15) => ing(0 to 15),
        s(3 downto 0) => sel(5 downto 2),
        y0 => u
        );
       
    comp2: demux_1_4
    port map(
        b0 => u, 
        s(1 downto 0) => sel(1 downto 0),
        y(0 to 3) => y(0 to 3)
      );  
end Structural;
