----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 27.10.2021 17:12:27
-- Design Name:
-- Module Name: mux_16_1 - Structural
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

entity mux_16_1 is
    Port (
        b: in std_logic_vector(0 to 15);
        s: in std_logic_vector(3 downto 0);
        y0: out std_logic
    );
end mux_16_1;



architecture Structural of mux_16_1 is



signal u: std_logic_vector(0 to 3);



component mux_4_1
    port(
        a: in std_logic_vector(0 to 3);
        c: in std_logic_vector(1 downto 0);
        y: out std_logic
    );
end component;



begin
    mux_0_3: for i in 0 to 3 generate m: mux_4_1
        port map(
            a(0 to 3) => b(i*4 to i*4+3),
            c(1 downto 0) => s(1 downto 0),
            y => u(i)
    );
    end generate;

    mux_4: mux_4_1
        port map(
            a(0 to 3) => u(0 to 3),
            c(1 downto 0) => s(3 downto 2),
            y => y0
        );
end Structural;