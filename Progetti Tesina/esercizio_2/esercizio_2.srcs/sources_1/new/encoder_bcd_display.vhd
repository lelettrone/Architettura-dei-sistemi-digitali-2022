----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2021 10:58:44
-- Design Name: 
-- Module Name: encoder_bcd_display - Structural
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

entity encoder_bcd_display is
 Port ( 
       clock_in : IN std_logic;
	   reset_in : IN std_logic;
	   input: in std_logic_vector(9 downto 0);
	   anodes_out : OUT std_logic_vector(7 downto 0);
	   cathodes_out : OUT std_logic_vector(7 downto 0)
 );
end encoder_bcd_display;

architecture Structural of encoder_bcd_display is

component encoder_BCD
    port(
        ing: in std_logic_vector(9 downto 0);
        u: out std_logic_vector(3 downto 0)
    );
end component;

component display_seven_segments
	generic(
		CLKIN_freq : integer := 100000000; --frequenza del clock in input: quello della board è a 100MHz
		CLKOUT_freq : integer := 500  --frequenza dell'impulso in uscita, in corrispondenza del quale 
		                              --si scandisce ciascuna cifra (deve essere compreso fra 500Hz e 8KHz)
				);
	port(
		CLK : IN std_logic;
		RST : IN std_logic;
		VALUE : IN std_logic_vector(31 downto 0);--valori da mostrare sugli 8 display
		ENABLE : IN std_logic_vector(7 downto 0);--abilitazione di ciascuna cifra (accensione)
		DOTS : IN std_logic_vector(7 downto 0); --abilitazione punti (accensione)      
		ANODES : OUT std_logic_vector(7 downto 0);
		CATHODES : OUT std_logic_vector(7 downto 0)
		);
end component;

signal y_temp: std_logic_vector(3 downto 0);
signal reset_n : std_logic;

begin

reset_n <= not reset_in;

enc: encoder_BCD
    port map(
        ing => input,
        u => y_temp
    );

seven_segment_array: display_seven_segments generic map(
	CLKIN_freq => 100000000, --qui inserisco i parametri effettivi (clock della board e clock in uscita desiderato)
	CLKOUT_freq => 500 --inserendo un valore inferiore si vedranno le cifre illuminarsi in sequenza
	)
	port map(
	   CLK => clock_in,
	   RST => reset_n,
	   VALUE(31 downto 4) => "0000000000000000000000000000",
	   VALUE(3 downto 0) => y_temp,
	   enable => "00000001", --stabilisco che tutti i display siano accesi 
	   dots => "00000000",  --stabilisco che tutti i punti siano spenti
	   anodes => anodes_out,
	   cathodes => cathodes_out
	 );
end Structural;
