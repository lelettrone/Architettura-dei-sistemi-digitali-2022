----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.12.2021 12:53:54
-- Design Name: 
-- Module Name: Unita_Controllo - Behavioral
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

entity Unita_Controllo_Button is
	Port (
		clock: in std_logic;
	    reset: in std_logic;
	    start_btn: in std_logic;
	    reset_out: out std_logic;
	    read_rom: out std_logic;
	    read_rom_out: out std_logic;
	    write_mem_out: out std_logic;
	    load: out std_logic;
	    enCount: out std_logic;
	    read_btn: in std_logic;
	    fine: in std_logic;
	    enable: out std_logic
	    );
end Unita_Controllo_Button;

architecture Structural of Unita_Controllo_Button is

component Unita_Controllo is
  Port ( 
    clock: in std_logic;
    reset: in std_logic;
    start: in std_logic;
    reset_out: out std_logic;
    read_rom: out std_logic;
    read_rom_out: out std_logic;
    write_mem_out: out std_logic;
    load: out std_logic;
    enCount: out std_logic;
    read: in std_logic;
    fine: in std_logic;
    enable: out std_logic
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


signal btn_temp1: std_logic; --start
signal btn_temp2: std_logic; --read

begin


UC: Unita_Controllo 
	port map (
		clock => clock,
	    reset => reset,
	    start => btn_temp1,
	    reset_out => reset_out,
	    read_rom => read_rom,
	    read_rom_out => read_rom_out,
	    write_mem_out => write_mem_out,
	    load => load,
	    enCount => enCount,
	    read => btn_temp2,
	    fine => fine,
	    enable => enable
	);


BTN1: ButtonDebouncer
	generic map (                       
	        CLK_period => 10,  -- periodo del clock della board 10 nanosecondi
	        btn_noise_time => 650000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
	                                         --assumo che duri 6.5ms=6500microsec=6500000ns
	    )
	    port map ( 
	    	RST => reset,
	        CLK => clock,
	        BTN => start_btn,
	        CLEARED_BTN => btn_temp1
	    );


BTN2: ButtonDebouncer
	generic map (                       
	        CLK_period => 10,  -- periodo del clock della board 10 nanosecondi
	        btn_noise_time => 650000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
	                                         --assumo che duri 6.5ms=6500microsec=6500000ns
	    )
	    port map ( 
	    	RST => reset,
	        CLK => clock,
	        BTN => read_btn,
	        CLEARED_BTN => btn_temp2
	    );

end Structural;