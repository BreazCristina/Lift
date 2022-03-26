library IEEE;
use IEEE.std_logic_1164.all;

entity Buff is
	port(S: in std_logic;
	A, B: in std_logic;
	Y: out std_logic);
end Buff;

architecture arh_buff of BUFF is
signal SA, SB: std_logic;
begin
	SA <= A when S ='1' else 'Z';
	SB <= B when S ='0' else 'Z';
	P1: process(SA)
	begin
		Y <= SA;
	end process P1;
	P2: process(SB)	
	begin
		Y <= SB;
	end process P2;
end arh_Buff;