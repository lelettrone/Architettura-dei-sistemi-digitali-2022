----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2021 15:10:15
-- Design Name: 
-- Module Name: shift_register_beha - Behavioral
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

entity shift_register_beha is
     Port (
            input: in std_logic;
            output: out std_logic_vector(0 to 3);
            clock_in: in std_logic;
            reset_in: in std_logic;
            Y: in std_logic;    --{1,2}
            v: in std_logic;     --{S,D}
            en: in std_logic 
      );
end shift_register_beha;

architecture Behavioral of shift_register_beha is
signal lastEn : std_logic := '0';
signal cell_out : std_logic_vector(0 to 3) := "0000";

begin
process(clock_in)
    begin
    
    if rising_edge(clock_in) then
        if (reset_in = '1') then
            output(0 to 3) <= "0000";
        elsif(en='1' and lastEn='0') then
            if(Y='0' and v='0') then
                    cell_out(0) <= input;
                    cell_out(1) <= cell_out(0);
                    cell_out(2) <= cell_out(1);
                    cell_out(3) <= cell_out(2);
            elsif(Y='0' and v='1') then
                    cell_out(3) <= input;
                    cell_out(2) <= cell_out(3);
                    cell_out(1) <= cell_out(2);
                    cell_out(0) <= cell_out(1);
            elsif(Y='1' and v='0') then
                    cell_out(0) <= '0';
                    cell_out(1) <= input;
                    cell_out(2) <= cell_out(0);
                    cell_out(3) <= cell_out(1);
            else --Y='1' and v='1'
                    cell_out(3) <= '0';
                    cell_out(2) <= input;
                    cell_out(1) <= cell_out(3);
                    cell_out(0) <= cell_out(2);
            end if;
        end if;
    lastEn <= en;
    --output(0 to 3) <= cell_out(0 to 3);
    end if;
    output(0 to 3) <= cell_out(0 to 3);

end process;
--output(0 to 3) <= cell_out(0 to 3);
end Behavioral;

--Lo metto fuori dal process cosi' da farlo CONCORRENTE al process -> diventa un collegamento
--altrimenti avrei dovuto refreshare ogni volta nel process
