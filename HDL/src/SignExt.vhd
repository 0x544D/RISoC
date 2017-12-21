----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.09.2017 16:22:20
-- Design Name: 
-- Module Name: SignExt - Behavioral
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

entity SignExt is
    generic (   WIDTH_IN : natural := 32;
                WIDTH_OUT : natural := 64 );
    Port ( i : in STD_LOGIC_VECTOR (WIDTH_IN-1 downto 0);
           o : out STD_LOGIC_VECTOR (WIDTH_OUT-1 downto 0));
end SignExt;

architecture Behavioral of SignExt is

begin
    o <= (WIDTH_OUT-1 downto WIDTH_IN => i(WIDTH_IN-1)) & i;
end Behavioral;
