library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity switch is 
        port(X0, X1: in std_logic_vector(1 downto 0);
            ss, sd: in std_logic;
            Y0, Y1: out std_logic_vector(1 downto 0));
end switch;

architecture structural of switch is
    component mux_21 is
        port(X0, X1: in std_logic_vector(1 downto 0);
        s: in std_logic;
        Y: out std_logic_vector(1 downto 0));
    end component;
    component dem_12 is
        port(X: in std_logic_vector(1 downto 0);
        s: in std_logic;
        Y0, Y1: out std_logic_vector(1 downto 0));
    end component;
    signal temp_y: std_logic_vector(1 downto 0);
    begin
    
    mux: mux_21
        port map(X0, X1, ss, temp_y);
        
    dem: dem_12
        port map(temp_y, sd, Y0, Y1);
    
end structural;