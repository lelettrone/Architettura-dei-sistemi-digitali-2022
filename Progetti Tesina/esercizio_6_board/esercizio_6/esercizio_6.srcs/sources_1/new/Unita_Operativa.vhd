----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2021 11:18:18
-- Design Name: 
-- Module Name: SistemaTesting - Structural
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

entity Unita_Operativa is
 Port ( 
    clock_in: in std_logic;
    reset_in: in std_logic;
    reset_mem: in std_logic;
    read_rom: in std_logic;
    read_rom_out: in std_logic;
    write_mem_out: in std_logic;
    load: in std_logic;
    enable: in std_logic;
    enCount: in std_logic;
    fine: out std_logic;
    test: out std_logic
 );
end Unita_Operativa;

architecture Structural of Unita_Operativa is

component RippleCarryAdder is 
    port(
        b0: in std_logic;
        b1: in std_logic;
        a0: in std_logic;
        a1: in std_logic;
        c_out: out std_logic;
        s0: out std_logic;
        s1: out std_logic
        );
end component;

component ROM is 
    generic(
        N: integer := 5
    );
port(
    CLK : in std_logic;
    RST : in std_logic;
    READ : in std_logic; 
    count: in integer;
    DATA : out std_logic_vector(3 downto 0)
    );
end component;

component ROM_output is 
     generic(
        N: integer := 5
    );
port(
    CLK : in std_logic;
    RST : in std_logic;
    READ : in std_logic; 
    count: in integer;
    DATA : out std_logic_vector(2 downto 0)
    );
end component;

component Mem_output is 
     generic(
        N: integer := 5
    );
  Port ( 
    clock: in std_logic;
    reset: in std_logic;
    write: in std_logic;
    count: in integer;
    value: in std_logic_vector(2 downto 0) 
  );
end component;

component Compare is 
     Port ( 
    clk: in std_logic;
    value1: in std_logic_vector(2 downto 0);
    value2: in std_logic_vector(2 downto 0);
    load: in std_logic;
    enable: in std_logic;
    comp: out std_logic
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
    fine: out std_logic;
    count_out: out integer
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
    
    
signal data: std_logic_vector(3 downto 0);
signal data_out: std_logic_vector(2 downto 0);
signal carr: std_logic;
signal ris1: std_logic;
signal ris2: std_logic;
signal count_out_temp: integer;
signal reset_mem_temp: std_logic;
    
begin

rom_input: ROM
    generic map(
        N => 8
     )
     port map(
        CLK => clock_in,
        RST => reset_in,
        READ => read_rom,
        count => count_out_temp,
        DATA => data
    );

rom_out: ROM_output
    generic map(
        N => 8
     )
     port map(
        CLK => clock_in,
        RST => reset_in,
        READ => read_rom_out,
        count => count_out_temp,
        DATA => data_out
    );

adder: RippleCarryAdder
     port map(
        b0 => data(0),
        b1 => data(1),
        a0 => data(2),
        a1 => data(3),
        c_out => carr,
        s0 => ris1,
        s1 => ris2
        );
 
mem_out: Mem_output
     generic map(
        N => 8
    )
  Port map ( 
    clock => clock_in,
    reset => reset_mem_temp,
    write => write_mem_out,
    count => count_out_temp,
    value(0) => carr,
    value(1) => ris2,
    value(2) => ris1 
  );

comp: Compare
     Port map ( 
    clk => clock_in,
    value1 => data_out,
    value2(2) => carr,
    value2(1) => ris2,
    value2(0) => ris1,
    load => load,
    enable => enable,
    comp => test
  );
  
cont: contatore
     generic map(
        N => 8
    )
  Port map ( 
    clk => clock_in,
    rst => reset_in,
    enable => enCount,
    fine => fine,
    count_out => count_out_temp
  );

BTN: ButtonDebouncer
	generic map (                       
	        CLK_period => 10,  -- periodo del clock della board 10 nanosecondi
	        btn_noise_time => 650000000 --intervallo di tempo in cui si ha l'oscillazione del bottone
	                                         --assumo che duri 6.5ms=6500microsec=6500000ns
	    )
	    port map ( 
	    	RST => reset_in,
	        CLK => clock_in,
	        BTN => reset_mem,
	        CLEARED_BTN => reset_mem_temp
	    );      

end Structural;
