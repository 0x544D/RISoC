----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2017 15:40:14
-- Design Name: 
-- Module Name: alu - Behavioral
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

entity alu is
    generic (WIDTH : integer := 32);
    Port ( AluCtrl : in STD_LOGIC_VECTOR (3 downto 0);
           A : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           B : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           AluResult : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           Zero : out STD_LOGIC);
end alu;

architecture Behavioral of alu is

    signal Result : std_logic_vector(WIDTH-1 downto 0) := (others=>'0');

begin

    process(A,B,AluCtrl)
    begin
        case AluCtrl is
            when "0000" => Result <= A and B;
            when "0001" => Result <= A or B;
            when "0010" => Result <= std_logic_vector(signed(A) + signed(B));
            when "0110" => Result <= std_logic_vector(signed(A) - signed(B));
            when "0111" =>
                if A < B then
                    Result <= (WIDTH-1 downto 1 =>'0') & '1';
                else
                    Result <= (others=>'0');
                end if;
            when "1100" => Result <= not(A or B);
            when others => Result <= (others => '0');
        end case;
        
        if Result = std_logic_vector(to_unsigned(0,32)) then
          Zero <= '1';
        else
          Zero <= '0';
        end if;
        
    end process;
    
    -- Zero flag
    --with Result select Zero <=
    --    '1' when (others => '0'),
    --    '0' when others;
    
    AluResult <= Result;

end Behavioral;
