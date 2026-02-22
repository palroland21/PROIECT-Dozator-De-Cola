----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2024 09:37:06 AM
-- Design Name: 
-- Module Name: adder7b - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: -- Description: 
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

entity adder8b is
 Port ( A,B: in std_logic_vector(7 downto 0) := "00000000";
  Cin: in std_logic := '0';
  Sum: out std_logic_vector(7 downto 0) := "00000000";
  Cout: out std_logic
  );
end adder8b;

architecture Behavioral of adder8b is

component adder is
  Port ( A,B: in std_logic;
  Cin: in std_logic := '0';
  S: out std_logic := '0';
  Cout: out std_logic
  );
end component;

signal carry: std_logic_vector(6 downto 0);

begin
    et1: adder port map(A(0),B(0),Cin,Sum(0), carry(0));
    et2: adder port map(A(1),B(1),carry(0),Sum(1), carry(1));
    et3: adder port map(A(2),B(2),carry(1),Sum(2), carry(2));
    et4: adder port map(A(3),B(3),carry(2),Sum(3), carry(3));
    et5: adder port map(A(4),B(4),carry(3),Sum(4), carry(4));
    et6: adder port map(A(5),B(5),carry(4),Sum(5), carry(5));
    et7: adder port map(A(6),B(6),carry(5),Sum(6), carry(6));
    et8: adder port map(A(7),B(7),carry(6),Sum(7), Cout);
end Behavioral;
