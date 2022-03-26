
library	IEEE;
use IEEE.std_logic_1164.all;

entity UNITATE_DE_CONTROL is
	port(Clock, Loc_comanda, Directie, z_obstacol, z_greutate, B_confirmare: in std_logic;
	Date_out: in std_logic_vector(1 downto 0);
	Sens_cmp, S: in std_logic;
	Etaj_curent, E: in std_logic_vector(3 downto 0);
	T5: in std_logic_vector(2 downto 0);
	LED, z_buton, usa_inchisa, RESET, C_select, D_in, EN_T5, R_T5, C_up, SEL_bis, LD_verif, EN_verif : out std_logic;
	Date_in, SEL: out std_logic_vector(1 downto 0));
end UNITATE_DE_CONTROL;

architecture arh_UC of UNITATE_DE_CONTROL is
type STARE_TYPE is (INIT, ST0, ST1, ST2, ST3, ST4, ST5, ST6, ST7, ST8, ST9, ST10, ST11, ST12, ST13, ST14, ST15, ST16, ST17, ST18, ST19, ST20, ST21, ST22, ST23, ST24, ST25, ST26, ST27, ST28, ST29, ST30, ST31, ST32, ST33, ST34, ST35, ST36, ST37);
signal STARE, NXT_STARE: STARE_TYPE;
begin 
ACTUALIZEAZA_STARE: process(CLOCK)
begin
	 if Clock'event and Clock= '1' then 
		STARE <= NXT_STARE;
	end if;
end process ACTUALIZEAZA_STARE;
TRANZITII: process(STARE, B_confirmare,Loc_comanda, Directie, z_obstacol, z_greutate, Date_out, Sens_cmp, S, Etaj_curent, E, T5)
begin
	case STARE is
		when INIT => NXT_STARE <= ST0;
		when ST0 =>
			if B_confirmare = '1' then NXT_STARE <= ST1;
			else NXT_STARE <= ST0;
			end if;				  
		when ST1 => NXT_STARE <= ST2;
		when ST2 => NXT_STARE <= ST15;
		when ST3 =>
			if Date_out = "01" then NXT_STARE <= ST33;
			else NXT_STARE <= ST13;
			end if;
		when ST33 =>
		     NXT_STARE <= ST4;
		when ST4 => 
			if S = '1' then NXT_STARE <= ST7;
			else NXT_STARE <= ST5;
			end if;
        when ST5 =>  
			if Date_out = "00" then 
				if E = "1111" then 
					NXT_STARE <= ST6;
				else 
					NXT_STARE <= ST5;
				end if;
			else 
				NXT_STARE <= ST27;
			end if;
		when ST6 => NXT_STARE <= ST9;
        when ST7 =>
			if Date_out = "00" then
				if E = "1101" then 
					NXT_STARE <= ST8;
				else 
					NXT_STARE <= ST7;
				end if;
			else 
				NXT_STARE <= ST27;	
			end if;		
		when ST8 => NXT_STARE <= ST11;
        when ST9 =>
			if Date_out = "00" then
				if E = "1101" then
					NXT_STARE <= ST0;
				else 
					NXT_STARE <= ST9;
				end if;
			else
				NXT_STARE <= ST10;
			end if;
		when ST10 => NXT_STARE <= ST27;
        when ST11 =>
			if Date_out = "00" then 
				if E = "1111" then
					NXT_STARE <= ST0;
				else 
					NXT_STARE <= ST11;
				end if;
			else
				NXT_STARE <= ST12;
			end if; 
		when ST12 => NXT_STARE <= ST27;
		when ST27 => NXT_STARE <= ST28;
		when ST28 =>
		    if B_confirmare = '1' then
		        NXT_STARE <= ST29;
		    else 
		        NXT_STARE <= ST30;
		    end if;
		when ST29 =>
		    NXT_STARE <= ST30;
		when ST30 =>
			if T5="000" then 
				NXT_STARE <= ST21;
			else 
				NXT_STARE <= ST28;
			end if;
		when ST13 =>
			if B_confirmare = '0' then 
				NXT_STARE <= ST13;
			else 
				NXT_STARE <= ST14;
			end if;
		when ST14 => 
			if Loc_comanda = '1' then 
				NXT_STARE <= ST13;
			else
				NXT_STARE <= ST15;
			end if;
		when ST15 =>
			if B_confirmare = '1' then 
				NXT_STARE <= ST16;
			else
				NXT_STARE <= ST17;
			end if;
		when ST16 =>
			NXT_STARE <= ST17;
		when ST17 =>
			if T5 = "000" then 
				NXT_STARE <= ST18;
			else
				NXT_STARE <= ST15;	 
			end if;
		when ST18 =>
			if B_confirmare = '1' then 
				NXT_STARE <= ST19;
			else
				NXT_STARE <= ST20;
			end if;
		when ST19 =>
			NXT_STARE <= ST20;
		when ST20 =>
			if Z_obstacol = '0' and Z_greutate = '0' then 
			 	NXT_STARE <= ST21;
			else 
				NXT_STARE <= ST18;
			end if;
		when ST21 => 
			NXT_STARE <= ST26;
		when ST26 =>
			NXT_STARE <= ST22;
		when ST22 =>		  
			if B_confirmare = '1' then
				NXT_STARE <= ST23;
			else NXT_STARE <= ST24;
			end if;
		when ST23 =>
			NXT_STARE <= ST24;
		when ST24 =>
			NXT_STARE <= ST25;
		when ST25 =>
			if Date_out = "00" then 
				NXT_STARE <= ST22;
			else	
			    if Date_out(1) = '1' and Date_out(0) = S then 
				    NXT_STARE <= ST3;
				elsif Date_out = "01" then
				    NXT_STARE <= ST3;
				else
				    NXT_STARE <= ST35;
				end if;
  			end if;
		when ST35 =>
		    NXT_STARE <= ST31;
		when ST31 =>
		    if S = '0' then
		          NXT_STARE <= ST32;
		    else 
		          NXT_STARE <= ST34;
		    end if;
		when ST32 =>
			if Date_out = "00" then 
				if E = "1111" then 
					NXT_STARE <= ST36;
				else 
					NXT_STARE <= ST32;
				end if;
			else 
				NXT_STARE <= ST37;
			end if;
		when ST34 =>
			if Date_out = "00" then
				if E = "1101" then 
					NXT_STARE <= ST36;
				else 
		  	       	NXT_STARE <= ST34;
				end if;
			else 
				NXT_STARE <= ST37;	
			end if;	
		when ST36 => NXT_STARE <= ST3;	
		when ST37 => NXT_STARE <= ST22;	     		      
		when others => NXT_STARE <= INIT; 
		end case; 
