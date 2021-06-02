--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: THE_REPETITION_COUNT.vhd
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

entity THE_REPETITION_COUNT is
port (
    BIT_IN : IN std_logic;
    CLK : IN std_logic;
    RESET : IN std_logic;
    ALARM : out std_logic
);
end THE_REPETITION_COUNT;
architecture architecture_THE_REPETITION_COUNT of THE_REPETITION_COUNT is
   
	signal COUNT : std_logic_vector(7 downto 0);
    signal BIT_STATE : std_logic;
    
    constant CVAL : std_logic_vector := "11001001"; --Cut-Off Value 201

begin
    
    process(CLK,RESET) --COUNTER
    begin
        if RESET = '0' then
            COUNT <= (0 => '1', others => '0');
            BIT_STATE <= '0';
        elsif RISING_EDGE(CLK) then
            if (BIT_IN = BIT_STATE) then
                COUNT <= COUNT + 1;
            else
                COUNT <= (0 => '1', others => '0');
                BIT_STATE <= not BIT_STATE;
            end if;
        end if;
    end process;
    
    process(CLK) --ALARM
    begin
        if RISING_EDGE(CLK) then
            if COUNT >= CVAL then
                ALARM <= '1';
            else
                ALARM <= '0';
            end if;
        end if;
    end process;
    
   -- architecture body
end architecture_THE_REPETITION_COUNT;
