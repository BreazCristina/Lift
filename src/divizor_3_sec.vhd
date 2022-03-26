library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity divizor_frecv_3_sec is
	port( CLK_1_sec:in std_logic; CLK_3_sec:out std_logic);
end entity;

architecture ARH_DIVIZOR of divizor_frecv_3_sec is
signal SGN: std_logic:='0';
begin
	process(CLK_1_sec) 
	variable numaratoare:integer :=0;
	begin 
		if rising_edge(CLK_1_sec) then numaratoare:=numaratoare+1;
	    end if;
		
		if numaratoare=3 then  
			SGN<='1';
	
			numaratoare:=0;	  
		else SGN<='0';
		end if;
	
	end process;
	CLK_3_sec<=SGN;
			
		
end architecture;
