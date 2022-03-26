library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
library lift;
use lift.all;

entity automat_lift is
	port(SW : in std_logic_vector(3 downto 0); Loc_comanda, Directie, z_obstacol, z_greutate, B_confirmare, CLK, viteza: in std_logic;
	LED: out std_logic; ANOD: out std_logic_vector(3 downto 0); CATOD: out std_logic_vector(6 downto 0));
end automat_lift;

architecture arh_lift of automat_lift is
component UNITATE_DE_CONTROL is
	port(Clock, Loc_comanda, Directie, z_obstacol, z_greutate, B_confirmare: in std_logic;
	Date_out: in std_logic_vector(1 downto 0);
	Sens_cmp, S: in std_logic;
	Etaj_curent, E: in std_logic_vector(3 downto 0);
	T5: in std_logic_vector(2 downto 0);
	LED, z_buton, usa_inchisa, RESET, C_select, D_in, EN_T5, R_T5, C_up, SEL_bis, LD_verif, EN_verif : out std_logic;
	Date_in, SEL: out std_logic_vector(1 downto 0));	
end component;
component UNITATE_DE_EXECUTIE is
port(z_buton,usa_inchisa,RESET,C_select,D_in,EN_T5,R_T5,C_up,SEL_bis,LD_verif,EN_verif,CLK, viteza:in std_logic; Date_in,SEL: in std_logic_vector(1  downto 0); SW:in std_logic_vector(3 downto 0);
	CAT:out std_logic_vector(6 downto 0); Date_out: out std_logic_vector(1 downto 0); Sens_cmp,S:out std_logic; Etaj_curent: out std_logic_vector(3 downto 0); T5:out std_logic_vector(2 downto 0); E0:out std_logic_Vector(3 downto 0);AN: out std_logic_vector(3 downto 0));
end component;
component verif_buton is
	port(BTN, CLK: in std_logic;
	BTN_DB: out std_logic);
end component;
signal B_conf, z_buton_sgn, usa_inchisa_sgn, RESET_sgn, C_select_sgn, D_in_sgn, EN_T5_sgn, R_T5_sgn, C_up_sgn, SEL_bis_sgn, LD_verif_sgn, EN_verif_sgn, Sens_cmp_sgn, S_sgn: std_logic;		 
signal Date_in_sgn, SEL_sgn, Date_out_sgn: std_logic_vector(1 downto 0);
signal Etaj_curent_sgn, E0_sgn: std_logic_vector(3 downto 0);
signal T5_sgn: std_logic_vector(2 downto 0);
begin																																					  
	b: verif_buton port map (BTN => B_confirmare, CLK => CLK, BTN_DB => B_conf);
	uc: UNITATE_DE_CONTROL port map (Clock => CLK, Loc_comanda => Loc_comanda, Directie => Directie, z_obstacol => z_obstacol, z_greutate => z_greutate, B_confirmare => B_conf,  Date_out => Date_out_sgn, Sens_cmp => Sens_cmp_sgn, S => S_sgn, Etaj_curent => Etaj_curent_sgn, E => E0_sgn, T5 => T5_sgn, LED => LED, z_buton => z_buton_sgn, usa_inchisa => usa_inchisa_sgn, RESET => RESET_sgn, C_select => C_select_sgn, D_in => D_in_sgn, EN_T5 => EN_T5_sgn, R_T5 => R_T5_sgn, C_up => C_up_sgn, SEL_bis => SEL_bis_sgn, LD_verif => LD_verif_sgn, EN_verif => En_verif_sgn, Date_in => Date_in_sgn, SEL => SEL_sgn); 
	ue: UNITATE_DE_EXECUTIE port map (z_buton => z_buton_sgn, usa_inchisa => usa_inchisa_sgn, RESET => RESET_sgn, C_select => C_select_sgn, D_in => D_in_sgn, EN_T5 => EN_T5_sgn, R_T5 => R_T5_sgn, C_up => C_up_sgn, SEL_bis => SEL_bis_sgn, LD_verif => LD_verif_sgn, CLK => CLK, viteza => viteza,  EN_verif => En_verif_sgn, Date_in => Date_in_sgn, SEL => SEl_sgn, SW => SW , CAT => CATOD, Date_out => Date_out_sgn, Sens_cmp => Sens_cmp_sgn, S => S_sgn, Etaj_curent => Etaj_curent_sgn,  T5 => T5_sgn, E0 => E0_sgn, AN => ANOD);
end architecture;