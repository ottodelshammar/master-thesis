--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: THE_PARTIAL_COLLECTION_TEST.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFire> <Die::MPF300T> <Package::FCG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity THE_PARTIAL_COLLECTION_TEST is
port (
    CLK : IN  std_logic;
    RESET : IN  std_logic;
    PAIRITY : IN std_logic; --Pairity bit provided by global counter
    BIT_IN : IN std_logic;
    LEVEL : OUT std_logic_vector(2 downto 0)
);
end THE_PARTIAL_COLLECTION_TEST;
architecture architecture_THE_PARTIAL_COLLECTION_TEST of THE_PARTIAL_COLLECTION_TEST is
   
    signal COUNT : std_logic_vector(12 downto 0);
    signal BIT_1 : std_logic;
    signal BIT_2 : std_logic;
    
    --Cut-off values
    constant L1 : std_logic_vector(11 downto 0) := "001010000111"; --647
    constant L2 : std_logic_vector(11 downto 0) := "010001101010"; --1130
    constant L3 : std_logic_vector(11 downto 0) := "010111001011"; --1483
    constant L4 : std_logic_vector(11 downto 0) := "010111001011"; --1731
    constant L5 : std_logic_vector(11 downto 0) := "011101101000"; --1896
    constant L6 : std_logic_vector(11 downto 0) := "011111001011"; --1995
    constant L7 : std_logic_vector(11 downto 0) := "011111111010"; --2042

begin

    process(CLK) -- Registers for bit 1 and 2
    begin
        if (RISING_EDGE(CLK)) then
            BIT_2 <= BIT_1;
            BIT_1 <= BIT_IN;
        end if;
    end process;
    
    process(CLK, RESET) --Counter
    begin
        if(RESET = '0') then
            COUNT <= (others => '0');
        elsif (RISING_EDGE(CLK)) then
            if PAIRITY = '0' and (BIT_2 /= BIT_1) then -- Compare bit 1 and 2 every other cycle
            COUNT <= COUNT + 1;
            end if;
        end if;
    end process;
    
    process(CLK) --Comparator
    begin
        if (RISING_EDGE(CLk)) then
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
    
   -- architecture body
end architecture_THE_PARTIAL_COLLECTION_TEST;
