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

entity NodoA is
    generic(
        N: integer --Numero di byte della ROM
    );
    Port(
        CLK: in std_logic;
        RST: in std_logic;
        Start: in std_Logic;
        Y: out std_Logic_vector(7 downto 0);
        Rts: out std_logic; 
        Eop: in std_logic 
    );
end NodoA;

architecture NodoA_arc of NodoA is

component RippleCarryAdder is
Port (
    a: in std_logic_vector (7 downto 0);
    b: in std_logic_vector (7 downto 0);
    c_in: in std_logic;
    c_out: out std_logic;
    s: out std_logic_vector (7 downto 0)
  );
end component;

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

component RomA is
generic(
        N: integer := 5
    );
port(
    CLK : in std_logic;
    RST : in std_logic;
    READ : in std_logic;
    COUNT: in integer; 
    DATA : out std_logic_vector(7 downto 0)
    );
end component;
component RomAA is
generic(
        N: integer := 5
    );
port(
    CLK : in std_logic;
    RST : in std_logic;
    READ : in std_logic;
    COUNT: in integer; 
    DATA : out std_logic_vector(7 downto 0)
    );
end component;

signal regRom1: std_logic_vector(7 downto 0);
signal regRom2: std_logic_vector(7 downto 0);
signal regAdder: std_logic_vector(7 downto 0);
signal readRom: std_logic;
signal count: integer;
signal enCount: std_Logic;
signal fineCount: std_Logic;
signal c_out: std_Logic;

type stato is (S0,S1,S2,S3,S4,S5,S6);
signal s : stato := S0;

begin
ROM1 : RomA 
    generic map (
        N => N
    )
    port map(CLK => CLK,
             RST => RST, 
             READ => readRom, 
             COUNT => count, 
             DATA => regRom1
    );
ROM2 : RomAA
        generic map (
            N => N
        )
        port map(CLK => CLK,
             RST => RST, 
             READ => readRom, 
             COUNT => count, 
             DATA => regRom2);
COUNTER:  Contatore 
     generic map(
            N => N
      )
      port map ( 
        clk => CLK,
        rst => RST,
        enable => enCount,
        fine => fineCount,
        count_out => count
      );
ADDER: RippleCarryAdder
    port map (
        a => regRom1,
        b => regRom2,
        c_in => '0',
        c_out => c_out,
        s => regAdder
      );
      
p: process(CLK)
begin
    
    if(clk'event and clk='1') then
            if (RST='1') then
            s <= S0;
        end if;
            case s is
                 when S0 =>
                    if(Start = '1') then
                        s <= S1;
                    else
                        s <= S0;
                    end if;
                 when S1 =>
                    readRom <= '1'; --Carico dati dalle ROM
                    --L'adder fa la somma e la mette in redAdder
                    s <= S2;
                 when S2 =>
                    readRom <= '0';
                    s <= S3;
                 when S3 =>
                    
                    Y <= regAdder; --Mando dato
                    Rts <= '1'; --Mando leggi
                    s <= S4;
                 when S4 =>
                    if Eop = '1' then --Se B ha finito
                        s <= S5;
                    else
                        s <= S4;
                    end if;
                 when S5 => 
                    Rts <= '0';
                    enCount <= '1'; --incremento il contatore
                    s <= S6;
                 when S6 =>
                    enCount <= '0';
                    if(fineCount = '1') then --ho finito, il counter si è resettato
                        s <= S0;
                    else 
                        s <= S1;
                    end if;
                        
             end case;
             
    end if;
  
end process;
end NodoA_arc;
