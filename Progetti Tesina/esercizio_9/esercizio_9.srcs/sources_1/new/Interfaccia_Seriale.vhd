----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2021 09:32:06
-- Design Name: 
-- Module Name: Interfaccia_Seriale - Structural
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

entity Interfaccia_Seriale is
  Port ( 
    clock_in: in std_logic;
    reset_in: in std_logic;
    ingresso: in std_logic_vector(7 downto 0);
    uscita: out std_logic_vector(7 downto 0);
    writeEn: in std_logic;
    readEn: in std_logic
  );
end Interfaccia_Seriale;

architecture Structural of Interfaccia_Seriale is

component SystemA is
     Port ( 
    clock: in std_logic;
    reset: in std_logic;
    input: in std_logic_vector(7 downto 0);
    write: in std_logic;
    --read: in std_logic;
    output: out std_logic
  );
end component;

component SystemB is
     Port ( 
    clk: in std_logic;
    rst: in std_logic;
    rxdR: in std_logic;
    dboutR: out std_logic_vector(7 downto 0);
    rdR: in std_logic
  );
end component; 

signal reset_n: std_logic;
signal serialT: std_logic;
signal readEnN: std_logic;

begin

reset_n <= not reset_in;
readEnN <= not readEn;   --perchè il sistema legge quando read è 0


A: SystemA 
    port map(
        clock => clock_in,
        reset => reset_n,
        input => ingresso,
        write => writeEn,
        output => serialT
    );

B: SystemB
    port map(
       clk => clock_in,
       rst => reset_n,
       rxdR => serialT,
       dboutR => uscita,
       rdR => readEnN
  );

end Structural;
