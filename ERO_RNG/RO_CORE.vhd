--------------------------------------------------------------------------------

-- Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity RO_CORE is
    GENERIC
    (
        length : INTEGER :=4
    );
    PORT 
    (
        ena : IN  std_logic := '1';
        osc_out : OUT std_logic
    );
end RO_CORE;



architecture architecture_RO_CORE of RO_CORE is

    COMPONENT BFR_WRP IS
        PORT
        (
            i : IN std_logic;
            o : OUT std_logic
        );
    END COMPONENT BFR_WRP;
    
    ATTRIBUTE keep : BOOLEAN;
    SIGNAL del : std_logic_vector ( length-1 downto 0 ) := ('1', others => '0');
    ATTRIBUTE keep OF del : SIGNAL IS TRUE;
    
begin
ASSERT (length >= 2)
  REPORT "RO must contain at least 2 elements. Current length="&integer'image(length)
  SEVERITY ERROR;
  
  
  
-- NAND gate
  del(0) <= NOT ( del(length-1) AND ena );
  
  -- BUFFERS
gen_buff : FOR ii IN 0 TO length-2 GENERATE
  buff_i : BFR_WRP
    PORT MAP 
    (
      i => del(ii),
      o => del(ii+1)
    );
END GENERATE gen_buff;

osc_out <= del(0);

   -- architecture body
end architecture_RO_CORE;
