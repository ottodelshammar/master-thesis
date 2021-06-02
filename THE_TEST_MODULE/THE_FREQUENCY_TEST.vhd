--------------------------------------------------------------------------------
-- Company: <Name>
-- Targeted device: <Family::PolarFire> <Die::MPF300T> <Package::FCG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------

--THIS TEST IS DERIVED FROM MOST COMMON VALUE ESTIMATE


library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity THE_FREQUENCY_TEST is
port (
	CLK : IN  std_logic; 
    RESET : IN std_logic;
    BIT_IN : IN std_logic;
    LEVEL : OUT std_logic_vector(2 downto 0)
);
end THE_FREQUENCY_TEST;

architecture architecture_THE_FREQUENCY_TEST of THE_FREQUENCY_TEST is
	
    signal COUNT : signed(13 downto 0);
    signal ABS_COUNT : std_logic_vector(13 downto 0);
    
    constant L1 : std_logic_vector(13 downto 0) := "01100111110100"; -- 6644
    constant L2 : std_logic_vector(13 downto 0) := "01010011000000"; --5314
    constant L3 : std_logic_vector(13 downto 0) := "01000000001110"; --4110
    constant L4 : std_logic_vector(13 downto 0) := "00101110111110"; --3006
    constant L5 : std_logic_vector(13 downto 0) := "00100000001100"; --2060
    constant L6 : std_logic_vector(13 downto 0) := "00010001011110"; --1118
    constant L7 : std_logic_vector(13 downto 0) := "00000100100110"; --294

begin
    UP_DN_COUNTER : process(CLK,RESET)
    begin 
        if (RESET = '0') then
            COUNT <= (OTHERS => '0');
            ABS_COUNT <= (OTHERS => '0');
        elsif RISING_EDGE(CLK) then
        
            if(BIT_IN = '1') then
                COUNT <= COUNT + 1;
            else
                COUNT <= COUNT - 1;
            end if;
            ABS_COUNT <= std_logic_vector(ABS(COUNT));
        end if;
    end process;
    
    COMPARATOR : process(CLK, RESET)
    begin
        if RESET = '0' then
            LEVEL <= "000";
        elsif RISING_EDGE(CLK) then
            if ABS_COUNT < L7 then
                LEVEL <= "111";
            elsif ABS_COUNT < L6 then
                LEVEL <=  "110";
            elsif ABS_COUNT < L5 then
                LEVEL <=  "101";
            elsif ABS_COUNT < L4 then
                LEVEL <=  "100";
            elsif ABS_COUNT < L3 then
                LEVEL <=  "011";
            elsif ABS_COUNT < L2 then
                LEVEL <=  "010";
            elsif ABS_COUNT < L1 then
                LEVEL <=  "001";
            else
                LEVEL <= "000";
            end if;
        end if;
    end process;
    
    
    
end architecture_THE_FREQUENCY_TEST;
