----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2021 12:45:27
-- Design Name: 
-- Module Name: timer - Behavioral
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

entity timer is
        generic(
            M: integer := 7
   );
 Port (
    clock: in std_logic;
    reset: in std_logic;
    end_time: out std_logic;
    enable: in std_logic
 );
end timer;

architecture Structural of timer is

component contatore_timer is
    generic(
        N: integer := 7
     );
    Port (  clock: in std_Logic;
         enable : in std_logic;
         reset: in std_logic;
         timeout: out std_logic
         );
end component;

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

signal clock_div: std_logic;

begin

divisore_fre: div
    generic map(
    clock_frequency_in  => 100000000,
    clock_frequency_out => 1
    )
    port map ( clk_in => clock, 
        rst_in => reset,
        clk_out => clock_div
    ); 

c_timer: contatore_timer
    generic map(
        N => M
    )
    Port map (  clock => clock_div,
         enable => enable,
         reset => reset,
         timeout => end_time
    );

end Structural;
