----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2017 16:15:59
-- Design Name: 
-- Module Name: alu_tb - Behavioral
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

--library xil_defaultlib;
--use xil_defaultlib.txt_util.all;
library work;
use work.txt_util.all;

entity alu_tb is
end alu_tb;

architecture Behavioral of alu_tb is

    -- ALU declaration
    component alu is
        generic (WIDTH : integer := 32);
        Port ( AluCtrl : in STD_LOGIC_VECTOR (3 downto 0);
               A : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
               B : in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
               AluResult : out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
               Zero : out STD_LOGIC);
    end component;
    
    -- input signals
    signal AluCtrl : std_logic_vector(3 downto 0) := "1111";
    signal A, B : std_logic_vector(31 downto 0);
    
    -- output signals
    signal AluResult : std_logic_vector(31 downto 0);
    signal Zero : std_logic;

begin

    -- instantiate ALU
    dut : alu
        generic map(WIDTH => 32)
        port map(
            AluCtrl     =>  AluCtrl,
            A           =>  A,
            B           =>  B,
            AluResult   =>  AluResult,
            Zero        =>  Zero
        );
        
    -- Test process
    stim_proc: process
        variable errors : integer := 0;    
    begin
        wait for 10 ns;
        report "Resetting all inputs";
        A <= (others=>'0');
        B <= (others=>'0');
        AluCtrl <= "1111";
        
        report "Starting ALU Test" severity warning;
        report "Testing IDLE state or invalid operation of Alu";
        if to_integer(signed(AluResult)) /= 0 then
            report "ERROR: IDLE or invalid operation yields unexpected value! AluResult = " & integer'image(to_integer(signed(AluResult)));
            errors := errors + 1;
        end if;
        
        wait for 10 ns;
        report "Testing AND Operation";
        AluCtrl <= "0000";
        A <= X"FFFFFFFF";
        B <= X"0000FFFF";
        wait for 1 ns;
        if AluResult /= X"0000FFFF" then
            report "ERROR: AND operation yields unexpected value! AluResult = " & hstr(AluResult);       
            errors := errors + 1;
        end if;
        
        wait for 10 ns;
        report "Testing OR Operation";
        AluCtrl <= "0001";
        A <= X"55555555";
        B <= X"AAAAAAAA";
        wait for 1 ns;
        if AluResult /= X"FFFFFFFF" then
            report "ERROR: OR operation yields unexpected value! AluResult = " & hstr(AluResult);       
            errors := errors + 1;
        end if;
        
        wait for 10 ns;
        report "Testing ADD Operation";
        AluCtrl <= "0010";
        A <= std_logic_vector(to_signed(23,32));
        B <= std_logic_vector(to_signed(42,32));
        wait for 1 ns;
        if to_integer(signed(AluResult)) /= 65 then
            report "ERROR: ADD operation yields unexpected value! AluResult = " & hstr(AluResult);       
            errors := errors + 1;
        end if;
        
        A <= X"FFFFFFFF";
        B <= X"00000001";
        wait for 1 ns;
        if to_integer(signed(AluResult)) /= 0 then
            report "ERROR: ADD operation yields unexpected value! AluResult = " & hstr(AluResult);       
            errors := errors + 1;
        end if;
        
        wait for 10 ns;
        report "Testing SUB Operation";
        AluCtrl <= "0110";
        A <= std_logic_vector(to_signed(23,32));
        B <= std_logic_vector(to_signed(42,32));
        wait for 1 ns;
        if to_integer(signed(AluResult)) /= -19 then
            report "ERROR: SUB operation yields unexpected value! AluResult = " & hstr(AluResult);       
            errors := errors + 1;
        end if;
        
        A <= X"00000000";
        B <= X"00000001";
        wait for 1 ns;
        if to_integer(signed(AluResult)) /= -1 then
            report "ERROR: SUB operation yields unexpected value! AluResult = " & hstr(AluResult);       
            errors := errors + 1;
        end if;
        
        wait for 10 ns;
        report "Testing SLT Operation";
        AluCtrl <= "0111";
        A <= std_logic_vector(to_signed(23,32));
        B <= std_logic_vector(to_signed(42,32));
        wait for 1 ns;
        if to_integer(signed(AluResult)) /= 1 then
            report "ERROR: SLT operation yields unexpected value! AluResult = " & hstr(AluResult);       
            errors := errors + 1;
        end if;
        
        A <= X"00002222";
        B <= X"00000001";
        wait for 1 ns;
        if to_integer(signed(AluResult)) /= 0 then
            report "ERROR: SLT operation yields unexpected value! AluResult = " & hstr(AluResult);       
            errors := errors + 1;
        end if;
        
        wait for 10 ns;
        report "Testing NOR Operation";
        AluCtrl <= "1100";
        A <= X"00000000";
        B <= X"00000000";
        wait for 1 ns;
        if AluResult /= X"FFFFFFFF" then
            report "ERROR: NOR operation yields unexpected value! AluResult = " & hstr(AluResult);       
            errors := errors + 1;
        end if;
        
        
        
        report "Numbers of ERRORS: " & integer'image(errors);
               
        -- end simulation
        assert false report "simulation ended" severity failure;
        
    
    end process;

    process(A,B,AluCtrl)
    begin
        -- check zero flag
        if AluResult = X"00000000" then
            if Zero /= '1' then
                report "ERROR: Zero bit not set!";
            end if;
        end if;
      
    end process;

end Behavioral;
