library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;

entity THE_MARKOV_TEST is
port (
    CLK : IN std_logic;
    RESET : IN std_logic;
    BIT_IN : IN std_logic;
    LEVEL : OUT std_logic_vector(2 downto 0)
);
end THE_MARKOV_TEST;
architecture architecture_THE_MARKOV_TEST of THE_MARKOV_TEST is

    signal C_01 : std_logic_vector(12 downto 0);
    signal C_abs : std_logic_vector(13 downto 0);
    signal BIT_1 : std_logic;
    signal BIT_2 : std_logic;
    
        
    --Fixed point arithmetric 14.4 (integer).(decimal)
    
    --M_vals = [-3685.60317460318	-3899.60921843687	-3971.39934533552	-4015.54234769688	-4030.70270270270	-4043.09369369369	-4074.59514170041	67354.4117647059	25094.0560000000	18748	23531.6959064328	30992.3981481482	47099.1346153846	100679.076923077]
    --Multply by 16 and roud to zero decimals
    --M_vals_shift4 = [-58970	-62394	-63542	-64249	-64491	-64689	-65194	1077671	401505	299968	376507	495878	753586	1610865]
    
    constant M1 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(-58970, 22));
    constant M2 : std_logic_vector(21  downto 0) := std_logic_vector(to_signed(-62394, 22));
    constant M3 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(-63542, 22));
    constant M4 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(-64249, 22));
    constant M5 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(-64491, 22));
    constant M6 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(-64689, 22));
    constant M7 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(-65194, 22));
    constant M8 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(1077671, 22));
    constant M9 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(401505, 22));
    constant M10 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(299968, 22));
    constant M11 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(376507, 22));
    constant M12 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(495878, 22));
    constant M13 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(753586, 22));
    constant M14 : std_logic_vector(21 downto 0) := std_logic_vector(to_signed(1610865, 22));
    
    signal M1X : std_logic_vector(21 downto 0);
    signal M2X : std_logic_vector(21 downto 0);
    signal M3X : std_logic_vector(21 downto 0);
    signal M4X : std_logic_vector(21 downto 0);
    signal M5X : std_logic_vector(21 downto 0);
    signal M6X : std_logic_vector(21 downto 0);
    signal M7X : std_logic_vector(21 downto 0);
    signal M8X : std_logic_vector(21 downto 0);
    signal M9X : std_logic_vector(21 downto 0);
    signal M10X : std_logic_vector(21 downto 0);
    signal M11X : std_logic_vector(21 downto 0);
    signal M12X : std_logic_vector(21 downto 0);
    signal M13X : std_logic_vector(21 downto 0);
    signal M14X : std_logic_vector(21 downto 0);
    
    --K_vals = [10.9365079365079	5.88176352705411	4.13256955810147	3.25408618127786	2.71977240398293	2.36576576576577	2.12550607287449	-30.8823529411765	-10.5040000000000	-7.16666666666667	-8.21637426900585	-9.87962962962963	-13.7115384615385	-26.7692307692308]
    --Multply by 16 and roud to zero decimals
    --K_vals_shift4 = [175	94	66	52	44	38	34	-494	-168	-115	-131	-158	-219	-428]
    
    constant K1 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(175, 13));
    constant K2 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(94, 13));
    constant K3 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(66, 13));
    constant K4 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(52, 13));
    constant K5 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(44, 13));
    constant K6 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(38, 13));
    constant K7 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(34, 13));
    constant K8 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(-494, 13));
    constant K9 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(-168, 13));
    constant K10 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(-115, 13));
    constant K11 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(-131, 13));
    constant K12 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(-158, 13));
    constant K13 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(-219, 13));
    constant K14 : std_logic_vector(12 downto 0) := std_logic_vector(to_signed(-428, 13));
    
    signal K1X : std_logic_vector(25 downto 0);
    signal K2X : std_logic_vector(25 downto 0);
    signal K3X : std_logic_vector(25 downto 0);
    signal K4X : std_logic_vector(25 downto 0);
    signal K5X : std_logic_vector(25 downto 0);
    signal K6X : std_logic_vector(25 downto 0);
    signal K7X : std_logic_vector(25 downto 0);
    signal K8X : std_logic_vector(25 downto 0);
    signal K9X : std_logic_vector(25 downto 0);
    signal K10X : std_logic_vector(25 downto 0);
    signal K11X : std_logic_vector(25 downto 0);
    signal K12X : std_logic_vector(25 downto 0);
    signal K13X : std_logic_vector(25 downto 0);
    signal K14X : std_logic_vector(25 downto 0);
    
    signal C_01_S : std_logic_vector(12 downto 0);
    signal C_abs_S : std_logic_vector(17 downto 0);


