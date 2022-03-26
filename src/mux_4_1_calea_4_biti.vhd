library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity MUX_4_1 is
	port(I0,I1,I2,I3:in STD_LOGIC_VECTOR(3 downto 0);
	S:in STD_LOGIC_VECTOR(1 downto 0);
	Y:out STD_LOGIC_VECTOR(3 downto 0));
end entity;

architecture ARH_COMP of MUX_4_1 is
begin
	process(S)
	begin
		case S is
			when "00" => Y<=I0;
			when "01" => Y<=I1;
			when "10" => Y<=I2;
	       	when others => Y<="0000";			
		end case;
	end process;
end architecture;
	    