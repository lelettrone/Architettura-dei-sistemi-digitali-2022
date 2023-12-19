----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2021 19:06:15
-- Design Name: 
-- Module Name: visual - Behavioral
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

entity visual is
    Port ( 
         clock: in std_logic;
         reset: in std_logic;
         enSH: in std_logic;  
         enFFD: in std_logic;
         rstSH: in std_logic;
         enScore: in std_logic;
         data: out std_logic_vector(7 downto 0);
         anodes_out: out std_logic_vector(7 downto 0);
         cathodes_out: out std_logic_vector(7 downto 0);
         end_game: out std_logic;
         result: in std_logic;
         en_result: in std_logic;
         endtimer: out std_logic;
         led: out std_logic_vector(2 downto 0);
         fine: out std_logic
    );
end visual;

architecture structural of visual is

component codec is
Port ( clock : in  STD_LOGIC; --CLOCK DIVISORE 0.5 S
           reset : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (7 downto 0);
           data : out  STD_LOGIC_VECTOR (4 downto 0);
           endSeq : out STD_LOGIC;
           enable: in STD_LOGIC);
end component;

component counter is
 Port (  clock: in std_Logic;
         enable : in std_logic;
         reset: in std_logic;
         topscore: out std_logic;
         output: out std_logic_vector(4 downto 0));
end component;

component ffd is
Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           input : in  STD_LOGIC_VECTOR (7 downto 0);
           data : out  STD_LOGIC_VECTOR (7 downto 0);
           enable: in STD_LOGIC);
end component;

component lsfr2 is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           lsfr_out : out  STD_LOGIC_VECTOR (7 downto 0));
end component;


component display_seven_segments is
Generic( 
				CLKIN_freq : integer := 100000000; 
				CLKOUT_freq : integer := 1000
				);
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           VALUE : in  STD_LOGIC_VECTOR (39 downto 0);
           ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
           DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
           ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
           CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component level_velocity is
    Port (
    clock: in std_logic;
    reset: in std_logic;
    score: in std_logic_vector(4 downto 0);
    clock_div: out std_logic
   );
end component;

component display_led_controller is
    Port ( 
    clock: in std_logic;
    arrow: in std_logic_vector(4 downto 0);
    score: in std_logic_vector(4 downto 0);
    result_game: in std_logic;
    enable_result: in std_logic;
    enable_digit: out std_logic_vector(7 downto 0);
    led: out std_logic_vector(2 downto 0);
    output: out std_logic_vector(39 downto 0)
  );
end component;

component timer is
    generic(
        M: integer := 1
    );
 Port ( 
    clock: in std_logic;
    reset: in std_logic;
    end_time: out std_logic;
    enable: in std_logic
 );
end component;


signal random_temp, data_temp: std_logic_vector(7 downto 0);
signal arrow_temp : std_logic_vector(4 downto 0);
signal clock_lento : std_logic;
signal counter_out_temp: std_logic_vector(4 downto 0);
signal value_display_temp: std_logic_vector(39 downto 0);
signal enable_digit_temp: std_logic_vector(7 downto 0);


begin

random_data: lsfr2
    port map(clock=>clock, 
            reset=>reset, 
            lsfr_out=>random_temp);
flipflopD: ffd
    port map(
            clock=>clock, 
            reset=>reset, 
           input =>random_temp,
           data => data_temp,
           enable => enFFD);

          
kodek: codec
    port map ( clock => clock_lento, 
           reset => rstSH,
           input => data_temp,
           data => arrow_temp,
           endSeq => fine,
           enable => enSH);
           

visor: display_seven_segments
    	Generic map( 
				CLKIN_freq => 100000000,
				CLKOUT_freq => 1000
				)
    Port map ( CLK => clock,
           RST => reset,
           VALUE => value_display_temp,
           ENABLE => enable_digit_temp,
           DOTS => "00000000",
           ANODES => anodes_out,
           CATHODES => cathodes_out
       );
       
score: counter
    Port map (  clock => clock,
         enable => enScore,
         reset => reset,
         topscore => end_game,
         output => counter_out_temp
    );
    
vel: level_velocity
    port map(
        clock => clock,
        reset => reset,
        score => counter_out_temp,
        clock_div => clock_lento
   );

dsp_contr: display_led_controller 
    port map(
        clock => clock,
        arrow => arrow_temp,
        score => counter_out_temp,
        result_game => result,
        enable_result => en_result,
        enable_digit => enable_digit_temp,
        led => led,
        output => value_display_temp
   );    

TIM: timer 
	port map (
		clock => clock,
		reset => reset,
		end_time => endtimer,
		enable => en_result
	);

data <= data_temp;
        
end structural;
