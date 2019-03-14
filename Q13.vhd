library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw6_FSM is
    Port ( X1, X2 : in STD_LOGIC;
           CLK : in STD_LOGIC;
           CS, RD : out STD_LOGIC;
           Y : out STD_LOGIC_VECTOR(2 downto 0));
end hw6_FSM;

architecture Behavioral of hw6_FSM is

type state_type is (ST001,ST010,ST100);
signal PS,NS : state_type;

begin

sync_proc: process(NS,CLK)
begin
if rising_edge(CLK) then    
    PS <= NS;
end if;
end process;

combin_proc: process(PS,X1,X2)
begin
case PS is

    when ST001 => 
         
        if X1 = '0' then CS <= '0'; RD <= '1'; NS <= ST010;
        elsif X1 = '1' then CS <= '1'; RD <= '0'; NS <= ST100;
        end if;

    when ST010 => 
         
        -- DOES NOT DEPEND ON ANY INPUT, WILL CHANGE STATE IN NEXT RISING EDGE OF CLK
        CS <= '1'; RD <= '1';
        NS <= ST100;

    when ST100 => 
         
        if X2 = '1' then CS <= '0'; RD <= '1'; NS <= ST100;
        elsif X2 = '0' then CS <= '0'; RD <= '0'; NS <= ST001;
        end if;

    when others =>      --DEFINING DEFAULT CASE AS IT IS NOT MENTIONED IN THE QUESTION
        CS <= '0'; RD <= '0';
        NS <= ST001;
        
end case;
end process;

with PS select
    Y <= "001" when ST001,
         "010" when ST010,
         "100" when ST100,
         "001" when others;  --DEFINING DEFAULT CASE AS IT IS NOT MENTIONED IN THE QUESTION
end Behavioral;
