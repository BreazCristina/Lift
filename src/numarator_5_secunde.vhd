library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity NUMARATOR_5_SEC is
	port(R,EN,CLK:in std_logic; 
	Q:out std_logic_vector(2 downto 0)); 
end entity;

architecture ARH_COMP of NUMARATOR_5_SEC is
begin
	process(CLK,EN,R)
	variable n:std_logic_vector(2 downto 0);
	begin 
		if EN='0' then 	
			n:= n;
		elsif EN='1' then 
		    if R='1' then n:="101";		
		    elsif CLK'event and CLK = '1' then
				n:=n-'1';	
			end if;
		    if n = "111" then n:="101";
		    end if;
		end if;
		Q<=n;
	end process;
end architecture;