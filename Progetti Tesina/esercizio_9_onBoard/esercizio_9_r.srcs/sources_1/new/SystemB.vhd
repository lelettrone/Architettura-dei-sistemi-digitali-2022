----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2021 15:43:15
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
	Port(
		clockB: in std_logic;
		resetB: in std_logic;
		dataB: in std_logic;
		endOPB: out std_logic;
		readB: in std_logic;
		rqts: in std_logic;
		btn_rom: std_logic;
		y: out std_logic_vector(7 downto 0)
		);
end SystemB;


architecture Structural of SystemB is

component UARTcomponent is
    Generic (
    --@48MHz
--    BAUD_DIVIDE_G : integer := 26;  --115200 baud
--    BAUD_RATE_G   : integer := 417

    --@26.6MHz
    BAUD_DIVIDE_G : integer := 14;  --115200 baud
    BAUD_RATE_G   : integer := 231
  );
  Port (  
    TXD   : out   std_logic   := '1';         -- Transmitted serial data output
    RXD   : in    std_logic;              -- Received serial data input
    CLK   : in    std_logic;              -- Clock signal
    DBIN  : in    std_logic_vector (7 downto 0);    -- Input parallel data to be transmitted
    DBOUT   : out   std_logic_vector (7 downto 0);    -- Recevived parallel data output
    RDA   : inout  std_logic;             -- Read Data Available
    TBE   : out   std_logic   := '1';         -- Transfer Buffer Emty
    RD    : in    std_logic;              -- Read Strobe
    WR    : in    std_logic;              -- Write Strobe
    PE    : out   std_logic;              -- Parity error   
    FE    : out   std_logic;              -- Frame error
    OE    : out   std_logic;              -- Overwrite error
    RST   : in    std_logic := '0');        -- Reset signal
end component;

component Ricevitore is
	generic (
		N: integer := 10
	);
	Port (
		clk: in std_logic;
		rda: in std_logic;
		dato_in: in std_logic_vector(7 downto 0);
		endOpR: out std_logic;
		rts: in std_logic;
		enCountR: out std_logic;
		countR: in integer;
		y0: out std_logic_vector(7 downto 0)
	);
end component;


component contatore is
    generic(
        N: integer := 2
    );
  Port ( 
    clk: in std_logic;
    rst: in std_logic;
    enable: in std_logic;
    count_out: out integer
  );
end component;

component Memoria is
    generic(
        N: integer := 10
     );
  Port ( 
    clk: in std_logic;
    rst: in std_logic;
    enSet: in std_logic;
    head: in integer;
    TxData: in std_logic_vector(7 downto 0);
    mem_out: out std_logic_vector(7 downto 0)
  );
end component;


signal data_temp: std_logic_vector(7 downto 0);
signal rda_temp: std_logic := '0';
signal y_temp: std_logic_vector(7 downto 0);

signal dbinR: std_logic_vector(7 downto 0);
signal tbeR: std_logic;
signal wrR: std_logic;
signal peR: std_logic;
signal feR: std_logic;
signal oeR: std_logic;
signal txdR: std_logic;

signal count_temp: integer;
signal enCount_temp: std_logic;


begin


uart: UARTcomponent
	generic map (
		BAUD_DIVIDE_G => 14,  --115200 baud
    	BAUD_RATE_G => 231
	)
	port map (
		TXD => txdR,
		RXD => dataB,
		CLK => clockB,
		DBIN => dbinR,
		DBOUT => data_temp,
		RDA => rda_temp,
		TBE => tbeR,
		RD => readB,
		WR => wrR,
		PE => peR,
		FE => feR,
		OE => oeR,
		RST => resetB
	);

R: Ricevitore
	generic map (
		N => 10
	)
	port map (
		clk => clockB,
		rda => rda_temp,
		dato_in => data_temp,
		endOpR => endOPB,
		rts => rqts,
		enCountR => enCount_temp,
		countR => count_temp,
		y0 => y_temp
	);


cont: contatore
	generic map (
		N => 10
	)
	port map (
		clk => clockB,
		rst => resetB,
		enable => enCount_temp,
		count_out => count_temp
	);

Mem: Memoria 
	generic map (
		N => 10
	)
	port map (
		clk => clockB,
		rst => resetB,
		enSet => btn_rom,
		head => count_temp,
		TxData => y_temp,
		mem_out => y
	);

end Structural;
