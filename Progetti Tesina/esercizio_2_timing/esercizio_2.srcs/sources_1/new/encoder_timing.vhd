----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.12.2021 12:16:55
-- Design Name: 
-- Module Name: encoder_timing - Behavioral
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

entity encoder_timing is
  Port ( 
    clock_in: in std_logic;
    input: in std_logic_vector(9 downto 0);
    usc: out std_logic_vector(9 downto 0)
  
  );
end encoder_timing;

architecture Behavioral of encoder_timing is

component encoder_BCD is
    Port ( 
    ing: in std_logic_vector(9 downto 0); --mettere downto per vedere gli ingressi in ordine sulla board
    u: out std_logic_vector(9 downto 0) --anche qua stessa cosa
  );
end component;

component flip_flop is
    Port ( 
    clock_in: in std_logic;
    data_in: in std_logic_vector(9 downto 0);
    data_out: out std_logic_vector(9 downto 0)
 );
end component;

signal data1_temp: std_logic_vector(9 downto 0);
signal data2_temp: std_logic_vector(9 downto 0);

begin

enc: encoder_BCD
    port map(
        ing => data1_temp,
        u => data2_temp
    );

f1: flip_flop
    port map(
        clock_in => clock_in,
        data_in => input,
        data_out => data1_temp
    );

f2: flip_flop
    port map(
        clock_in => clock_in,
        data_in => data2_temp,
        data_out => usc
    );


end Behavioral;
