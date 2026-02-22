----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2024 09:13:33 AM
-- Design Name: 
-- Module Name: MUX4la1 - Behavioral
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

entity MUX4la1 is
    Port ( F0: in std_logic := '0';
     F1: in std_logic := '0';
     F2: in std_logic := '0';
     F3 : in std_logic := '0';
     MonedaIntrodusa: out std_logic_vector(7 downto 0)  
    );
end MUX4la1;

architecture Behavioral of MUX4la1 is
signal F0_value: std_logic_vector(7 downto 0) := "00000101";
signal F1_value: std_logic_vector(7 downto 0) := "00001010";
signal F2_value: std_logic_vector(7 downto 0) := "00110010";
signal F3_value : std_logic_vector(7 downto 0) := "00000000";
signal S0,S1: std_logic := '0';
begin

process(F0,F1,F2,F3)
begin
    if F0 = '1' then
        S0 <= '0';
        S1 <= '0';
    elsif F1 = '1' then
        S0 <= '0';
        S1 <= '1';
    elsif F2 = '1' then
        S0 <= '1';
        S1 <= '0';
    else
        S0 <= '1';
        S1 <= '1';
     end if;
end process;

process(F0,F1,F2,F3, S0,S1) 
begin
    if S0 = '0' and S1 = '0' then
        MonedaIntrodusa <= F0_value;
    elsif S0 = '0' and S1 = '1' then
        MonedaIntrodusa <= F1_value;
    elsif S0 = '1' and S1 = '0' then
        MonedaIntrodusa <= F2_value;
    else
        MonedaIntrodusa <= F3_value;  
     end if;
end process;

end Behavioral;
