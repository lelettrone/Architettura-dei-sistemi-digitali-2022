----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.12.2021 18:29:21
-- Design Name: 
-- Module Name: OmegaNetwork - Behavioral
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

entity OmegaNetwork is
 Port (S0, S1,S2, S3: in std_logic_vector(5 downto 0);
 E: in std_logic_vector(3 downto 0) ;
 Y0, Y1, Y2, Y3: out std_Logic_vector(1 downto 0));
 
end OmegaNetwork;

architecture structural of OmegaNetwork is
component CU is
          Port (
    A0, A1, A2, A3: in std_logic_vector(5 downto 0);
    en0, en1, en2, en3: in std_logic;
    B0,B1,B2,B3: out std_logic_vector(1 downto 0);
    s,d: out std_logic_vector(1 downto 0) );
    end component;
component OP is
   port (X0,X1,X2,X3: in std_logic_vector(1 downto 0);
    src, dst: in std_logic_vector(1 downto 0);
    Y0, Y1, Y2, Y3: out std_logic_vector(1 downto 0));
end component;
signal X0, X1, X2, X3: std_logic_vector(1 downto 0);
signal src, dst: std_Logic_vector(1 downto 0);
begin
control_unit: CU
port map(S0,S1,S2,S3, E(0), E(1), E(2), E(3),X0,X1,X2,X3,src,dst);
op_unit: OP
port map(X0,X1,X2,X3, src, dst, Y0,Y1,Y2,Y3);

end structural;
