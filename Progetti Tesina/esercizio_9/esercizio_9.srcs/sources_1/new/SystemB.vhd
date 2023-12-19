----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2021 17:17:51
-- Design Name: 
-- Module Name: SystemB - Structural
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

entity SystemB is
  Port ( 
    clk: in std_logic;
    rst: in std_logic;
    rxdR: in std_logic;
    dboutR: out std_logic_vector(7 downto 0);
    rdR: in std_logic
  );
end SystemB;

architecture Structural of SystemB is

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
 
 signal rdaR: std_logic;
 signal peR: std_logic;
 signal feR: std_logic;
 signal oeR: std_logic;
 signal tbeR: std_logic;
 signal txdR: std_logic;
 signal dbinR: std_logic_vector(7 downto 0);
 signal wR: std_logic;
 

begin
uart: UARTcomponent 
    generic map(
        BAUD_DIVIDE_G => 14,	--115200 baud
		BAUD_RATE_G => 231
	)
	port map(
	    TXD => txdR,
		RXD => rxdR,
		CLK => clk,
		DBIN => dbinR,
		DBOUT => dboutR,
		RDA => rdaR,
		TBE => tbeR,
		RD => rdR,
		WR => wR,
		PE => peR,						
		FE => feR,
		OE => oeR,
		RST => rst
    );  

end Structural;