end process TRANZITII;	
IESIRI: process(STARE)
begin 
	z_buton <= '0'; SEL <= "00"; usa_inchisa <= '0';
	RESET <= '0'; C_select <= '0'; D_in <= '0'; 
	EN_T5 <= '0'; R_T5 <= '0'; C_up <= '0'; SEL_bis <= '0';
	LD_verif <= '0'; EN_verif <='0';
	LED <= '0';Date_in <= "00";
	case STARE is
		when INIT => 
			RESET <= '1';
		when ST0 =>
			LED <= '1';
		when ST1 =>
			LED <= '1';
			SEL <= "01";
			z_buton <= '1';
			C_select <= '1';
			EN_T5 <= '1';
			R_T5 <= '1';
			if Loc_comanda = '1' then
				if Directie = '1' then
					Date_in <= "11";
				else 
					Date_in <= "10";
				end if;
			else Date_in <= "01";
			end if;	 
		when ST2 => 
			LED <= '1';
			SEL_bis <= '1';
			EN_T5 <= '1';
			if Sens_cmp = '1' then	 
				D_in <= '1';
			else 
				D_in <= '0';
			end if;
		when ST3 =>
			LED <= '1';
			SEL <= "10";
			C_select <= '1';
		  	if Date_out /= "01" then 
				  SEL_bis <= '1';
				  if Date_out = "11" then 
					  D_in <= '1';
				  elsif Date_out = "00" then
					  if S = '1' then D_in <= '0';
					  else D_in <= '1';
					  end if;
				  else
				       D_in <= '0';
				  end if;
			end if;
		when ST33 =>
	       	SEL <= "10";
			Z_buton <= '1';
			C_select <= '1';
			Date_in <= "00";
			EN_verif <= '1';
				LD_verif <= '1';
				if S = '1' then
					C_up <= '1';
				else 
					C_up <= '0';
				end if;
		when ST4 =>  
			SEL <= "00";
			C_select <= '1';
			EN_verif <= '1';
			if S = '1' then
				C_up <= '1';
			else 
				C_up <= '0';
			end if;
		when ST5 =>
			SEL <= "00";
			C_select <= '1';
			EN_verif <= '1';
			C_up <= '0';
		when ST6 =>
			SEL <= "00";
			C_select <= '1';
			EN_verif <= '1';
			LD_verif <= '1';
			C_up <= '1';
		when ST7 =>
			SEL <= "00";
			C_select <= '1';
			EN_verif <= '1';
			C_up <= '1';   
		when ST8 =>
			SEL <= "00";
			C_select <= '1';
			EN_verif <= '1';
			LD_verif <= '1';
			C_up <= '0';
		when ST9 =>
			SEL <= "00";
			C_select <= '1';
			EN_verif <= '1';
			C_up <= '1';
		when ST10 =>
			D_in <= '1';
			Sel_bis <= '1';
		when ST11 =>
			SEL <= "00";
			C_select <= '1';
			EN_verif <= '1';
			C_up <= '0';
		when ST12 =>
			D_in <= '0';
			Sel_bis <= '1';
		when ST27 =>
			LED <= '1';
			EN_T5 <= '1';
			R_T5 <= '1';
		when ST28 =>
		    EN_T5 <= '1';
		    LED <= '1';
		when ST29 =>
		    EN_T5 <= '1';
		    LED <= '1';
		    SEL <= "01";
		    C_select <= '1';
		    z_buton <= '1';
		    if Loc_comanda = '1' then
		          if Directie = '1' then
		              Date_in <= "11";
		          else
		              Date_in <= "10";
		          end if;
		     else
		          Date_in <= "01";
		     end if;
		when ST30 =>
			LED <= '1';
			EN_T5 <= '1';
		when ST13 => 
			LED <= '1';
		when ST14 =>
			LED <= '1';
			SEL <= "01";
			Z_buton <= '1';
			C_select <= '1';
			if Loc_comanda = '1' then
				if Directie = '1' then 
					Date_in <= "11";
				else
					Date_in <= "10";
				end if;
			else  
				Date_in <= "01";
				EN_T5 <= '1';
				R_T5 <= '1';  
			end if;
		when ST15 => 
			LED <= '1';
			EN_T5 <= '1';
		when ST16 =>
			LED <= '1';
			EN_T5 <= '1';
			SEL <= "01";
			Z_buton <= '1';
			C_select <= '1';
			if Loc_comanda = '1' then
				if Directie = '1' then 
					Date_in <= "11";
				else 
					Date_in <= "10";
				end if;
			else
				Date_in <= "01";
				R_T5 <= '1';
			end if;
		when ST17 => 
			LED <= '1';
			EN_T5 <= '1';
		when ST18 =>
			LED <= '1';
		when ST19 =>
			LED <= '1';
			SEL <= "01";
			Z_buton <= '1';
			C_select <= '1';
			if Loc_comanda = '1' then 
				if Directie = '1' then 
					Date_in <= "11";
				else 
					Date_in <= "10";
				end if;
			else
				Date_in <= "01";
			end if;
		when ST20 =>
			LED <= '1';
		when ST21 =>
			SEL <= "10";
			Z_buton <= '1';
			C_select <= '1';
			Date_in <= "00";
		when ST26 =>
			Usa_inchisa <= '1';
		when ST22 =>
			Usa_inchisa <= '1';	  
		when ST23 =>
			Usa_inchisa <= '1';
			SEL <= "01";
			C_select <= '1';
			Z_buton <= '1';
			if Loc_comanda = '1' then 
				if Directie = '1' then 
					Date_in <= "11";
				else
					Date_in <= "10";
				end if;
			else 
				Date_in <= "01";
			end if;
		when ST24 => 
			Usa_inchisa <= '1';
			SEL <= "10";
			C_select <= '1';
		when ST25 =>
			SEL <= "10";
			C_select <= '1';
			Usa_inchisa <= '1';
		when ST35 =>
		    SEL <= "10";
			Z_buton <= '1';
			C_select <= '1';
			Date_in <= "00";
			EN_verif <= '1';
			LD_verif <= '1';
        when ST31 =>
			SEL <= "00";
			C_select <= '1';
			EN_verif <= '1';
			if S = '1' then
				C_up <= '1';
			else 
				C_up <= '0';
			end if;
		when ST32 =>
		    SEL <= "00";
			C_select <= '1';
			EN_verif <= '1';
			C_up <= '0';
		when ST34 =>
            SEL <= "00";
			C_select <= '1';
			EN_verif <= '1';
			C_up <= '1';
		when ST36 =>
		     SEL <= "10";
		     c_select <= '1';
	    when ST37 =>
	         SEL <= "10";
		     c_select <= '1';
		     z_buton <= '1';
		     Date_in(1) <= '1';
		     if S = '1' then Date_in(0) <= '0';
		     else Date_in(0) <= '1';
		     end if;
		end case; 
end process IESIRI;
end arh_UC;
		
		