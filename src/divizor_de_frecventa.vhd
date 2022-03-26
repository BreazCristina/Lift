library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity divizor_frecventa is
	port(Clock: in std_logic;
	Q: out std_logic);
end divizor_frecventa;

architecture arh_divizor_frecventa of divizor_frecventa is
signal T: std_logic := '0' ;
begin
	process(Clock)
	variable count: std_logic_vector(26 downto 0) := (others => '0');
	begin
		if (Clock'event and clock = '1') then count := count + '1';	   
		end if;	
		if count = "101111101011110000100000000" then 
			T <= '1';
			count := (others => '0');
		else 
			T <= '0';
		end if;
	end process;
	Q <= T;
end arh_divizor_frecventa;