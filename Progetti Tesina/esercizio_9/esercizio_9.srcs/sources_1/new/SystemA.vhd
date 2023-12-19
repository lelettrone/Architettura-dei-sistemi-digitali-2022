----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2021 17:17:51
-- Design Name: 
-- Module Name: SystemA - Structural
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

entity SystemA is
  Port ( 
    clock: in std_logic;
    reset: in std_logic;
    input: in std_logic_vector(7 downto 0);
    write: in std_logic;
    --read: in std_logic;
    output: out std_logic
  );
end SystemA;

architecture Structural of SystemA is

component UARTcomponent is
    Generic (
		--@48MHz
--		BAUD_DIVIDE_G : integer := 26; 	--115200 baud
--		BAUD_RATE_G   : integer := 417

		--@26.6MHz
		BAUD_DIVIDE_G : integer := 14; 	--115200 baud
		BAUD_RATE_G   : integer := 231
	);
	Port (	
		TXD 	: out 	std_logic  	:= '1';					-- Transmitted serial data output
		RXD 	: in  	std_logic;							-- Received serial data input
		CLK 	: in  	std_logic;							-- Clock signal
		DBIN 	: in  	std_logic_vector (7 downto 0);		-- Input parallel data to be transmitted
		DBOUT 	: out 	std_logic_vector (7 downto 0);		-- Recevived parallel data output
		RDA		: inout  std_logic;							-- Read Data Available
		TBE		: out 	std_logic 	:= '1';					-- Transfer Buffer Emty
		RD		: in  	std_logic;							-- Read Strobe
		WR		: in  	std_logic;							-- Write Strobe
		PE		: out 	std_logic;							-- Parity error		
		FE		: out 	std_logic;							-- Frame error
		OE		: out 	std_logic;							-- Overwrite error
		RST		: in  	std_logic	:= '0');				-- Reset signal
 end component;
 
 signal rdaT: std_logic;
 signal peT: std_logic;
 signal feT: std_logic;
 signal oeT: std_logic;
 signal tbeT: std_logic;
 signal dboutT: std_logic_vector(7 downto 0) := "00000000";
 signal rxdT: std_logic;
 signal rdT: std_logic;


begin

uart: UARTcomponent 
    generic map(
        BAUD_DIVIDE_G => 14,	--115200 baud
		BAUD_RATE_G => 231
	)
	port map(
	    TXD => output,
		RXD => rxdT,
		CLK => clock,
		DBIN => input,
		DBOUT => dboutT,
		RDA => rdaT,
		TBE => tbeT,
		RD => rdT,
		WR => write,
		PE => peT,						
		FE => feT,
		OE => oeT,
		RST => reset
    );  

end Structural;
