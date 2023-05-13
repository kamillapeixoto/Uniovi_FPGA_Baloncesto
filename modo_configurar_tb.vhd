-- References: https://vhdlguide.readthedocs.io/en/latest/vhdl/testbench.html

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity modo_configurar_tb is
end modo_configurar_tb;

architecture tb of modo_configurar_tb is
		signal clk		   : std_logic := '0';
		signal enable	   : std_logic := '0'; -- salida del interruptor
		signal rst			: std_logic := '0';
		
		signal inc_loc    : std_logic:= '0';	
		signal dec_loc    : std_logic:= '0';
		
		signal inc_vis    : std_logic:= '0';	
		signal dec_vis    : std_logic:= '0';
			
		signal inc_min    : std_logic:= '0';	
		signal dec_min    : std_logic:= '0';
		
		signal inc_sec    : std_logic:= '0';	
		signal dec_sec    : std_logic:= '0';
	
		
		signal visit_punt   : std_logic_vector (7 downto 0):= "00000000";
		signal local_punt   : std_logic_vector (7 downto 0):= "00000000";
		
		signal time_min    : integer range 0 to 15 := 0;
		signal time_sec    : integer range 0 to 60 := 0;
	 
	   constant T : time := 20 ns; 
begin


	clk <= not clk after T/2;
	
	
    -- connecting testbench signals with modo_arrancar.vhd
    dut : entity work.modo_configurar(rtl) 
	 port map (
		clk    => clk, 
		enable => enable,
		rst    => rst,
		
		inc_loc    => inc_loc,
		dec_loc    => dec_loc,
		
		inc_vis    => inc_vis,	
		dec_vis    => dec_vis,
			
		inc_min    => inc_min,	
		dec_min    => dec_min,
	
		inc_sec    => inc_sec,	
		dec_sec    => dec_sec,
	
		
		visit_punt  => visit_punt,
		local_punt  => local_punt,
		
		time_min    => time_min,
		time_sec    => time_sec
		
	 
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
				 
				 
		inc_loc  <= '1' after 50 ns,
						'0' after 70 ns,
						'1' after 550 ns,
						'0' after 570 ns;
						
		dec_loc  <= '1' after 70 ns,
						'0' after 90 ns,
						'1' after 570 ns,
						'0' after 590 ns;
						
		inc_vis  <=  '1' after 90 ns,
						'0' after 110 ns,
						'1' after 590 ns,
						'0' after 610 ns;
						
						
		dec_vis  <= '1' after 110 ns,
						'0' after 150 ns,
						'1' after 610 ns,
						'0' after 630 ns,
						'1' after 750 ns,
						'0' after 810 ns;
						
		inc_min <=	'1' after 150 ns,
						'0' after 170 ns,
						'1' after 650 ns,
						'0' after 670 ns;
						
		dec_min  <=	'1' after 170 ns,
						'0' after 190 ns,
						'1' after 670 ns,
						'0' after 690 ns;
		
		inc_sec  <= '1' after 190 ns,
						'0' after 210 ns,
						'1' after 690 ns,
						'0' after 710 ns;
						
		dec_sec  <= '1' after 210 ns,
						'0' after 230 ns,
						'1' after 710 ns,
						'0' after 750 ns;
						
		
						
	wait for 1000 ns;
	assert false report "Test: OK" severity failure;
end process;
	 
	

end architecture tb ;