----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.12.2021 17:45:01
-- Design Name: 
-- Module Name: Handshaking_system - Structural
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

entity Handshaking_system is
    generic(
        M: integer := 3
     );
 Port ( 
    clock_in: in std_logic;
    reset_in: std_logic;
    start: in std_logic;
    y_out: out std_logic_vector(0 to M-1)
 );
end Handshaking_system;

architecture Structural of Handshaking_system is

component System_A is 
      generic(
        N : integer := 10;
        M : integer := 3
       );
  Port ( 
    clockA: in std_logic;
    resetA: in std_logic;
    rtsA: out std_logic;
    readyA: in std_logic;
    fineA: in std_logic;
    start: in std_logic;
    dataA: out std_logic_vector(0 to M-1)
  );
end component;

component System_B is  
generic(
N : integer := 10;
M : integer := 10
);
Port (
clockB: in std_logic;
resetB: in std_logic;
rtsB: in std_logic;
readyB: out std_logic;
fineB: out std_logic;
dataB: in std_logic_vector(0 to M-1);
sommaB: out std_logic_vector(0 to M-1) 
);
end component;

signal rts_temp: std_logic;
signal ready_temp: std_logic;
signal fine_temp: std_logic;
signal data_temp: std_logic_vector(0 to M-1);

begin

A: System_A
    generic map(
        N => 10,
        M => 3
     )
    port map(
        clockA => clock_in,
        resetA => reset_in,
        rtsA => rts_temp,
        readyA => ready_temp,
        fineA => fine_temp,
        start => start,
        dataA => data_temp
    );

B: System_B
    generic map(
           N => 10,
        M => 3
     )
     port map(
        clockB => clock_in,
        resetB => reset_in,
        rtsB => rts_temp,
        readyB => ready_temp,
        fineB => fine_temp,
        dataB => data_temp,
        sommaB => y_out
    );
end Structural;
