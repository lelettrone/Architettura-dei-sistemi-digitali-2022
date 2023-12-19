----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2021 15:53:13
-- Design Name: 
-- Module Name: riconoscitore_seq_button - Structural
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

entity riconoscitore_seq_button is
  Port ( 
    clock_in: in std_logic;
    reset_in: in std_logic;
    M: in std_logic;
    input: in std_logic;
    btn1: in std_logic;
    btn2: in std_logic;
    LED: out std_logic;
    output: out std_logic
  );
end riconoscitore_seq_button;

architecture Structural of riconoscitore_seq_button is

component ButtonDebouncer
     generic (                       
        CLK_period:   integer := 10;  -- periodo del clock della board 10 nanosecondi
        btn_noise_time:   integer := 650000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                         
    );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC);
end component;

component riconoscitore_seq
    port ( 
    clk: in std_logic;
    mode: in std_logic;
    x: in std_logic;
    read1: in std_logic;
    read2: in std_logic;
    led: out std_logic;
    y: out std_logic
 );
end component;

signal reset_n: std_logic;
signal read_temp1: std_logic;
signal read_temp2: std_logic;

begin

reset_n <= not reset_in;

debouncer1: ButtonDebouncer GENERIC MAP(
    CLK_period => 10, -- periodo del clock della board pari a 10ns
    btn_noise_time => 650000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
    )
    port map(
        RST => reset_n,
        CLK => clock_in,
        BTN => btn1,
        CLEARED_BTN => read_temp1
    );

debouncer2: ButtonDebouncer GENERIC MAP(
    CLK_period => 10, -- periodo del clock della board pari a 10ns
    btn_noise_time => 650000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
    )
    port map(
        RST => reset_n,
        CLK => clock_in,
        BTN => btn2,
        CLEARED_BTN => read_temp2
    );

riconoscitore: riconoscitore_seq
    port map(
        clk => clock_in,
        mode => M,
        x => input,
        read1 => read_temp1,
        read2 => read_temp2,
        LED => led,
        y => output
    );
end Structural;
