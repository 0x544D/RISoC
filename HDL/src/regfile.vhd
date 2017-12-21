----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.09.2017 16:39:39
-- Design Name: 
-- Module Name: regfile - Behavioral
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

entity regfile is
    generic(WIDTH : natural := 32; NUM_REGS : natural := 32);
    Port (  clk, nres : in STD_LOGIC;
            ReadAddr1 : in STD_LOGIC_VECTOR (4 downto 0);
            ReadAddr2 : in STD_LOGIC_VECTOR (4 downto 0);
            WriteAddr : in STD_LOGIC_VECTOR (4 downto 0);
            WriteData : in STD_LOGIC_VECTOR (31 downto 0);
            WE   : in STD_LOGIC;
            ReadData1 : out STD_LOGIC_VECTOR (31 downto 0);
            ReadData2 : out STD_LOGIC_VECTOR (31 downto 0)
        );
end regfile;

architecture Behavioral of regfile is
    -- registers
    type regs_t is array (0 to NUM_REGS-1) of std_logic_vector(WIDTH-1 downto 0);
    signal regs : regs_t;

begin
    
    process(clk)
    begin
        if rising_edge(clk) then
            if nres = '0' then
                -- set all regs to zero
                regs <= (others => (others => '0'));
            else
                if WE = '1' then
                    regs(to_integer(unsigned(WriteAddr))) <= WriteData;
                end if; 
            end if;
        end if;
    end process;
    
    -- asynchronous read
    ReadData1 <= regs(to_integer(unsigned(ReadAddr1)));
    ReadData2 <= regs(to_integer(unsigned(ReadAddr2)));

end Behavioral;
