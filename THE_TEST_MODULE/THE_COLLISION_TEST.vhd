--------------------------------------------------------------------------------
-- Company: <Name>
-- Targeted device: <Family::PolarFire> <Die::MPF300T> <Package::FCG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity THE_COLLISION_TEST is
port (

	CLK : IN  std_logic; 
    RESET : IN std_logic;
    BIT_IN : IN std_logic;
    LEVEL : OUT std_logic_vector(2 downto 0)
);
end THE_COLLISION_TEST;
architecture architecture_THE_COLLISION_TEST of THE_COLLISION_TEST is
    
    signal COUNT : std_logic_vector(11 downto 0);
	signal BIT_1 : std_logic;
    signal BIT_2 : std_logic;
    type FSM is (S_IDLE, S_0, S_1);
    signal STATE: FSM := S_IDLE;
    
    -- cut-off values
	constant L1 : std_logic_vector(11 downto 0) := "001010010010"; --658
    constant L2 : std_logic_vector(11 downto 0) := "010000010110"; --1046
    constant L3 : std_logic_vector(11 downto 0) := "010100011000"; --1304
    constant L4 : std_logic_vector(11 downto 0) := "010111000100"; --1476
    constant L5 : std_logic_vector(11 downto 0) := "011000110000"; --1584
    constant L6 : std_logic_vector(11 downto 0) := "011001110000"; --1648
    constant L7 : std_logic_vector(11 downto 0) := "011010001110"; --1678


begin

    process(CLK) --Two registers for bit 1 and 2
    begin
        if (RISING_EDGE(CLK)) then
            BIT_2 <= BIT_1;
            BIT_1 <= BIT_IN;
        end if;
    end process;
    
    
    process(CLK, RESET) --FSM
    begin
        if RESET = '0' then
            COUNT <= (OTHERS => '0');
            STATE <= S_IDLE;
        elsif RISING_EDGE(CLK) then
            case STATE is 
                when S_IDLE =>
                    STATE <= S_0;
                when S_0 =>
                    STATE <= S_1;
                when S_1 =>
                    if BIT_1 /= BIT_2 then
                        STATE <= S_IDLE;
                        COUNT <= COUNT + 1;
                    else
                        STATE <= S_0;
                    end if;
                when OTHERS =>
                    STATE <= S_IDLE;
            end case;
        end if;
    end process;
    
    process(CLK, RESET) --Comparator
    begin
        if RESET = '0' then
            LEVEL <= "000";
        elsif (CLK = '1' and CLK'event) then
            if COUNT < L1 then
                LEVEL <= "000";
            elsif COUNT < L2 then
                LEVEL <=  "001";
            elsif COUNT < L3 then
                LEVEL <=  "010";
            elsif COUNT < L4 then
                LEVEL <=  "011";
            elsif COUNT < L5 then
                LEVEL <=  "100";
            elsif COUNT < L6 then
                LEVEL <=  "101";
            elsif COUNT < L7 then
                LEVEL <=  "110";
            else
                LEVEL <= "111";
            end if;
        end if;
    end process;
end architecture_THE_COLLISION_TEST;
