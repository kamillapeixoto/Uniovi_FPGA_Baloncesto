-- Quartus II VHDL Template
-- Binary Up/Down Counter with Saturation

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity modo_arrancar is

	port 
	(
		clk		   : in std_logic;
		enable	   : in std_logic; -- salida del interruptor
		rst			: in std_logic;
		inicio      : in std_logic;
		
		iniciar_tiempo: in std_logic;
		
		inc_loc1    : in std_logic;	
		inc_loc2    : in std_logic;
		inc_loc3    : in std_logic;
		
		inc_vis1    : in std_logic;	
		inc_vis2    : in std_logic;
		inc_vis3    : in std_logic;
		
		
		tot_visit_con:  in std_logic_vector (7 downto 0);
		tot_local_con:  in std_logic_vector (7 downto 0);
	
	--	tot_visit_con:  in integer range 0 to 255;
	--	tot_local_con: in integer range 0 to 255;
		
		contador_on : out std_logic := '0';

	--	tot_visit   : out integer range 0 to 255;
--		tot_local   : out integer range 0 to 255

		tot_visit   : out std_logic_vector (7 downto 0);
		tot_local   : out std_logic_vector (7 downto 0)

		
		);

end entity;

architecture rtl of modo_arrancar is

	
begin


		
--	process (enable)
--
--	begin
--		if (rising_edge(enable)) then
--				tot_visit_var <= tot_visit_con;
--				tot_local_var <= tot_local_con;
--		end if;
--		
--		end process;
	
	process (clk)
	
		variable contador_status : std_logic := '0';
		variable tot_visit_var   : std_logic_vector (7 downto 0);
		variable tot_local_var   : std_logic_vector (7 downto 0);
		
	--	variable tot_visit_con_i   : integer range 0 to 255;
	--	variable tot_local_con_i   : integer range 0 to 255;
	
	
	begin
	
	--tot_visit_con_i := to_integer(unsigned(tot_visit_con));
	--tot_local_con_i := to_integer(unsigned(tot_local_con));
	
	if (rising_edge(clk)) then
			
		
			if (rst = '1') then
					tot_visit_var := tot_visit_con;
					tot_local_var := tot_local_con;
					contador_status := '0';
			end if;
			
			if (enable = '1') then
				if (inicio = '1') then
					tot_visit_var := tot_visit_con;
					tot_local_var := tot_local_con;
				end if;
				if (iniciar_tiempo = '1') then
					contador_status := not contador_status;
				end if;
				
				if (inc_loc1 = '1') then
					tot_local_var := std_logic_vector(unsigned(tot_local_var)+1);
				end if;
				
				if (inc_loc2 = '1') then
					tot_local_var := std_logic_vector(unsigned(tot_local_var)+2);
				end if;
				
				if (inc_loc3 = '1') then
					tot_local_var := std_logic_vector(unsigned(tot_local_var)+3);
				end if;
				
				if (inc_vis1 = '1') then
					tot_visit_var := std_logic_vector(unsigned(tot_visit_var)+1);
				end if;
				
				if (inc_vis2 = '1') then
					tot_visit_var := std_logic_vector(unsigned(tot_visit_var)+2);
				end if;
				
				if (inc_vis3 = '1') then
					tot_visit_var := std_logic_vector(unsigned(tot_visit_var)+3);
				end if;
				
			end if; -- enable

		end if; -- clock

		contador_on <= contador_status;
		tot_visit <= tot_visit_var;
		tot_local <= tot_local_var;
		
	end process;

end rtl;
