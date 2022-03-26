library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity Circuit_comparare is
	port( IN1: in std_logic_vector(3 downto 0);
	Y0, Y1: out std_logic_vector(3 downto 0));
end Circuit_comparare;

architecture arh_comp of Circuit_comparare is
begin
	process(IN1)
	begin 
		if IN1 = "0000" then
			Y0 <= "1010";
			Y1 <= "1011";
		elsif IN1 <= 9 then 
			Y0 <= "0000";
			Y1 <= IN1; 
		elsif IN1 = "1010" then
			Y0 <= "0001";
			Y1 <= "0000";
		elsif IN1 = "1011" then 
			Y0 <= "0001";
			Y1 <= "0001";
		else
			Y0 <= "0001";
			Y1 <= "0010";
		end if;
	end process;
end arh_comp;

library IEEE;
use IEEE.std_logic_1164.all;

entity Bistabil_T is
	port(Clk: in std_logic;
	Qn: out std_logic);
end Bistabil_T;

architecture arh_bistabil of Bistabil_T is
signal S: std_logic := '0' ;
begin
	process(Clk)	 
	begin	 
		if (Clk'event and Clk = '1') then
			S <= not S;	  
		end if;
	end process;
	Qn <= S;
end arh_bistabil; 

library	IEEE;
use IEEE.std_logic_1164.all;

entity MUX_2_1_afisor is 
	port(I0, I1: in std_logic_vector(3 downto 0);
	S: in std_logic;
	Y: out std_logic_vector(3 downto 0));
end MUX_2_1_afisor;

architecture arh_mux of MUX_2_1_afisor is
begin
	process(I0, I1, S)
	begin
		if S = '0' then Y <= I0;
		else Y <= I1;
		end if;
	end process;
end arh_mux; 

library IEEE;
use IEEE.std_logic_1164.all;

entity DCD_2_1 is
	port(A: in std_logic;
	I0, I1: out std_logic);
end DCD_2_1;

architecture arh_DCD_2_1 of DCD_2_1 is
begin  
	process(A) 
	begin
		if A = '0' then
			I1 <= '0';
			I0 <= '1';
		else 
			I1 <= '1';
			I0 <= '0';
		end if;
	end process;
end arh_DCD_2_1;	

library IEEE;
use IEEE.std_logic_1164.all;

entity DCD_BCD_7segmente is
	port(A_in: in std_logic_vector(3 downto 0);
	led: out std_logic_vector(6 downto 0));
end DCD_BCD_7segmente;

architecture arh_DCD_BCD_7segmente of DCD_BCD_7segmente is
type MEMORIE is array(0 to 11) of std_logic_vector (6 downto 0);
signal mem: MEMORIE := ("0000001", "1001111", "0010010", "0000110", "1001100", "0100100", "0100000", "0001111", "0000000", "0000100", "1111111", "0011000");
begin
	process(A_in)
	begin
		case A_in is
			when "0000" => led <= mem(0);
			when "0001" => led <= mem(1);
			when "0010" => led <= mem(2);
			when "0011" => led <= mem(3);
			when "0100" => led <= mem(4);
			when "0101" => led <= mem(5);
			when "0110" => led <= mem(6);
			when "0111" => led <= mem(7);
			when "1000" => led <= mem(8);
			when "1001" => led <= mem(9);
			when "1010" => led <= mem(10);
			when others => led <= mem(11);
		end case; 
	end process;
end arh_DCD_BCD_7segmente;

library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity div_frecventa is
	port(Clock_in: in std_logic;
	Clock_out: out std_logic);
end div_frecventa;

architecture arh_div_frecventa of div_frecventa is
signal T: std_logic := '0' ;
begin
	process(Clock_in)
	variable count: std_logic_vector(16 downto 0) := (others => '0');
	begin
		if (Clock_in'event and clock_in = '1') then count := count + 1;	   
		end if;	
		if count = 25_000 then 
			T <= not T;
			count := (others => '0');
		end if;
	end process;
	Clock_out <= T;
end arh_div_frecventa;

library	IEEE;
use IEEE.std_logic_1164.all;   

entity afisor is
	port(digit: in std_logic_vector(3 downto 0);
	Clock: in std_logic;	
	anod: out std_logic_vector(3 downto 0);
	catod: out std_logic_vector(6 downto 0));
end afisor;

architecture arh_afisor of afisor is 
component Circuit_comparare 
	port( IN1: in std_logic_vector(3 downto 0);
	Y0, Y1: out std_logic_vector(3 downto 0));
end component;
component Bistabil_T 
	port(Clk: in std_logic;
	Qn: out std_logic);
end component;
component MUX_2_1_afisor  
	port(I0, I1: in std_logic_vector(3 downto 0);
	S: in std_logic;
	Y: out std_logic_vector(3 downto 0));
end component;
component DCD_2_1
	port(A: in std_logic;
	I0, I1: out std_logic);
end component;
component DCD_BCD_7segmente 
	port(A_in: in std_logic_vector(3 downto 0);
	led: out std_logic_vector(6 downto 0));
end component;
component div_frecventa
	port(Clock_in: in std_logic;
	Clock_out: out std_logic);
end component;	 
signal cifra_zeci, cifra_unitati, cifra: std_logic_vector(3 downto 0);
signal c_div: std_logic; 
signal T: std_logic;
begin
	c1: CIRCUIT_COMPARARE port map (IN1 => digit, Y0 => cifra_zeci, Y1 => cifra_unitati);
	c2: DIV_FRECVENTA port map (Clock_in  => Clock , Clock_out => C_div);
	c3: BISTABIL_T port map (Clk => c_div, Qn => T);
	c4: MUX_2_1_afisor port map (I0 => cifra_zeci, I1 => cifra_unitati, S => T, Y =>cifra);
	c5: DCD_2_1 port map (A => T, I0 => anod(0), I1 => anod(1));
	c6: DCD_BCD_7segmente port map (A_in => cifra, led => catod);
	anod(2) <= '1';
	anod(3) <= '1';
end arh_afisor;