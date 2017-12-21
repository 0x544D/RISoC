----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.09.2017 15:53:40
-- Design Name: 
-- Module Name: riscv_datapath - Behavioral
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

entity riscv_datapath is
    generic (WIDTH : natural := 32; PC_INC : natural := 4);
    Port ( clk : in STD_LOGIC;
           nres : in STD_LOGIC);
end riscv_datapath;

architecture Behavioral of riscv_datapath is

    -- components
    component reg is
        generic(WIDTH : natural := 32);
        Port ( D : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
               clk : in STD_LOGIC;
               nres : in STD_LOGIC;
               Q : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
    end component;
    
    component adder is
        generic(WIDTH : natural := 32);
        Port ( a : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
               b : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
               y : out STD_LOGIC_VECTOR (WIDTH-1 downto 0));
    end component;
    
    -- signals
    signal pc, pc_new, pc_plus_inc: STD_LOGIC_VECTOR(WIDTH-1 downto 0);

begin

    -- instantiate program counter
    pc_reg: reg
        generic map (WIDTH => WIDTH)
        port map(
            D => pc_new,
            clk => clk,
            nres => nres,
            Q => pc
        );
        
    -- instantiate PC adder
    pc_add: adder
        generic map (WIDTH => WIDTH)
        port map(
            a => pc,
            b => STD_LOGIC_VECTOR(to_unsigned(PC_INC,32)),
            y => pc_plus_inc
        );
        


end Behavioral;
