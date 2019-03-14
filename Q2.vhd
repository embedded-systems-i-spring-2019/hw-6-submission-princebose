library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw6_FSM is
    Port ( X1,X2 : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Z : out STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (1 downto 0));
end hw6_FSM;

architecture Behavioral of hw6_FSM is

type state_type is (ST10,ST01,ST11);
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

    when ST10 => 
        Z <= '0';
        if X1 = '0' then NS <= ST10;
        elsif X1 = '1' then NS <= ST01;
        end if;
        
    when ST01 =>
        Z <= '0';
        if X2 = '1' then NS <= ST11;
        elsif X2 = '0' then NS <= ST10;
        end if;
    
    when ST11 =>
        if X2 = '1' then Z <= '0'; NS <= ST11;
        elsif X2 = '0' then Z <= '1'; NS <= ST10;
        end if;
    
    when others =>      --DEFINING DEFAULT CASE AS IT IS NOT MENTIONED IN THE QUESTION
        Z <= '0';
        NS <= ST10;
        
end case;
end process;

with PS select
    Y <= "10" when ST10,
         "01" when ST01,
         "11" when ST11,
         "10" when others;  --DEFINING DEFAULT CASE AS IT IS NOT MENTIONED IN THE QUESTION
end Behavioral;
