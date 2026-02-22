----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2024 09:44:34 AM
-- Design Name: 
-- Module Name: main - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
  Port ( F0,F1,F2,F3 : in std_logic;
     BTN_EliberareCola: in std_logic;
     AcceptareMoneda: out std_logic
  );

end main;

architecture Behavioral of main is

component MUX4la1 is
    Port (  F0: in std_logic;
     F1: in std_logic;
     F2: in std_logic;
     F3 : in std_logic;
     MonedaIntrodusa: out std_logic_vector(7 downto 0) 
    );
end component;

component adder is
  Port ( A,B: in std_logic;
  Cin: in std_logic := '0';
  S: out std_logic := '0';
  Cout: out std_logic
  );
end component;

component adder8b is
 Port ( A,B: in std_logic_vector(7 downto 0);
  Cin: in std_logic := '0';
  Sum: out std_logic_vector(7 downto 0) := "00000000";
  Cout: out std_logic
  );
end component;
signal SumaTotala: std_logic_vector(7 downto 0) := "00000000";
signal RestMoneda: std_logic_vector(7 downto 0) := "00000000";

signal Suma: std_logic_vector(7 downto 0) := "00000000";
signal ColaColaStock: std_logic_vector(7 downto 0) := "00000001";
signal EliberareCola: std_logic := '0';
signal CoutFinal: std_logic;
signal Cin: std_logic := '0';
signal COIN_temp: std_logic_vector(7 downto 0);
signal continue: std_logic := '1';
signal final: std_logic := '0';
begin
  et1: MUX4la1 port map(
            F0 => F0,
            F1 => F1,
            F2 => F2,
            F3 => F3,
            MonedaIntrodusa => COIN_temp);
    et2: adder8b port map(
            A => COIN_temp,
            B => Suma,
            Cin => Cin,
            Sum => SumaTotala,
            Cout => CoutFinal);

process(SumaTotala,final)
begin
if final = '0' then
    Suma <= SumaTotala after 100ns;
else 
    Suma <= "00000000" after 100ns;
    final <= '0';
end if;
end process;

process(Suma, F0,F1,F2,F3, BTN_EliberareCola)
begin

if F3 = '1' then
    AcceptareMoneda <= '0';
  else
    AcceptareMoneda <= '1';
end if;
final <= '0';
EliberareCola <= '0';

    if continue = '1' then
    if( BTN_EliberareCola = '1' and Suma = "01100100" and ColaColaStock > "00000000") then -- daca este 100bani = 1 leu
            EliberareCola <= '1';
            ColaColaStock <= ColaColaStock - '1'; 
            final <= '1';
    elsif ( BTN_EliberareCola = '1' and Suma < "01100100") then
        RestMoneda <= Suma;
        final <= '1';
    elsif (BTN_EliberareCola = '0' and ColaColaStock > "00000000" and Suma < "01100100") then
        continue <= '1';
    elsif(BTN_EliberareCola = '1' and Suma > "01100100" and ColaColaStock > "00000000") then
        RestMoneda <= Suma - "01100100"; -- Suma - 100
        EliberareCola <= '1';
        ColaColaStock <= ColaColaStock - '1';
        final <= '1';
    elsif(BTN_EliberareCola = '1' and Suma > "01100100" and ColaColaStock = "00000000") then
         EliberareCola <= '0';
         RestMoneda <= Suma;
         final <= '1';
    end if;
    end if;
end process;

end Behavioral;
