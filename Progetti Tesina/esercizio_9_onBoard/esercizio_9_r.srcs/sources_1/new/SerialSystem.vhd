----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2021 15:43:15
-- Design Name: 
-- Module Name: SerialSystem - Structural
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

entity SerialSystem is
    Port ( 
        clock_in: in std_logic;
        reset_in: std_logic;
        btn: in std_logic;
        btn2: in std_logic;
        y_out: out std_logic_vector(7 downto 0)
    );
end SerialSystem;

architecture Structural of SerialSystem is

component SystemA is
    Port(
        clockA: in std_logic;
        resetA: in std_logic;
        readA: out std_logic;
        endOpA: in std_logic;
        startA: in std_logic;
        rqtsT: out std_logic;
        serialData: out std_logic
    );
end component;

component SystemB is
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

signal endOP_temp: std_logic;
signal read_temp: std_logic;
signal data_temp: std_logic;
signal rts_temp: std_logic;
signal btn_temp: std_logic;
signal btn_temp2: std_logic;

signal reset_n: std_logic;

begin

reset_n <= not reset_in;

A: SystemA
    port map (
        clockA => clock_in,
        resetA => reset_n,
        readA => read_temp,
        endOpA => endOP_temp,
        startA => btn_temp,
        rqtsT => rts_temp,
        serialData => data_temp
    );

B: SystemB
    port map (
        clockB => clock_in,
        resetB => reset_n,
        dataB => data_temp,
        endOpB => endOP_temp,
        readB => read_temp,
        rqts => rts_temp,
		btn_rom => btn_temp2,
        y => y_out
    );
    
b1: ButtonDebouncer
    generic map (
       CLK_period => 10,
       btn_noise_time  => 650000000 
    )
    port map (
       RST => reset_n,
       CLK => clock_in,
       BTN => btn,
       CLEARED_BTN => btn_temp  
    );

b2: ButtonDebouncer
    generic map (
       CLK_period => 10,
       btn_noise_time  => 650000000 
    )
    port map (
       RST => reset_n,
       CLK => clock_in,
       BTN => btn2,
       CLEARED_BTN => btn_temp2  
    );


end Structural;
