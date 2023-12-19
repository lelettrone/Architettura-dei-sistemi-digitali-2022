----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 16:24:29
-- Design Name: 
-- Module Name: CU - Behavioral
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

entity CU is
    Port (
    A0, A1, A2, A3: in std_logic_vector(5 downto 0);
    en0, en1, en2, en3: in std_logic;
    B0,B1,B2,B3: out std_logic_vector(1 downto 0);
    s,d: out std_logic_vector(1 downto 0) );
end CU;

architecture structural of CU is
    component mux_41 is
          port(X0, X1, X2, X3: in std_logic_vector(1 downto 0);
            s: in std_logic_vector(1 downto 0);
            Y: out std_logic_vector(1 downto 0));
    end component;
    component dem_14 is
         port(X: in std_logic_vector(1 downto 0);
            s: in std_logic_vector(1 downto 0);
            Y0, Y1, Y2, Y3: out std_logic_vector(1 downto 0));
    end component;
    component priority is
         Port (en0, en1, en2, en3: in std_logic;
         y: out std_logic_vector(1 downto 0) );
    end component;
    
    signal t_sel: std_logic_vector(1 downto 0);
    signal t_y: std_logic_vector(1 downto 0);
begin
    mux: mux_41
    --A0(1 downto 0) DATO input
    port map(A0(1 downto 0), A1(1 downto 0), A2(1 downto 0), A3(1 downto 0),t_sel, t_y);
    demux: dem_14
    --B DATO output
    port map(t_y, t_sel, B0,B1,B2,B3);
    arb: priority
    port map(en0, en1, en2, en3, t_sel);
    
    --bit selezione Source della rete Omega
    s <=    A0(5 downto 4) when t_sel = "00" else
            A1(5 downto 4) when t_sel = "01" else
            A2(5 downto 4) when t_sel = "10" else
            A3(5 downto 4) when t_sel = "11" else
            "--";
    --bit selezione Dest della rete Omega
    d <=    A0(3 downto 2) when t_sel = "00" else
            A1(3 downto 2) when t_sel = "01" else
            A2(3 downto 2) when t_sel = "10" else
            A3(3 downto 2) when t_sel = "11" else
            "--";
    

end structural;
