
library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity GLOBAL_COUNTER_14BIT is
port (
	CLK : IN  std_logic;
    SYSRESET : IN std_logic;
    PAIRITY : OUT std_logic;
    READY : OUT std_logic;
    RESET : OUT std_logic
    
);
end GLOBAL_COUNTER_14BIT;
architecture architecture_GLOBAL_COUNTER_14BIT of GLOBAL_COUNTER_14BIT is
signal count: std_logic_vector(13 downto 0);

begin

    process(CLK, SYSRESET)
    begin
        if SYSRESET = '0' then
            count <= (others => '0');
            RESET <= '0';
            READY <= '0';
            PAIRITY <= '0';
        elsif rising_edge(CLK) then
            PAIRITY <= not PAIRITY;
            if (count = "10000000000000") then
                count <= (others => '0');
                READY <= '1';
                RESET <= '0';
                PAIRITY <= '0';
            else
                count <= std_logic_vector(unsigned(count) + 1);
                READY <= '0';
                RESET <= '1';
            end if;
        end if;
    end process;

end architecture_GLOBAL_COUNTER_14BIT;
