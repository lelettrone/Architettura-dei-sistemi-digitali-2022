----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2021 12:42:18
-- Design Name: 
-- Module Name: rolex - Structural
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

entity rolex is
  Port ( 
    clock_in: in std_logic;
    reset_in: in std_logic;
    BTN_enset: in std_logic; 
    BTN_RESET: in std_logic;
    catch_inter: in std_logic;
    mode: in std_logic;
    anodes_out: out std_logic_vector(7 downto 0);
    chatodes_out: out std_logic_vector(7 downto 0)
  );
end rolex;

architecture Structural of rolex is

component div is
     generic(
    clock_frequency_in : integer := 50000000;
    clock_frequency_out : integer := 5000000
    );
    Port ( 
    clk_in : in STD_LOGIC;
    rst_in : in STD_LOGIC;
    clk_out : out STD_LOGIC
    );
end component;

component cronometro is
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
end component;

component intertempi is
     Port ( 
    clk: in std_logic;
    rst: in std_logic;
    enSet: in std_logic;
    memSet: in std_logic;
    crono: in std_logic_vector(0 to 16);
    interOut: out std_logic_vector(0 to 16)
  );
end component;

component manager is
    Port (
    clock: in std_logic;
    cronoVec: in std_logic_vector(0 to 16);
    interVec: in std_logic_vector(0 to 16);
    displayOut: out std_logic_vector(0 to 16);
    sel: in std_logic
  );
end component;

component ButtonDebouncer is
     generic (                       
        CLK_period:   integer := 10;  -- periodo del clock della board 10 nanosecondi
        btn_noise_time:   integer := 6500000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                         --assumo che duri 6.5ms=6500microsec=6500000ns
    );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC);
end component;

component  display_seven_segments is
    Generic( 
				CLKIN_freq : integer := 100000000; 
				CLKOUT_freq : integer := 1000
				);
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
           ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
           DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
           ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
           CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component conversion is 
    Port (
    vIn: in std_logic_vector(0 to 5);
    vOut: out std_logic_vector(7 downto 0);
    clk: in std_logic
    );
end component;

signal secondi_temp: std_logic_vector(0 to 5);
signal minuti_temp: std_logic_vector(0 to 5);
signal ore_temp: std_logic_vector(0 to 4);
signal interOut_temp: std_logic_vector(0 to 16);
signal displayOut_temp: std_logic_vector(0 to 16);
signal reset_n: std_logic;
signal clock_div: std_logic;
signal ore_dis: std_logic_vector(0 to 7);
signal min_dis: std_logic_vector(0 to 7);
signal sec_dis: std_logic_vector(0 to 7);
signal read_temp1: std_logic;
signal read_temp2: std_logic;
signal SET_IN: std_logic_vector(0 to 5) := "000000";
signal enableSET: std_logic := '0';
signal selDEM: std_logic_vector(0 to 1) := "00";

begin

reset_n <= not reset_in;

mg: manager
    Port map (
    clock => clock_in,
    cronoVec(0 to 5) => secondi_temp,
    cronoVec(6 to 11) => minuti_temp,
    cronoVec(12 to 16) => ore_temp,
    interVec =>interOut_temp,
    displayOut => displayOut_temp,
    sel => mode
  );
  
divisore: div
generic map (
clock_frequency_in => 100000000,
clock_frequency_out => 1
)
port map (
clk_in => clock_in,
rst_in => reset_n,
clk_out => clock_div
);

conv1: conversion
port map(
vIn => displayOut_temp(0 to 5),
vOut => sec_dis,
clk => clock_in
);



conv2: conversion
port map(
vIn => displayOut_temp(6 to 11),
vOut => min_dis,
clk => clock_in
);

conv3: conversion
port map(
vIn(1 to 5) => displayOut_temp(12 to 16),
vIn(0) => '0',
vOut => ore_dis,
clk => clock_in
);

display: display_seven_segments
generic map (
CLKIN_freq => 100000000,
CLKOUT_freq => 500
)
port map (
CLK => clock_in,
RST => reset_n,
VALUE(7 downto 0) => sec_dis,
VALUE(15 downto 8) => min_dis,
VALUE(23 downto 16) => ore_dis,
VALUE(31 downto 24) => "00000000",
ENABLE => "00111111",
DOTS => "00010101",
ANODES => anodes_out,
CATHODES => chatodes_out
);

contatore: cronometro
port map (
clock => clock_div,
reset => read_temp2,
SET => SET_IN,
sel_demux => selDEM,
enable_set => enableSET,
hours => ore_temp,
minute => minuti_temp,
second => secondi_temp
);

btn1: ButtonDebouncer 
	generic map (
		CLK_period => 10,  -- periodo del clock della board 10 nanosecondi
	    btn_noise_time => 650000000
	)
	port map (
		RST => reset_n,
		CLK => clock_in,
		BTN => BTN_enset,
		CLEARED_BTN => read_temp1
	);

btn2: ButtonDebouncer 
	generic map (
		CLK_period => 10,  -- periodo del clock della board 10 nanosecondi
	    btn_noise_time => 650000000
	)
	port map (
		RST => reset_n,
		CLK => clock_in,
		BTN => BTN_RESET,
		CLEARED_BTN => read_temp2
	);
	
inter: intertempi
    Port map( 
    clk => clock_in,
    rst => reset_n,
    enSet => read_temp1,
    memSet => catch_inter,
    crono(0 to 5) => secondi_temp,
    crono(6 to 11) => minuti_temp,
    crono(12 to 16) => ore_temp,
    interOut => interOut_temp
  );

end Structural;
