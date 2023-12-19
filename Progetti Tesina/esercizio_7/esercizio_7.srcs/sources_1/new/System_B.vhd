library IEEE;
use IEEE.STD_LOGIC_1164.ALL;





-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;





-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;





entity System_B is
generic(
N : integer := 10;
M : integer := 10
);
Port (
clockB: in std_logic;
resetB: in std_logic;
rtsB: in std_logic;
readyB: out std_logic;
fineB: out std_logic;
dataB: in std_logic_vector(0 to M-1);
sommaB: out std_logic_vector(0 to M-1) 
);
end System_B;


architecture Structural of System_B is


signal en_temp: std_logic;
signal temp_count: integer;
signal enable_temp: std_logic;
signal data_temp: std_logic_vector(0 to M-1);
signal somma_temp: std_logic_vector(0 to M-1);
signal endop_temp: std_logic;



component Ricevitore is
 generic(
        N : integer := 10;
        M : integer := 10
       );
  Port ( 
    clk: in std_logic;
    rts_in : in std_logic;
    fine_out: out std_logic; 
    ready_out: out std_logic;
    enCountR: out std_logic;
    enableS: out std_logic;
    endop: in std_logic;
    countR: in integer
  );
end component;


component contatore is
generic(
N: integer := 10
);
Port (
clk: in std_logic;
rst: in std_logic;
enable: in std_logic;
count_out: out integer
);
end component;

component adder is
      generic(
        M: integer := 3
       );
  Port ( 
    clock: in std_logic;
    enable: in std_logic;
    data1: in std_logic_vector(0 to M-1);
    data2: in std_logic_vector(0 to M-1);
    somma: out std_logic_vector(0 to M-1);
    end_op: out std_logic
  );
end component;

component ROM_B is
      generic(
        N: integer := 10;
        M: integer := 3
        );
  Port ( 
    clock: in std_logic;
    count: in integer;
    data: out std_logic_vector(0 to M-1)
  );
end component;

component ROM_S is
    generic(
        N: integer := 10;
        M: integer := 3
        );
  Port ( 
    clock: in std_logic;
    count: in integer;
    data: in std_logic_vector(0 to M-1)
  );
end component;



begin

R: Ricevitore
generic map(
N => 10,
M => 3
)
Port map (
clk => clockB,
rts_in => rtsB,
fine_out => fineB,
ready_out => readyB,
enCountR => en_temp,
enableS => enable_temp,
endop => endop_temp,
countR => temp_count
);

Counter: contatore
generic map (
N => 10
)
Port map (
clk => clockB,
rst => resetB,
enable => en_temp,
count_out => temp_count
);

ADD: adder
     generic map(
        M => 3
       )
  Port map ( 
    clock => clockB,
    enable => enable_temp,
    data1 => dataB,
    data2 => data_temp,
    somma => somma_temp,
    end_op => endop_temp
  );

ROM1: ROM_B
     generic map(
        N => 10,
        M => 3
        )
  Port map( 
    clock => clockB,
    count => temp_count,
    data => data_temp
  );
  
ROM2: ROM_S
     generic map(
        N => 10,
        M => 3
        )
  Port map( 
    clock => clockB,
    count => temp_count,
    data => somma_temp
  );
  
sommaB <= somma_temp;        
end Structural;