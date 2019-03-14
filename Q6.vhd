library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw6_FSM is
    Port ( X : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Z1,Z2 : out STD_LOGIC);
end hw6_FSM;

architecture Behavioral of hw6_FSM is

type state_type is (ST00,ST01,ST10,ST11);
signal PS,NS : state_type;

begin

sync_proc: process(NS,CLK)
begin
if rising_edge(CLK) then    
    PS <= NS;
end if;
end process;

combin_proc: process(PS,X)
begin
case PS is

    when ST00 => 
        Z1 <= '1';          --Preassign o/p 0 
        if X = '0' then Z2 <= '0'; NS <= ST10;
        elsif X = '1' then Z2 <= '0'; NS <= ST00;
        end if;
        
    when ST01 =>
        Z1 <= '0';
        if X = '1' then Z2 <= '0'; NS <= ST01;
        elsif X = '0' then Z2 <= '0'; NS <= ST11;
        end if;
    
    when ST11 =>
        Z1 <= '0';
        if X = '0' then Z2 <= '1'; NS <= ST00;
        elsif X = '1' then Z2 <= '0'; NS <= ST01;
        end if;

    when ST10 =>
        Z1 <= '1';
        if X = '0' then Z2 <= '0'; NS <= ST01;
        elsif X = '1' then Z2 <= '0'; NS <= ST00;
        end if;
    
    when others =>      --DEFINING DEFAULT CASE AS IT IS NOT MENTIONED IN THE QUESTION
        Z1 <= '1';
        NS <= ST00;
        
end case;
end process;

with PS select
    Z1 <= '1' when ST00,
         '0' when ST01,
         '1' when ST10,
         '0' when ST11,
         '0' when others;  --DEFINING DEFAULT CASE AS IT IS NOT MENTIONED IN THE QUESTION
end Behavioral;
