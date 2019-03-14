library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw6_FSM is
    Port ( X1,X2 : in STD_LOGIC;
           CLK,INIT : in STD_LOGIC;
           Z1,Z2 : out STD_LOGIC);
end hw6_FSM;

architecture Behavioral of hw6_FSM is

type state_type is (A,B,C);
signal PS,NS : state_type;

begin

sync_proc: process(NS,CLK,INIT)
begin
if INIT = '1' then PS <= A; 
elsif rising_edge(CLK) then    
    PS <= NS;
end if;
end process;

combin_proc: process(PS,X1,X2)
begin
case PS is

    when A => 
        Z1 <= '0';
        if X1 = '0' then Z2 <= '0'; NS <= C;
        elsif X1 = '1' then Z2 <= '1'; NS <= B;
        end if;
        
    when B =>
        Z1 <= '1';
        if X2 = '1' then Z2 <= '0'; NS <= A;
        elsif X2 = '0' then Z2 <= '1'; NS <= C;
        end if;
    
    when C =>
        Z1 <= '1';
        if X1 = '1' then Z2 <= '1'; NS <= B;
        elsif X1 = '0' then Z2 <= '1'; NS <= A;
        end if;
    
    when others =>      --DEFINING DEFAULT CASE AS IT IS NOT MENTIONED IN THE QUESTION
        Z1 <= '0';
        NS <= A;
        
end case;
end process;

with PS select
    Z1 <= '0' when A,
         '1' when B,
         '1' when C,
         '0' when others;  --DEFINING DEFAULT CASE AS IT IS NOT MENTIONED IN THE QUESTION
end Behavioral;
