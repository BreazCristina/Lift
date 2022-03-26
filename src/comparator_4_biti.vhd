library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity COMPARATOR_4_BITI is
	port(N1,N2: in std_logic_vector(3 downto 0); F:out std_logic);
end entity;

architecture ARH_COMP of COMPARATOR_4_BITI is
begin  
	process(N1,N2)
	begin
		if N1>N2 then F<='1';
		else F<='0';	
	  end if;
	end process;
end	architecture;