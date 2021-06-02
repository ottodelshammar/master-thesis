--------------------------------------------------------------------------------
-- Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ELEMENTARY_RNG is
  PORT (
    bit_out          : OUT STD_LOGIC;                   -- Rng out bit
    n_reset          : IN  STD_LOGIC                    -- Reset signal
  );
end ELEMENTARY_RNG;
 
architecture architecture_ELEMENTARY_RNG of ELEMENTARY_RNG is
    ATTRIBUTE keep : BOOLEAN;
     
    COMPONENT RO_CORE IS
        GENERIC (
            length : INTEGER := 4
        );
        PORT (
            ena : IN STD_LOGIC; 
            osc_out : OUT STD_LOGIC 
        );
    END COMPONENT RO_CORE;
    
    SIGNAL ro1_out_s    : STD_LOGIC;
    SIGNAL ro2_out_s    : STD_LOGIC;
    SIGNAL sampling_clk : STD_LOGIC;
    SIGNAL cnt          : STD_LOGIC_VECTOR ( 23 DOWNTO 0 ) := ( OTHERS => '0' );
    SIGNAL rng_out      : STD_LOGIC;
    CONSTANT K_VAl      : NATURAL := 40000;
    CONSTANT RO1_SIZE   : NATURAL := 5;
    CONSTANT RO2_SIZE   : NATURAL := 5;

begin



-- Sampled RO
-----------------------------------------------------
ro1_inst : RO_CORE
  GENERIC MAP (
    length  => RO1_SIZE
  )
  PORT MAP( 
    ena     => n_reset,     -- Enables oscillator output
    osc_out => ro1_out_s    -- Oscillator output
  );

-- Sampling RO
-----------------------------------------------------
ro2_inst : RO_CORE
  GENERIC MAP (
    length  => RO2_SIZE
  )
  PORT MAP( 
    ena     => n_reset,     -- Enables oscillator output
    osc_out => ro2_out_s    -- Oscillator output
  );

--------------------------------------------------------
--Sampling period generation
--------------------------------------------------------
    PROCESS( ro2_out_s, n_reset )
    BEGIN
        IF n_reset = '0' THEN
            sampling_clk <= '0'; 
            cnt <= (OTHERS => '0');
        ELSIF rising_edge( ro2_out_s ) THEN
            IF ( UNSIGNED (cnt) = K_VAl) THEN
                cnt <= (OTHERS => '0');
                sampling_clk <= '1';
            ELSE
                cnt <= STD_LOGIC_VECTOR( UNSIGNED( cnt ) + 1);
                sampling_clk <= '0';
            END IF;
        ELSE
            cnt <= cnt;
        END IF;
    END PROCESS;
    
    
-- Sampling flip-flop
-----------------------------------------------------
  PROCESS ( sampling_clk, n_reset )
  BEGIN
    IF n_reset = '0' THEN
        rng_out <= '0';
    ELSIF rising_edge(sampling_clk) THEN
        rng_out <= ro1_out_s;
    ELSE
        rng_out <= rng_out;
    END IF;
  END PROCESS;
  
  bit_out <= rng_out;

end architecture_ELEMENTARY_RNG;
