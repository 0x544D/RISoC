----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.09.2017 18:04:51
-- Design Name: 
-- Module Name: shifter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shifter is
    generic (WIDTH : natural := 32; SHIFT_AMOUNT : natural := 2);
    Port ( i : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           o : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end shifter;

architecture Behavioral of shifter is

begin
    
    o <= std_logic_vector(shift_left(unsigned(i),SHIFT_AMOUNT));
    
end Behavioral;
