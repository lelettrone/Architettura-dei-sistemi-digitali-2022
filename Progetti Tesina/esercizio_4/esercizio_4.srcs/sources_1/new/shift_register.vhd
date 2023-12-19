----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2021 16:59:00
-- Design Name: 
-- Module Name: shift_register - Structural
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

entity shift_register is
    Port (
        input: in std_logic;
        output: out std_logic_vector(0 to 3);
        clock_in: in std_logic;
        reset_in: in std_logic;
        Y: in std_logic;    --{1,2}
        v: in std_logic;     --{S,D}
        en: in std_logic
     );
end shift_register;

architecture Structural of shift_register is

component mux4_1 
    Port ( 
        a: in std_logic_vector(0 to 3);
        c: in std_logic_vector(0 to 1);
        y: out std_logic
  );
end component;

component cell 
    Port(
        ing: in std_logic;
        usc: out std_logic;
        clk: in std_logic;
        enable: in std_logic;
        rst: in std_logic
    );
end component;

signal mux_out: std_logic_vector(0 to 3);
signal cell_out: std_logic_vector(0 to 3);

begin
    output(0 to 3) <= cell_out(0 to 3);
    m0: mux4_1
        port map(
            a(0) => input, --00 SHIFT 1 ->
            a(1) => cell_out(1), --01 SHIFT 1 <-
            a(2) => '0', -- 10 SHIFT ->> (non ci sta cella)
            a(3) => cell_out(2), --11 SHIFT <<- 
            c(0) => Y,
            c(1) => v,
            y => mux_out(0)
        );
   
     m1: mux4_1
        port map(
            a(0) => cell_out(0), --00 SHIFT 1 ->
            a(1) => cell_out(2), --01 SHIFT 1 <-
            a(2) => input, -- 10 SHIFT ->>
            a(3) => cell_out(3), --11 SHIFT <<- 
            c(0) => Y,
            c(1) => v,
            y => mux_out(1)
        );
      m2: mux4_1
        port map(
            a(0) => cell_out(1), --00 SHIFT 1 ->
            a(1) => cell_out(3), --01 SHIFT 1 <-
            a(2) => cell_out(0), -- 10 SHIFT ->>
            a(3) => input, --11 SHIFT <<- 
            c(0) => Y,
            c(1) => v,
            y => mux_out(2)
        );
        
      m3: mux4_1
        port map(
            a(0) => cell_out(2), --00 SHIFT 1 ->
            a(1) => input, --01 SHIFT 1 <-
            a(2) => cell_out(1), -- 10 SHIFT ->>
            a(3) => '0', --11 SHIFT <<- 
            c(0) => Y,
            c(1) => v,
            y => mux_out(3)
        );

      c0: cell
        port map(
            ing => mux_out(0),
            usc =>cell_out(0),
            clk => clock_in,
            enable => en,
            rst => reset_in
        );
        
        c1: cell
        port map(
            ing => mux_out(1),
            usc =>cell_out(1),
            clk => clock_in,
            enable => en,
            rst => reset_in
        );
        c2: cell
        port map(
            ing => mux_out(2),
            usc => cell_out(2),
            clk => clock_in,
            enable => en,
            rst => reset_in
        );
        c3: cell
        port map(
            ing => mux_out(3),
            usc => cell_out(3),
            clk => clock_in,
            enable => en,
            rst => reset_in
        );       
end Structural;

