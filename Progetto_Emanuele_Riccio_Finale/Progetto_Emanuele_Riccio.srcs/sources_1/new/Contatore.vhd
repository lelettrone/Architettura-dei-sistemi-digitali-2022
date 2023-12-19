----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.11.2021 12:42:18
-- Design Name: 
-- Module Name: contatore - Behavioral
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
use ieee.numeric_std.all;

entity Contatore is
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
end Contatore;

architecture Behavioral of Contatore is

signal ty: std_logic;
signal last_enset: std_logic;
signal last_clk: std_logic;


begin
process(clk,rst,enable)
variable count: integer  := 0;
    begin
        if(rst = '1') then
            count := 0;
            fine <= '0';
        end if;
        if falling_edge(clk) then
            if(enable = '1') then
                if(count = N-1) then
                    count := 0;
                    fine <= '1';
                else 
                count := count +1;
                fine <= '0';
                end if;
          end if;
       end if;
       count_out <= count;
end process;
end Behavioral;
