----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.02.2022 22:55:34
-- Design Name: 
-- Module Name: NodoA - Behavioral
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

entity NodoB is
    generic(
        N: integer --Numero di byte della ROM
    );
    Port(
        VOUT1: out std_logic_vector(7 downto 0);
        VOUT2: out std_logic_vector(7 downto 0);
        CLK: in std_logic;
        RST: in std_logic;
        X: in std_Logic_vector(7 downto 0);
        Rts: in std_logic; 
        Eop: out std_logic 
        
    );
end NodoB;

architecture NodoB_arc of NodoB is

component Contatore is
generic(
        N: integer := 5
    );
  Port ( 
    clk: in std_logic;
    rst: in std_logic;
    enable: in std_logic;
    fine: out std_logic;
    count_out: out integer
  );
end component;

component MemB is
generic(
        N: integer := 5
    );
  Port ( 
    VOUT: out std_logic_vector(7 downto 0);
    clock: in std_logic;
    reset: in std_logic;
    write: in std_logic;
    count: in integer;
    value: in std_logic_vector(7 downto 0) 
  );
end component;

component CompB is 
    Port ( 
            x: in std_logic_vector(7 downto 0);
            ris: out std_logic
        );
end component;

component Demux1_2 is
        Port (
            X: in std_logic;
            SEL: in std_logic;
            Y: out std_logic_vector(1 downto 0)
        );
 end component;



signal enCount: std_logic;
signal writeMem: std_logic;
signal writeMem1: std_logic;
signal writeMem2: std_logic;
signal count1: integer;
signal count2: integer;
signal enCount1: std_Logic;
signal enCount2: std_Logic;
signal fineCount1: std_Logic;
signal fineCount2: std_Logic;
signal ris_comp: std_logic;

type stato is (S0,S1,S2,S3);
signal s : stato := S0;

begin

MEM1 : MemB 
    generic map (
        N => N
    )
    port map(
             VOUT => VOUT1,
             CLOCK => CLK,
             RESET => RST, 
             WRITE => writeMem1, 
             COUNT => count1, 
             VALUE => x
             );
MEM2 : MemB 
        generic map (
            N => N
        )
        port map(
        VOUT => VOUT2,
            CLOCK => CLK,
             RESET => RST, 
             WRITE => writeMem2, 
             COUNT => count2, 
             VALUE => x
             );
COUNTER1:  Contatore 
     generic map(
            N => N
      )
      port map ( 
        clk => CLK,
        rst => RST,
        enable => enCount1,
        fine => fineCount1,
        count_out => count1
      );
COUNTER2:  Contatore 
     generic map(
            N => N
      )
      port map ( 
        clk => CLK,
        rst => RST,
        enable => enCount2,
        fine => fineCount2,
        count_out => count2
      );
COMP: CompB
    port map(
        x => x,
        ris => ris_comp
    );
DEMCOUNTER: Demux1_2
    port map(
            X => enCount,
            SEL => ris_comp,
            Y(0)=>enCount1,
            Y(1)=>enCount2
            );
DEMWRITEMEM: Demux1_2
    port map(
            X => writeMem,
            SEL => ris_comp,
            Y(0)=>writeMem1,
            Y(1)=>writeMem2
            );
      
p: process(CLK)
begin
    if(clk'event and clk='1') then
            if (RST='1') then
                s <= S0;
            end if;
            
            case s is
                 when S0 =>
                    Eop <= '0';
                    if (Rts='1') then
                        s <= S1;
                    else s <= S0;
                    end if;
                 when S1 =>
                    writeMem <= '1';
                    s <= S2;
                 when S2 =>
                    writeMem <= '0';
                    enCount <= '1';
                    s <= S3;
                 when S3 =>
                    enCount <= '0';
                    Eop <= '1';
                    if(Rts = '0') then
                        s <= S0;
                    else 
                        s <= S3;
                    end if;
                    
                        
             end case;
             
    end if;
  
end process;
end NodoB_arc;
