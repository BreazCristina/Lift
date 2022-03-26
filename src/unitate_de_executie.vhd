library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
library lift;
use lift.all;

entity UNITATE_DE_EXECUTIE is
	port(z_buton,usa_inchisa,RESET,C_select,D_in,EN_T5,R_T5,C_up,SEL_bis,LD_verif,EN_verif,CLK, viteza:in std_logic; Date_in,SEL: in std_logic_vector(1  downto 0); SW:in std_logic_vector(3 downto 0);
	CAT:out std_logic_vector(6 downto 0); Date_out: out std_logic_vector(1 downto 0); Sens_cmp,S:out std_logic; Etaj_curent: out std_logic_vector(3 downto 0); T5:out std_logic_vector(2 downto 0); E0:out std_logic_Vector(3 downto 0);AN: out std_logic_vector(3 downto 0));
end entity;

architecture ARH_STRUCTURALA of UNITATE_DE_EXECUTIE is 
component MUX_4_1 
		port(I0,I1,I2,I3:in STD_LOGIC_VECTOR(3 downto 0);S:in STD_LOGIC_VECTOR(1 downto 0);
	    Y:out STD_LOGIC_VECTOR(3 downto 0)); 
end component; 

component MEMORIE_RAM
	port(A_RAM:in std_logic_vector(3 downto 0); I_RAM: in std_logic_vector(1 downto 0); CS, WE,CLOCK:in std_logic;
	D_RAM: out std_logic_vector(1 downto 0));
end component; 

component NUMARATOR_ETAJE
	port(R,MODE,CLK,EN: in std_logic; Q: out std_logic_vector(3 downto 0));
end component; 

component NUMARATOR_5_SEC
	port(R,EN,CLK:in std_logic; 
	Q:out std_logic_vector(2 downto 0)); 
end component;

component COMPARATOR_4_BITI
	port(N1,N2: in std_logic_vector(3 downto 0); F:out std_logic);
end component;

component NUMARATOR_MEMORIE
	port(LD,CLOCK,MODE,EN:in std_logic; D:in std_logic_vector(3 downto 0); Q:out std_logic_Vector(3 downto 0));
end component;

component afisor 
	port(digit: in std_logic_vector(3 downto 0);
	Clock: in std_logic;	
	anod: out std_logic_vector(3 downto 0);
	catod: out std_logic_vector(6 downto 0));
end component;

component divizor_frecventa
	port(Clock: in std_logic;
	Q: out std_logic);
end component;

component BISTABIL_D
	 port(D, Clock, Reset: in std_logic;  
	Qn:out std_logic);
end component;

component MUX_2_1 
	port(I0: in std_logic; I1:in std_logic; S:in std_logic;
	Y: out std_logic);
end component;	 

component divizor_frecv_3_sec is
	port( CLK_1_sec:in std_logic; CLK_3_sec:out std_logic);
end component;

component Buff is
	port(S: in std_logic;
	A, B: in std_logic;
	Y: out std_logic);
end component;

signal Adresa_etaj:std_logic_vector(3 downto 0) ; 
signal CLK_div_1_sec, CLK_div_3_sec, CLK_final:std_logic;
signal E_sgn:std_logic_vector(3 downto 0);	
signal Etaj_curent_sgn:std_logic_vector(3 downto 0);  
signal I3_sgn:std_logic_vector(3 downto 0):="0000";	  
signal S_sgn: std_logic;  
signal Sens_cmp_sgn :std_logic;
signal Y_sgn:std_logic;
begin
	C1:MUX_4_1 port map(I0=>E_sgn,I1=>SW,I2=>Etaj_curent_sgn,I3=>I3_sgn,S=>SEL,Y=>Adresa_etaj);
	Etaj_curent<=Etaj_curent_sgn;
	E0<=E_sgn;
	C2: MEMORIE_RAM port map(A_RAM=>Adresa_etaj,I_RAM=>Date_in,CS=>C_select,WE=>z_buton,CLOCK=>CLK,D_RAM=>Date_out); 	
	C3:NUMARATOR_ETAJE port map(R=>RESET,MODE=>S_sgn,CLK=>CLK_final,EN=>usa_inchisa,Q=>Etaj_curent_sgn);
	S<=S_sgn;
	C4:NUMARATOR_5_SEC port map(R=>R_T5,EN=>EN_T5,CLK=>CLK_div_1_sec,Q=>T5);
	C5:COMPARATOR_4_BITI port map(N1=>SW,N2=>Etaj_curent_sgn,F=>Sens_cmp_sgn);
	Sens_cmp<=Sens_cmp_sgn;
	C6:NUMARATOR_MEMORIE port map(LD=>LD_verif,CLOCK=>CLK,MODE=>C_up,EN=>EN_verif,D=>Etaj_curent_sgn,Q=>E_sgn);
	C7:afisor port map(digit=>Etaj_curent_sgn,Clock=>CLK,anod=>AN,catod=>CAT); 
	C8:divizor_frecventa port map(Clock=>CLK,Q=>CLK_div_1_sec);
	C9:BISTABIL_D port map(D=>Y_sgn,Clock=>CLK,Reset=>RESET,Qn=>S_sgn);
	C10:MUX_2_1 port map(I0=>S_sgn,I1=>D_in,S=>SEL_bis,Y=>Y_sgn); 
	c11: divizor_frecv_3_sec port map (CLK_1_sec => CLK_div_1_sec, CLK_3_sec =>  CLK_div_3_sec);
	c12: Buff port map (S => viteza, A => CLK_div_3_sec, B => CLK_div_1_sec, Y => CLK_final);
end architecture;