begin

    process(CLK) -- Registers for bit 1 and 2
    begin 
        if RISING_EDGE(CLK) then
            BIT_2 <= BIT_1;
            BIT_1 <= BIT_IN;
        end if;
    end process;
    
    process(CLK, RESET) -- Counter 01
    begin
        if(RESET = '0') then
            C_01 <= (others => '0');
        elsif RISING_EDGE(CLK) then
            if(BIT_2 = '0' and BIT_1 = '1') then
            C_01 <= C_01 + 1;
            end if;
        end if;
    end process;
    
    process(CLK,RESET) --Up down counter (absolute value)
    begin 
        if (RESET = '0') then
            C_abs <= (others => '0');
        elsif RISING_EDGE(CLK) then
            if(BIT_IN = '1') then
                C_abs <= C_abs + 1;
            else
                C_abs <= C_abs - 1;
            end if;
        end if;
    end process;
    
    process(C_01, C_abs, C_01_S, C_abs_S, 
                K1X, K2X, K3X, K4X, K5X, K6X, K7X, K8X, K9X, K10X, K11X, K12X, K13X, K14X,
                M1X, M2X, M3X, M4X, M5X, M6X, M7X, M8X, M9X, M10X, M11X, M12X, M13X, M14X)
    begin
    
    C_abs_S(17 downto 0) <= (others => '0'); --Fill with zeros
    C_abs_S(17 downto 4) <= C_abs;  -- shift left 4 steps for fixed point
    
    C_01_S(12 downto 0) <= C_01; -- no shift
    
    K1X <= C_01_S * K1; --No need to shift back, comparing the shifted values instead.
    K2X <= C_01_S * K2;
    K3X <= C_01_S * K3;
    K4X <= C_01_S * K4;
    K5X <= C_01_S * K5;
    K6X <= C_01_S * K6;
    K7X <= C_01_S * K7;
    K8X <= C_01_S * K8;
    K9X <= C_01_S * K9;
    K10X <= C_01_S * K10;
    K11X <= C_01_S * K11;
    K12X <= C_01_S * K12;
    K13X <= C_01_S * K13;
    K14X <= C_01_S * K14;
    
    M1X <= C_abs_S - M1;
    M2X <= C_abs_S - M2;
    M3X <= C_abs_S - M3;
    M4X <= C_abs_S - M4;
    M5X <= C_abs_S - M5;
    M6X <= C_abs_S - M6;
    M7X <= C_abs_S - M7;
    M8X <= C_abs_S - M8;
    M9X <= C_abs_S - M9;
    M10X <= C_abs_S - M10;
    M11X <= C_abs_S - M11;
    M12X <= C_abs_S - M12;
    M13X <= C_abs_S - M13;
    M14X <= C_abs_S - M14;
    end process;
    
    process (CLK, RESET)
    begin
        if (RESET = '0') then
            LEVEL <= "000";
        elsif (CLK = '1' and CLK'event) then
        
            if M1X > K1X then --Check from the left
                LEVEL <= "000";
            elsif M2X > K2X then
                LEVEL <= "001";
            elsif M3X > K3X then
                LEVEL <= "010";
            elsif M4X > K4X then
                LEVEL <= "011";
            elsif M5X > K5X then
                LEVEL <= "100";
            elsif M6X > K6X then
                LEVEL <= "101";
            
            elsif M14X > K14X then --Check from the right
                LEVEL <= "000";
            elsif M13X > K13X then
                LEVEL <= "001";
            elsif M12X > K12X then
                LEVEL <= "010";
            elsif M11X > K11X then
                LEVEL <= "011";
            elsif M10X > K10X then
                LEVEL <= "100";
            elsif M9X > K9X then
                LEVEL <= "101";
            elsif M8X > K8X then
                LEVEL <= "110";
            elsif M7X > K7X then
                LEVEL <= "110";
            else
                LEVEL <= "111"; --No match => highest enropy
            end if;
            
        end if;
    end process;
    

   -- architecture body
end architecture_THE_MARKOV_TEST;
