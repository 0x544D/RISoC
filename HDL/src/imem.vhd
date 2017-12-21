----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.09.2017 16:20:05
-- Design Name: 
-- Module Name: imem - Behavioral
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

library STD;
use STD.textio.all;                     -- basic I/O

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity imem is
    generic(WIDTH : natural := 32; NUM_OF_INSTR : natural := 256);
    Port ( ReadAddr : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
           Instr : out STD_LOGIC_VECTOR (31 downto 0));
end imem;

architecture Behavioral of imem is

    type imem_t is array (0 to NUM_OF_INSTR-1) of std_logic_vector(31 downto 0);
    
    function init_mem(filename : string) return imem_t is
        file FileHandle         : TEXT open READ_MODE is filename;
        variable CurrentLine    : LINE;
        variable TempWord     : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
        variable Result       : imem_t    := (others => (others => '0'));
       
    begin
        for i in 0 to NUM_OF_INSTR - 1 loop
        exit when endfile(FileHandle);
    
        readline(FileHandle, CurrentLine);
        hread(CurrentLine, TempWord);
        Result(i)    := TempWord;
      end loop;
    
      return Result;    
         
    end function;


    -- instruction memory array
    signal mem : imem_t := init_mem("./IMEM.HEX");
    
    

begin
  
    -- asynchronous output of instructions
    Instr <= mem(to_integer(unsigned(ReadAddr)));

end Behavioral;
