----------------------------------------------------------------------
-- Created by SmartDesign Wed May 19 14:07:49 2021
-- Version: v12.6 12.900.20.24
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
----------------------------------------------------------------------
-- THE_TEST_MODULE entity declaration
----------------------------------------------------------------------
entity THE_TEST_MODULE is
    -- Port list
    port(
        -- Inputs
        BIT_IN   : in  std_logic;
        CLK      : in  std_logic;
        SYSRESET : in  std_logic;
        -- Outputs
        ALARM    : out std_logic;
        LEVEL    : out std_logic_vector(2 downto 0);
        LEVEL_0  : out std_logic_vector(2 downto 0);
        LEVEL_1  : out std_logic_vector(2 downto 0);
        LEVEL_2  : out std_logic_vector(2 downto 0);
        READY    : out std_logic
        );
end THE_TEST_MODULE;
----------------------------------------------------------------------
-- THE_TEST_MODULE architecture body
----------------------------------------------------------------------
architecture RTL of THE_TEST_MODULE is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- GLOBAL_COUNTER_14BIT
component GLOBAL_COUNTER_14BIT
    -- Port list
    port(
        -- Inputs
        CLK      : in  std_logic;
        SYSRESET : in  std_logic;
        -- Outputs
        PAIRITY  : out std_logic;
        READY    : out std_logic;
        RESET    : out std_logic
        );
end component;
-- THE_COLLISION_TEST
component THE_COLLISION_TEST
    -- Port list
    port(
        -- Inputs
        BIT_IN : in  std_logic;
        CLK    : in  std_logic;
        RESET  : in  std_logic;
        -- Outputs
        LEVEL  : out std_logic_vector(2 downto 0)
        );
end component;
-- THE_FREQUENCY_TEST
component THE_FREQUENCY_TEST
    -- Port list
    port(
        -- Inputs
        BIT_IN : in  std_logic;
        CLK    : in  std_logic;
        RESET  : in  std_logic;
        -- Outputs
        LEVEL  : out std_logic_vector(2 downto 0)
        );
end component;
-- THE_MARKOV_TEST
component THE_MARKOV_TEST
    -- Port list
    port(
        -- Inputs
        BIT_IN : in  std_logic;
        CLK    : in  std_logic;
        RESET  : in  std_logic;
        -- Outputs
        LEVEL  : out std_logic_vector(2 downto 0)
        );
end component;
-- THE_PARTIAL_COLLECTION_TEST
component THE_PARTIAL_COLLECTION_TEST
    -- Port list
    port(
        -- Inputs
        BIT_IN  : in  std_logic;
        CLK     : in  std_logic;
        PAIRITY : in  std_logic;
        RESET   : in  std_logic;
        -- Outputs
        LEVEL   : out std_logic_vector(2 downto 0)
        );
end component;
-- THE_REPETITION_COUNT
component THE_REPETITION_COUNT
    -- Port list
    port(
        -- Inputs
        BIT_IN : in  std_logic;
        CLK    : in  std_logic;
        RESET  : in  std_logic;
        -- Outputs
        ALARM  : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal ALARM_net_0                    : std_logic;
signal GLOBAL_COUNTER_14BIT_0_PAIRITY : std_logic;
signal GLOBAL_COUNTER_14BIT_0_RESET   : std_logic;
signal LEVEL_net_0                    : std_logic_vector(2 downto 0);
signal LEVEL_0_net_0                  : std_logic_vector(2 downto 0);
signal LEVEL_1_net_0                  : std_logic_vector(2 downto 0);
signal LEVEL_2_net_0                  : std_logic_vector(2 downto 0);
signal READY_net_0                    : std_logic;
signal LEVEL_net_1                    : std_logic_vector(2 downto 0);
signal READY_net_1                    : std_logic;
signal LEVEL_0_net_1                  : std_logic_vector(2 downto 0);
signal LEVEL_1_net_1                  : std_logic_vector(2 downto 0);
signal LEVEL_2_net_1                  : std_logic_vector(2 downto 0);
signal ALARM_net_1                    : std_logic;

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 LEVEL_net_1         <= LEVEL_net_0;
 LEVEL(2 downto 0)   <= LEVEL_net_1;
 READY_net_1         <= READY_net_0;
 READY               <= READY_net_1;
 LEVEL_0_net_1       <= LEVEL_0_net_0;
 LEVEL_0(2 downto 0) <= LEVEL_0_net_1;
 LEVEL_1_net_1       <= LEVEL_1_net_0;
 LEVEL_1(2 downto 0) <= LEVEL_1_net_1;
 LEVEL_2_net_1       <= LEVEL_2_net_0;
 LEVEL_2(2 downto 0) <= LEVEL_2_net_1;
 ALARM_net_1         <= ALARM_net_0;
 ALARM               <= ALARM_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- GLOBAL_COUNTER_14BIT_0
GLOBAL_COUNTER_14BIT_0 : GLOBAL_COUNTER_14BIT
    port map( 
        -- Inputs
        CLK      => CLK,
        SYSRESET => SYSRESET,
        -- Outputs
        PAIRITY  => GLOBAL_COUNTER_14BIT_0_PAIRITY,
        READY    => READY_net_0,
        RESET    => GLOBAL_COUNTER_14BIT_0_RESET 
        );
-- THE_COLLISION_TEST_0
THE_COLLISION_TEST_0 : THE_COLLISION_TEST
    port map( 
        -- Inputs
        CLK    => CLK,
        RESET  => GLOBAL_COUNTER_14BIT_0_RESET,
        BIT_IN => BIT_IN,
        -- Outputs
        LEVEL  => LEVEL_net_0 
        );
-- THE_FREQUENCY_TEST_0
THE_FREQUENCY_TEST_0 : THE_FREQUENCY_TEST
    port map( 
        -- Inputs
        CLK    => CLK,
        RESET  => GLOBAL_COUNTER_14BIT_0_RESET,
        BIT_IN => BIT_IN,
        -- Outputs
        LEVEL  => LEVEL_2_net_0 
        );
-- THE_MARKOV_TEST_0
THE_MARKOV_TEST_0 : THE_MARKOV_TEST
    port map( 
        -- Inputs
        CLK    => CLK,
        RESET  => GLOBAL_COUNTER_14BIT_0_RESET,
        BIT_IN => BIT_IN,
        -- Outputs
        LEVEL  => LEVEL_1_net_0 
        );
-- THE_PARTIAL_COLLECTION_TEST_0
THE_PARTIAL_COLLECTION_TEST_0 : THE_PARTIAL_COLLECTION_TEST
    port map( 
        -- Inputs
        CLK     => CLK,
        RESET   => GLOBAL_COUNTER_14BIT_0_RESET,
        PAIRITY => GLOBAL_COUNTER_14BIT_0_PAIRITY,
        BIT_IN  => BIT_IN,
        -- Outputs
        LEVEL   => LEVEL_0_net_0 
        );
-- THE_REPETITION_COUNT_0
THE_REPETITION_COUNT_0 : THE_REPETITION_COUNT
    port map( 
        -- Inputs
        BIT_IN => BIT_IN,
        CLK    => CLK,
        RESET  => GLOBAL_COUNTER_14BIT_0_RESET,
        -- Outputs
        ALARM  => ALARM_net_0 
        );

end RTL;
