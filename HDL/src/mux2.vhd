----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2017 12:31:44
-- Design Name: 
-- Module Name: mux_gen - Behavioral
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


entity mux2 is
    generic (WIDTH : integer := 8);
    port (  in0, in1 : in std_logic_vector(WIDTH-1 downto 0);
            sel : in std_logic;
            o : out std_logic_vector(WIDTH-1 downto 0)
    );
end mux2;

architecture Behavioral of mux2 is

begin

    process(sel)
    begin
        case sel is
            when '0' => o <= in0;
            when '1' => o <= in1;
            when others => report "MUX addressing error" severity failure;
        end case;
    end process;
                        

end Behavioral;
