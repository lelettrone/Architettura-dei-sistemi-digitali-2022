----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:29:17 22/10/2012 
-- Design Name: 
-- Module Name:    cathode_manager - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cathodes_manager is
    Port ( counter : in  STD_LOGIC_VECTOR (2 downto 0);
           value : in  STD_LOGIC_VECTOR (39 downto 0); --dato di mostrare sugli 8 display
           dots : in  STD_LOGIC_VECTOR (7 downto 0); --configurazione punti da accendere
           cathodes : out  STD_LOGIC_VECTOR (7 downto 0)); --sono i 7 catodi più il punto
end cathodes_manager;

architecture Behavioral of cathodes_manager is

constant zero   : std_logic_vector(6 downto 0) := "1000000"; 
constant one    : std_logic_vector(6 downto 0) := "1111001"; 
constant two    : std_logic_vector(6 downto 0) := "0100100"; 
constant three  : std_logic_vector(6 downto 0) := "0110000"; 
constant four   : std_logic_vector(6 downto 0) := "0011001"; 
constant five   : std_logic_vector(6 downto 0) := "0010010"; 
constant six    : std_logic_vector(6 downto 0) := "0000010"; 
constant seven  : std_logic_vector(6 downto 0) := "1111000"; 
constant eight  : std_logic_vector(6 downto 0) := "0000000"; 
constant nine   : std_logic_vector(6 downto 0) := "0010000"; 
--constant a   	 : std_logic_vector(6 downto 0) := "0001000"; 
constant b      : std_logic_vector(6 downto 0) := "0000011";
 
constant off   	 : std_logic_vector(6 downto 0) := "1111111"; 
constant sx      : std_logic_vector(6 downto 0) := "1001111"; --SX
constant dx     : std_logic_vector(6 downto 0) := "1111001"; --DX
constant dw     : std_logic_vector(6 downto 0) := "1110111"; --DW
constant up     : std_logic_vector(6 downto 0) := "1111110"; --UP

constant P      : std_logic_vector(6 downto 0) := "0001100";
constant A      : std_logic_vector(6 downto 0) := "0001000";
constant S      : std_logic_vector(6 downto 0) := "0010010";
constant F      : std_logic_vector(6 downto 0) := "0001110";
constant I      : std_logic_vector(6 downto 0) := "1001111";
constant L      : std_logic_vector(6 downto 0) := "1000111";

alias digit_0 is value (4 downto 0);
alias digit_1 is value (9 downto 5);
alias digit_2 is value (14 downto 10);
alias digit_3 is value (19 downto 15);
alias digit_4 is value (24 downto 20);
alias digit_5 is value (29 downto 25);
alias digit_6 is value (34 downto 30);
alias digit_7 is value (39 downto 35);

signal cathodes_for_digit : std_logic_Vector(6 downto 0) := (others => '0');
signal nibble :std_logic_vector(4 downto 0) := (others => '0');
signal dot :std_logic := '0'; --stabilisce se il punto relativo alla cifra visualizzata deve essere acceso o spento
                              --nota: dot=1 significa che deve essere acceso, ma il segnale deve essere negato per andare sui catodi 

begin 

-- questo processo multiplexa le cifre da mostrare
digit_switching: process(counter)

begin
	case counter is
		when "000" =>
			nibble <= digit_0;
			dot <= dots(0);
		when "001" =>
			nibble <= digit_1;
			dot <= dots(1);
		when "010" =>
			nibble <= digit_2;
			dot <= dots(2);
		when "011" =>
			nibble <= digit_3;
			dot <= dots(3);
		when "100" =>
			nibble <= digit_4;
			dot <= dots(4);
		when "101" =>
			nibble <= digit_5;
			dot <= dots(5);
		when "110" =>
			nibble <= digit_6;
			dot <= dots(6);
		when "111" =>
			nibble <= digit_7;
			dot <= dots(7);
		when others =>
			nibble <= (others => '0');
			dot <= '0';
	end case;
end process;
			 
seven_segment_decoder_process: process(nibble) 
  begin 
    case nibble is 
      when "00000" => cathodes_for_digit <= zero; 
      when "00001" => cathodes_for_digit <= one; 
      when "00010" => cathodes_for_digit <= two; 
      when "00011" => cathodes_for_digit <= three; 
      when "00100" => cathodes_for_digit <= four; 
      when "00101" => cathodes_for_digit <= five; 
      when "00110" => cathodes_for_digit <= six; 
      when "00111" => cathodes_for_digit <= seven; 
      when "01000" => cathodes_for_digit <= eight; 
      when "01001" => cathodes_for_digit <= nine; 
      
      when "01010" => cathodes_for_digit <= off; 
      when "01011" => cathodes_for_digit <= b; 
      
      when "01100" => cathodes_for_digit <= sx; 
      when "01101" => cathodes_for_digit <= dx; 
      when "01110" => cathodes_for_digit <= dw; 
      when "01111" => cathodes_for_digit <= up;

      when "10000" => cathodes_for_digit <= P;
      when "10001" => cathodes_for_digit <= A;
      when "10010" => cathodes_for_digit <= S;
      when "10011" => cathodes_for_digit <= F;
      when "10100" => cathodes_for_digit <= I;
      when "10101" => cathodes_for_digit <= L;

		when others => cathodes_for_digit <= (others => '0');
    end case; 
  end process seven_segment_decoder_process;
  
cathodes <= (not dot)&cathodes_for_digit; 



end Behavioral;