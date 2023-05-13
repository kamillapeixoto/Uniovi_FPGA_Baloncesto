-- Quartus II VHDL Template
-- Binary Up/Down Counter with Saturation

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity modo_configurar is

	port 
	(
		clk		   : in std_logic;
		enable	   : in std_logic; -- salida del interruptor
		rst		   : in std_logic;
		
		inc_loc    : in std_logic;	
		dec_loc    : in std_logic;
		
		inc_vis    : in std_logic;	
		dec_vis    : in std_logic;
			
		inc_min    : in std_logic;	
		dec_min    : in std_logic;
		
		inc_sec    : in std_logic;	
		dec_sec    : in std_logic;
	
		
		visit_punt   : out std_logic_vector (7 downto 0);
		local_punt   : out std_logic_vector (7 downto 0);
		
	--	time_min    : out integer range 0 to 15;
	--	time_sec    : out integer range 0 to 60
	
		time_min    : out std_logic_vector (3 downto 0);	
		time_sec    : out std_logic_vector (5 downto 0)
		
		);

end entity;

architecture rtl of modo_configurar is

	
begin
	
	process (clk)
	
		variable visit_punt_var   : std_logic_vector (7 downto 0):="00000000";
		variable local_punt_var   : std_logic_vector (7 downto 0):="00000000";
		
		variable time_min_var 	  : std_logic_vector (3 downto 0):="0000";
		variable time_sec_var 	  : std_logic_vector (5 downto 0):="000000";
	
	begin
	
	
	if (rising_edge(clk)) then
			
		
			if (rst = '1') then
					visit_punt_var   :="00000000";
					visit_punt_var   :="00000000";
					time_min_var 	  := "0000";
					time_sec_var 	  := "000000";
			end if;
			
			if (enable = '1') then
			--	visit_punt_var := std_logic_vector(unsigned(visit_punt_var)+unsigned(inc_vis)-unsigned(dec_vis));
			--	local_punt_var := std_logic_vector(unsigned(local_punt_var)+unsigned(inc_loc)-unsigned(dec_loc));
			--	time_min_var   := time_min_var + inc_min*1 - dec_min*1;
			--	time_sec_var   := time_sec_var + unsigned(inc_sec) - unsigned(dec_sec);
			
			if (inc_vis = '1') then
				visit_punt_var := std_logic_vector(unsigned(visit_punt_var)+1);
			end if;
			if ((dec_vis = '1') and (unsigned(visit_punt_var) >0)) then
				visit_punt_var := std_logic_vector(unsigned(visit_punt_var)-1);
			end if;
			
			if (inc_loc = '1') then
				local_punt_var := std_logic_vector(unsigned(local_punt_var)+1);
			end if;
			if ((dec_loc = '1') and (unsigned(local_punt_var) > 0)) then
				local_punt_var := std_logic_vector(unsigned(local_punt_var)-1);
			end if;
			
			
			if (inc_min = '1') then
				time_min_var := std_logic_vector(unsigned(time_min_var) + 1);
			end if;
			if ((dec_min = '1') and (unsigned(time_min_var) > 0)) then
				time_min_var := std_logic_vector(unsigned(time_min_var) - 1);
			end if;
			
			if (inc_sec = '1') then
				time_sec_var := std_logic_vector(unsigned(time_sec_var) + 1);
			end if;
			if ((dec_sec = '1') and (unsigned(time_sec_var) > 0)) then
				time_sec_var := std_logic_vector(unsigned(time_sec_var) - 1);
			end if;
			
				
			end if; -- enable

		end if; -- clock
		
		visit_punt <= visit_punt_var; 
		local_punt <= local_punt_var;
		
		time_min   <= (time_min_var);
		time_sec   <= (time_sec_var);
		
	end process;

end rtl;
