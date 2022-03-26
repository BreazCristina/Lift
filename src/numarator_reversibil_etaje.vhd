library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity NUMARATOR_ETAJE is
	port(R,MODE,CLK,EN: in std_logic; Q: out std_logic_vector(3 downto 0));	 
end entity;

architecture ARH_COMP of NUMARATOR_ETAJE is
begin		
	
	process(CLK,EN,MODE,R)	 
	variable n: std_logic_vector(3 downto 0):="0000";
	
	begin
		if EN='1' then
		   if R='0' then
			   if rising_edge(CLK) then
				   if MODE='1' then n:=n+'1';
				   elsif MODE='0' then n:=n-'1';
				   end if;
				   if n="1101" then n:="1100";
				   end if;
				   if n="1111" then n:="0000";
				   end if;
		       end if;
			elsif R='1' then
			  n:="0000";
		  end if; 
		else
			n:=n;
		end if;
		Q<=n;
		
	end process;
end architecture;