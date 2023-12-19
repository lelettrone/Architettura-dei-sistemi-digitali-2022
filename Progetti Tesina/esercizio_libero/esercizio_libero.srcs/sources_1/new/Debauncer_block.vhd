----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2021 17:07:20
-- Design Name: 
-- Module Name: Debauncer_block - Structural
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

entity Debauncer_block is
	Port ( 
		reset: in std_logic;
		clock: in std_logic;
		btn: in std_logic_vector(3 downto 0);
		btn_out: out std_logic_vector(3 downto 0)
		);
end Debauncer_block;

architecture Structural of Debauncer_block is


component ButtonDebouncer is
    generic (                       
        CLK_period:   integer := 10;  -- periodo del clock della board 10 nanosecondi
        btn_noise_time:   integer := 650000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
                                         --assumo che duri 6.5ms=6500microsec=6500000ns
    );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC);
end component;


begin


btn_gen: for I in 3 downto 0 generate
	BTN_g: ButtonDebouncer
		port map (
			RST => reset,
			CLK => clock,
			BTN => btn(I),
			CLEARED_BTN => btn_out(I)
		);
end generate btn_gen;

end Structural;
