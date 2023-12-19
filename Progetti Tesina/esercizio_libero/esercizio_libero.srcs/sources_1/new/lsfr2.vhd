----------------------------------------------------------------------------------
-- Company: Cal Poly, San Luis Obispo
-- Engineer: Andrew Danowitz
-- 
-- Create Date:    11:25:07 11/21/2014 
-- Design Name: 
-- Module Name:    lsfr2 - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity lsfr2 is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           lsfr_out : out  STD_LOGIC_VECTOR (7 downto 0));
end lsfr2;

architecture Behavioral of lsfr2 is



signal lsfr_new: std_logic_vector (7 downto 0):="11010010";
signal lsfr: std_logic_vector ( 7 downto 0):="11010011";
--4 downto 0
begin

lsfr_update: process (reset,lsfr)

begin
    lsfr_new (7 downto 1) <= lsfr (6 downto 0);
    lsfr_new (0) <= not(lsfr(1) xor lsfr(7));

end process lsfr_update;


lsfr8: process(reset,clock)
begin
    if (rising_edge (clock)) then
        if (reset='1') then
            lsfr <= "00000001";
        else
            lsfr <= lsfr_new;
        end if;
    end if;
end process lsfr8;
lsfr_out <= lsfr;
end Behavioral;

