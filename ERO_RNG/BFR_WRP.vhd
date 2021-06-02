--------------------------------------------------------------------------------
--
-- Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity BFR_WRP is
port (
	i : IN  std_logic; 
    o : OUT std_logic  
);
end BFR_WRP;


architecture architecture_BFR_WRP of BFR_WRP is
    
    COMPONENT and2 IS
        port
        (
            a : IN  STD_LOGIC := '1';
            b : IN  STD_LOGIC := '1';
            y : OUT STD_LOGIC 
        );
    END COMPONENT and2;

begin
    buff_wrp_i : and2
        PORT MAP
        (
            a => i,
            b => i,
            y => o
        );
end architecture_BFR_WRP;
