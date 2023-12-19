----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 18:21:53
-- Design Name: 
-- Module Name: OP - Behavioral
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

entity OP is
    port (X0,X1,X2,X3: in std_logic_vector(1 downto 0);
    src, dst: in std_logic_vector(1 downto 0);
    Y0, Y1, Y2, Y3: out std_logic_vector(1 downto 0));
end OP;

architecture structural of OP is
component switch is --dimensione del pacchetto dati 
port(X0 , X1: in std_logic_vector (1 downto 0); 
ss, sd: in std_logic; 
--selezione mux e demux 
Y0, Y1: out std_logic_vector (1 downto 0));


end component; 
signal t10 , t11 , t20 , t21: std_logic_vector (1 downto 0); 
begin
s1: switch
 port map(X0 ,X1 ,src(0),dst(1),t10 ,t11);
s2: switch 
port map(X2 ,X3 ,src(0),dst(1),t20 ,t21);
s3: switch 
port map(t10 ,t20 ,src(1),dst(0),Y0,Y1);
s4: switch
 port map(t11 ,t21 ,src(1),dst(0),Y2,Y3);


end structural;
