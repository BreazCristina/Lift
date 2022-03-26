library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity MEMORIE_RAM is
	port(A_RAM:in std_logic_vector(3 downto 0); I_RAM: in std_logic_vector(1 downto 0); CS, WE,CLOCK:in std_logic;
	D_RAM: out std_logic_vector(1 downto 0));
end entity; 

architecture ARH_COMP of MEMORIE_RAM is
type MEMORIE is array(0 to 15)  of std_logic_vector(1 downto 0); 
signal M:MEMORIE := (others => "00");

begin 
	process(CLOCK,CS,WE,A_RAM)	 
	begin 
	if CLOCK'event and CLOCK = '1' then
		if CS='1' then			    
			if WE='1' then
				case A_RAM is
					when "0000" => M(0)<=I_RAM;
					when "0001" => M(1)<=I_RAM;
					when "0010" => M(2)<=I_RAM;
					when "0011" => M(3)<=I_RAM;
					when "0100" => M(4)<=I_RAM;
					when "0101" => M(5)<=I_RAM;
					when "0110" => M(6)<=I_RAM;
					when "0111" => M(7)<=I_RAM;
					when "1000" => M(8)<=I_RAM;
					when "1001" => M(9)<=I_RAM;
					when "1010" => M(10)<=I_RAM;
					when "1011" => M(11)<=I_RAM;
					when "1100" => M(12)<=I_RAM;
					when "1101" => M(13)<=I_RAM;
					when "1110" => M(14)<=I_RAM;
					when "1111" => M(15)<=I_RAM;
					when others => NULL;
			
			   end case;
			elsif WE='0' then
				case A_RAM is
					when "0000" => D_RAM<=M(0);
					when "0001" => D_RAM<=M(1);
					when "0010" => D_RAM<=M(2);
					when "0011" => D_RAM<=M(3);
					when "0100" => D_RAM<=M(4);
					when "0101" => D_RAM<=M(5);
					when "0110" => D_RAM<=M(6);
					when "0111" => D_RAM<=M(7);
					when "1000" => D_RAM<=M(8);
					when "1001" => D_RAM<=M(9);
					when "1010" => D_RAM<=M(10);
					when "1011" => D_RAM<=M(11);
					when "1100" => D_RAM<=M(12);
					when "1101" => D_RAM<=M(13);
					when "1110" => D_RAM<=M(14);
					when "1111" => D_RAM<=M(15);
					when others => NULL;
				end case;
			end if;		
		else D_RAM<="ZZ";
		end if;
	end if;
	end process;
end architecture;
