----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.02.2022 12:22:17
-- Design Name: 
-- Module Name: SystemAB - Behavioral
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

entity SystemAB is
--  Port ( );
generic(
        N: integer := 5
     );
 Port ( 
        VOUT1: out std_logic_vector(7 downto 0);
        VOUT2: out std_logic_vector(7 downto 0);
        
    CLK: in std_logic;
    RST: std_logic;
    Start: in std_logic
 );
end SystemAB;

architecture Behavioral of SystemAB is

component NodoA is
 generic(
        N: integer --Numero di byte della ROM
    );
    Port(
        CLK: in std_logic;
        RST: in std_logic;
        Start: in std_Logic;
        Y: out std_Logic_vector(7 downto 0);
        Rts: out std_logic; 
        Eop: in std_logic 
    );
end component;
component NodoB is
 generic(
        N: integer --Numero di byte della ROM
    );
    Port(
        VOUT1: out std_logic_vector(7 downto 0);
        VOUT2: out std_logic_vector(7 downto 0);
        CLK: in std_logic;
        RST: in std_logic;
        X: in std_Logic_vector(7 downto 0);
        Rts: in std_logic; 
        Eop: out std_logic 
        
    );
end component;

signal T : std_logic_vector(7 downto 0);
signal Rts, Eop : std_logic;

begin
TX: NodoA
    generic map(
        N => N
    )
    port map(
        CLK => CLK,
        RST => RST,
        Start => Start,
        Y => T, --out
        Rts => Rts, --out
        Eop => Eop --in
    );
RX: NodoB
    generic map(
        N => N
    )
    port map(
                VOUT1 =>VOUT1, VOUT2=>VOUT2,
        CLK => CLK,
        RST => RST,
        X => T, --in
        Rts => Rts, --in
        Eop => Eop --out
    );



end Behavioral;
