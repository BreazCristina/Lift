library	IEEE;
use IEEE.std_logic_1164.all;

entity Bistabil_D_1 is
	port(D, Clock: in std_logic;
	Q: out std_logic);
end Bistabil_D_1;

architecture arh_bistabil_D_1 of Bistabil_D_1 is
begin
	process(Clock)
	begin
		if Clock'event and Clock = '1' then
			Q <= D;
		end if;
	end process;
end architecture;

library	IEEE;
use IEEE.std_logic_1164.all;

entity AND_3 is
	port(X1, X2, X3: in std_logic;
	Y: out std_logic);
end AND_3;

architecture arh_AND_3 of AND_3 is
begin
	Y <= (X1 and X2) and X3;
end architecture ;

library	IEEE;
use IEEE.std_logic_1164.all;

entity verif_Buton is
	port(BTN, CLK: in std_logic;
	BTN_DB: out std_logic);
end verif_buton;

architecture arh_verif_Buton of verif_Buton is
component Bistabil_D_1 is
	port(D, Clock:  in std_logic;
	Q: out std_logic);
end component;	
component AND_3 is
	port(X1, X2, X3: in std_logic;
	Y: out std_logic);
end component;
signal Q1, Q2, Q3: std_logic;
begin
	c1: Bistabil_D_1 port map (D => BTN, Clock => CLK, Q => Q1);
	c2: Bistabil_D_1 port map (D => Q1, Clock => CLK, Q => Q2);
	c3: Bistabil_D_1 port map (D => Q2, Clock => CLK, Q =>Q3);
	c4: AND_3 port map (X1 => Q1, X2 => Q2, X3 => Q3 , Y=> BTN_DB);
end architecture;