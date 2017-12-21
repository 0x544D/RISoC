----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.09.2017 16:07:57
-- Design Name: 
-- Module Name: reg - Behavioral
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

entity reg is
    generic(WIDTH : natural := 32);
    Port ( D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           clk : in STD_LOGIC;
           nres : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
end reg;

architecture Behavioral of reg is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if nres = '0' then
                Q <= (others => '0');
            else
                Q <= D;
            end if;
        end if;
    end process;
end Behavioral;
