----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.12.2021 18:14:03
-- Design Name: 
-- Module Name: level_velocity - Structural
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

entity level_velocity is
  Port (
    clock: in std_logic;
    reset: in std_logic;
    score: in std_logic_vector(4 downto 0);
    clock_div: out std_logic
   );
end level_velocity;

architecture Structural of level_velocity is

component div is
    generic(
clock_frequency_in : integer := 50000000;
clock_frequency_out : integer := 5000000
);
Port ( clk_in : in STD_LOGIC;
rst_in : in STD_LOGIC;
clk_out : out STD_LOGIC
);
end component;

component level_manager is
     Port (
    clock_div1: in std_logic;
    clock_div2: in std_logic;
    clock_div3: in std_logic;
    clock_div4: in std_logic;
    score: in std_logic_vector(4 downto 0);
    clock_out: out std_logic
   );
end component;


signal clock_temp: std_logic_vector(3 downto 0);

-- 2 3 5 6      
begin


div1: div 
    generic map(
        clock_frequency_in => 100000000,
        clock_frequency_out => 2
    )
    port map(
        clk_in => clock,
        rst_in => reset,
        clk_out => clock_temp(0)
    );

div2: div 
    generic map(
        clock_frequency_in => 100000000,
        clock_frequency_out => 3
    )
    port map(
        clk_in => clock,
        rst_in => reset,
        clk_out => clock_temp(1)
    );
 
 div3: div 
    generic map(
        clock_frequency_in => 100000000,
        clock_frequency_out => 5
    )
    port map(
        clk_in => clock,
        rst_in => reset,
        clk_out => clock_temp(2)
    );
 
 div4: div 
    generic map(
        clock_frequency_in => 100000000,
        clock_frequency_out => 6
    )
    port map(
        clk_in => clock,
        rst_in => reset,
        clk_out => clock_temp(3)
    );
    
lv_man: level_manager
    port map(
        clock_div1 => clock_temp(0),
        clock_div2 => clock_temp(1),
        clock_div3 => clock_temp(2),
        clock_div4 => clock_temp(3),
        score => score,
        clock_out => clock_div
   );

end Structural;
