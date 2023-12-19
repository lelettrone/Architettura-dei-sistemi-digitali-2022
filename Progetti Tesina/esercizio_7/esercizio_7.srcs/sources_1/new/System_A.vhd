----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.12.2021 17:23:43
-- Design Name: 
-- Module Name: System_A - Structural
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

entity System_A is
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
end System_A;

architecture Structural of System_A is

component Trasmettitore is
     generic(
        N : integer := 10;
        M : integer := 3
       );
 Port ( 
    clock: in std_logic;
    rts_out: out std_logic;
    count: in integer;
    ready_in: in std_logic;
    fine_in: in std_logic;
    enCount: out std_logic;
    start: in std_logic
   );
end component;

component contatore is 
     generic(
        N: integer := 10
    );
  Port ( 
    clk: in std_logic;
    rst: in std_logic;
    enable: in std_logic;
    count_out: out integer
  );
end component;

component ROM is
     generic(
        N: integer := 10;
        M: integer := 3
        );
  Port ( 
    clock: in std_logic;
    count: in integer;
    data: out std_logic_vector(0 to M-1)
  );
end component;

signal conteggio: integer;
signal abilitazione: std_logic;

begin

T: Trasmettitore 
    generic map(
        N => 10,
        M => 3
      )
     port map(
        clock => clockA,
        rts_out => rtsA,
        count => conteggio,
        ready_in => readyA,
        fine_in => fineA,
        enCount => abilitazione,
        start => start
   );

cont: contatore
    generic map(
        N => 10
     )
     port map(
        clk => clockA,
        rst => resetA,
        enable => abilitazione,
        count_out => conteggio
  );    

ROM_A: ROM
     generic map(
        N => 10,
        M => 3
        )
  Port map( 
    clock => clockA,
    count => conteggio,
    data => dataA
  );

end Structural;
