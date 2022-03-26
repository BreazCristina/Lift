library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity NUMARATOR_MEMORIE is
	port(LD,CLOCK,MODE,EN:in std_logic; D:in std_logic_vector(3 downto 0); Q:out std_logic_Vector(3 downto 0));
end entity;

architecture ARH_COMP of NUMARATOR_MEMORIE is
begin
	process(EN,CLOCK,LD,MODE)
	variable n: std_logic_vector(3 downto 0):="0000";
	begin  
		if EN='1' then
			if LD='1' then
				n:=D;
			elsif LD='0' then 
				if rising_edge(CLOCK) then
					if MODE='1' then
						n:=n+1;
				
					elsif MODE='0' then
						n:=n-1;
				   end if;  
				end if;
			 end if;
		else n:=n;	
	    end if;
		Q<=n;
	end process;
end architecture;