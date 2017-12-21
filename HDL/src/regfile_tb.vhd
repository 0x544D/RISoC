----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.09.2017 14:58:05
-- Design Name: 
-- Module Name: regfile_tb - Behavioral
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

entity regfile_tb is
--  Port ( );
end regfile_tb;

architecture Behavioral of regfile_tb is

    -- components
    component regfile is
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
    end component;


    -- input signals
    signal clk, WE : STD_LOGIC := '0';
    signal nres : STD_LOGIC := '1';
    signal ReadAddr1, ReadAddr2, WriteAddr : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
    signal WriteData : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    
    -- output signals
    signal ReadData1, ReadData2 : STD_LOGIC_VECTOR(31 downto 0);


begin

    -- instantiate regfile
    dut : regfile
        generic map(WIDTH => 32, NUM_REGS => 32)
        port map(
                    clk         => clk, 
                    nres        => nres,
                    ReadAddr1   => ReadAddr1,
                    ReadAddr2   => ReadAddr2,
                    WriteAddr   => WriteAddr,
                    WriteData   => WriteData,
                    WE          => WE,
                    ReadData1   => ReadData1,
                    ReadData2   => ReadData2
        );
        
    -- Test process
    stim_proc: process
        variable errors : integer := 0;    
    begin
        
        wait for 50 ns;
        
        -- reset
        nres <= '0';
        wait for 50 ns;
        -- release reset
        nres <= '1';
        
        wait for 50 ns;
        
        -- start of testbench
        -- write 0 to 31 in the 32 regs
        for i in 0 to 31 loop
            wait until falling_edge(clk);
            WriteData <= std_logic_vector(to_unsigned(i,32));
            WriteAddr <= std_logic_vector(to_unsigned(i,5));
            WE <= '1';
        end loop;
        wait until falling_edge(clk);
        WE <= '0';
        
        wait for 50 ns;
        
        -- read previously written values
        for j in 0 to 15 loop
            ReadAddr1 <= std_logic_vector(to_unsigned(j,5));
            ReadAddr2 <= std_logic_vector(to_unsigned(j+1,5));
            
            -- wait a little
            wait for 5 ns;
            
            if ReadData1 /= std_logic_vector(to_unsigned(j,5)) then
                report "Read data is not expected value " & integer'image(j) & ", but is " & integer'image(to_integer(unsigned(ReadData1))) severity warning;
            end if;
            
            if ReadData2 /= std_logic_vector(to_unsigned(j+1,5)) then
                report "Read data is not expected value " & integer'image(j+1) & ", but is " & integer'image(to_integer(unsigned(ReadData2))) severity warning;
            end if;
            
            wait for 5 ns;

        end loop;
        
        wait for 50 ns;
        
        report "Numbers of ERRORS: " & integer'image(errors);
               
        -- end simulation
        assert false report "simulation ended" severity failure;
        
    
    end process;

    -- clk process
    clk <= not clk after 5 ns;
    

end Behavioral;