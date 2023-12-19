----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2021 16:37:38
-- Design Name: 
-- Module Name: cronometro - Structural
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

entity cronometro is
 Port ( 
    clock: in std_logic;
    reset: in std_logic;
    SET: in std_logic_vector(0 to 5);
    sel_demux: in std_logic_vector(1 downto 0);
    enable_set: in std_logic;
    hours: out std_logic_vector(0 to 4);
    minute: out std_logic_vector(0 to 5);
    second: out std_logic_vector(0 to 5)
 );
end cronometro;

architecture Structural of cronometro is


component contatore is
    generic(
            N : integer := 24;
            L : integer := 5
         );
    port(
        clk: in std_logic;
        rst: in std_logic;
        set: in std_logic_vector(0 to L-1);
        enSet: in std_logic;
        y: out std_logic;
        number: out std_logic_vector(0 to L-1);
        enable: in std_logic
     );
 end component; 
 
 component demux_1_4 is 
    port(
         b0: in std_logic;
         s: in std_logic_vector(1 downto 0);
         y: out std_logic_vector(0 to 3)
    );
  end component; 

signal dem_out: std_logic_vector(0 to 3);
signal y_out: std_logic_vector(0 to 2);
signal t: std_logic_vector(0 to 1);
signal selezione: std_logic_vector(1 downto 0):= "10";
signal abilitazione: std_logic := '1';

begin

demux: demux_1_4 
    port map(
        b0 => enable_set,
        s => sel_demux,
        y => dem_out 
    );
    
secondi: contatore
    generic map(
        N => 60,
        L => 6
        )
port map(
        clk => clock,
        rst => reset,
        set => SET,
        enSet => dem_out(0) ,
        y => y_out(0),
        number => second,
        enable => '1'
);

t(0) <= y_out(0);

minuti: contatore
    generic map(
        N => 60,
        L => 6
        )
port map(
        clk => clock,
        rst => reset,
        set => SET,
        enSet => dem_out(1),
        y => y_out(1),
        number => minute,
        enable => t(0)
);

t(1) <= y_out(0) and y_out(1);



ore: contatore
    generic map(
        N => 24,
        L => 5
        )
port map(
        clk => clock,
        rst => reset,
        set => SET(0 to 4),
        enSet => dem_out(2) ,
        y => y_out(2),
        number => hours,
        enable => t(1)
);

end Structural;
