library	IEEE;
use IEEE.std_logic_1164.all;

entity Bistabil_D is 
	port(D, Clock, Reset: in std_logic;  
	Qn:out std_logic);
end Bistabil_D;

architecture arh_bistabil_d of Bistabil_D is
begin
	process(Clock, D, Reset)
	begin	   
		if Reset = '1' then Qn <= '1';
		elsif (Clock'event and Clock ='1') then
			Qn <= D;
		end if;
	end process;	
end arh_bistabil_d;

library	IEEE;
use IEEE.std_logic_1164.all;

entity MUX_2_1 is
	port(I0: in std_logic; I1:in std_logic; S:in std_logic;
	Y: out std_logic);
end MUX_2_1;

architecture arh_mux_2_1 of MUX_2_1 is
begin
	process(I0, I1, S)
	begin
		if S='0' then Y <= I0;
		else Y <= I1;
		end if;
	end process;
end arh_mux_2_1;
