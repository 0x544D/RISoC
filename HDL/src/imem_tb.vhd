----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.09.2017 11:33:06
-- Design Name: 
-- Module Name: imem_tb - Behavioral
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

entity imem_tb is
--  Port ( );
end imem_tb;

architecture Behavioral of imem_tb is

    -- components
    component imem is
        generic(WIDTH : natural := 32; NUM_OF_INSTR : natural := 256);
        Port ( ReadAddr : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
               Instr : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    -- signals
    signal ReadAddr, Instr : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

begin

    dut: imem
        generic map( WIDTH => 32, NUM_OF_INSTR => 256)
        port map(
                    ReadAddr    => ReadAddr,
                    Instr       => Instr
        );

        
    stim_proc: process
    begin
        wait for 50 ns;
        
        for i in 0 to 50 loop
            ReadAddr <= std_logic_vector(to_unsigned(i,32));
            wait for 10 ns; 
        end loop;
    
        -- end simulation
        assert false report "simulation ended" severity failure;
    
    end process;


end Behavioral;
