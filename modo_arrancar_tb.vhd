-- References: https://vhdlguide.readthedocs.io/en/latest/vhdl/testbench.html

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity modo_arrancar_tb is
end modo_arrancar_tb;

architecture tb of modo_arrancar_tb is
		signal clk		   : std_logic := '0';
		signal enable	   : std_logic := '0'; -- salida del interruptor
		signal rst			: std_logic := '0';
		signal inicio     : std_logic := '0';
		
		signal iniciar_tiempo:std_logic := '0';
		
		signal inc_loc1    : std_logic:= '0';	
		signal inc_loc2    : std_logic:= '0';
		signal inc_loc3    : std_logic:= '0';
		
		signal inc_vis1    : std_logic:= '0';	
		signal inc_vis2    : std_logic:= '0';
		signal inc_vis3    : std_logic:= '0';
		
	--	signal tot_visit_con: integer range 0 to 255 :=0;
	--	signal tot_local_con: integer range 0 to 255 :=32;
	
		signal tot_visit_con:  std_logic_vector (7 downto 0) := "00000001";
		signal tot_local_con:  std_logic_vector (7 downto 0) := "00000110";
		
		signal contador_on : std_logic;

	--	signal tot_visit   :integer range 0 to 255;
	--	signal tot_local   :integer range 0 to 255;
	
		signal tot_visit   :  std_logic_vector (7 downto 0);
		signal tot_local   :  std_logic_vector (7 downto 0);
	 
	   constant T : time := 20 ns; 
begin


	clk <= not clk after T/2;
	
	
    -- connecting testbench signals with modo_arrancar.vhd
    dut : entity work.modo_arrancar(rtl) 
	 port map (
		clk => clk, 
		enable => enable,
		rst => rst,
		inicio => inicio,
		
		iniciar_tiempo => iniciar_tiempo,
		
		inc_loc1    => inc_loc1,
		inc_loc2    => inc_loc2,
		inc_loc3    => inc_loc3,
		
		inc_vis1    => inc_vis1,	
		inc_vis2    => inc_vis2,	
		inc_vis3    => inc_vis3,	
		
		tot_visit_con => tot_visit_con,
		tot_local_con => tot_local_con,
		
		contador_on  => contador_on,

		tot_visit    => tot_visit,
		tot_local    => tot_local
	 
	 );
	
 process
	begin
	
		enable <= '1' after 500 ns;
		 
		rst <= '1' after 10 ns,
				 '0' after 30 ns,
				 '1' after 510 ns,
				 '0' after 530 ns,
				 '1' after 750 ns,
				 '0' after 770 ns;				 
				 
				 
		inicio  <=  '1' after 30 ns,
						'0' after 50 ns,
						'1' after 530 ns,
						'0' after 550 ns;
				 
		iniciar_tiempo <= '1' after 50 ns,
						'0' after 70 ns,
						'1' after 550 ns,
						'0' after 570 ns,
						'1' after 790 ns,
						'0' after 810 ns,
						'1' after 830 ns,
						'0' after 850 ns,
						'1' after 870 ns,
						'0' after 890 ns;
						
		inc_loc1 <= '1' after 70 ns,
						'0' after 90 ns,
						'1' after 570 ns,
						'0' after 590 ns;
						
		inc_loc2  <= '1' after 90 ns,
						'0' after 110 ns,
						'1' after 590 ns,
						'0' after 610 ns;
						
		inc_loc3  <= '1' after 110 ns,
						'0' after 150 ns,
						'1' after 610 ns,
						'0' after 650 ns;
						
		inc_vis1  <= '1' after 150 ns,
						'0' after 170 ns,
						'1' after 650 ns,
						'0' after 670 ns;
				 
		inc_vis2  <='1' after 170 ns,
						'0' after 190 ns,
						'1' after 670 ns,
						'0' after 690 ns;
		
		inc_vis3 <= '1' after 190 ns,
						'0' after 210 ns,
						'1' after 690 ns,
						'0' after 710 ns;
						
	wait for 1000 ns;
	assert false report "Test: OK iha" severity failure;
end process;
	 
	

end architecture tb ;