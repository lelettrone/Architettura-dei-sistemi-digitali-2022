----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2021 20:05:05
-- Design Name: 
-- Module Name: button_interface - Behavioral
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

entity button_interface is
  Port ( 
    clock: in std_logic;
    btn_up: in std_logic;
    btn_dx: in std_logic;
    btn_sx: in std_logic;
    btn_dw: in std_logic;
    out_btn: out std_logic_vector(1 downto 0)
  );
end button_interface;

architecture Behavioral of button_interface is

signal last_btn_up: std_logic;
signal last_btn_dw: std_logic;
signal last_btn_sx: std_logic;
signal last_btn_dx: std_logic;

begin
process(clock)
begin
    if rising_edge(clock) then
        if(btn_up = '1' and last_btn_up = '0') then
            last_btn_up <= '1';
            out_btn <= "11";
        else last_btn_up <= '0';
            if(btn_dw = '1' and last_btn_dw = '0') then
                last_btn_dw <= '1';
                out_btn <= "10";
            else last_btn_dw <= '0';
                if(btn_dx = '1' and last_btn_dx = '0') then
                    last_btn_dx <= '1';
                    out_btn <= "01";
                else last_btn_dx <= '0';
                    if(btn_sx = '1' and last_btn_sx = '0') then
                        last_btn_sx <= '1';
                        out_btn <= "00";
                    else last_btn_sx <= '0';
                    end if;
                end if;
            end if;
        end if; 
    end if;
end process;    
end Behavioral;
