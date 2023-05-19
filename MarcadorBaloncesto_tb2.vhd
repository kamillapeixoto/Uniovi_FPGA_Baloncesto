-- References: https://vhdlguide.readthedocs.io/en/latest/vhdl/testbench.html

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity MarcadorBaloncesto_tb2 is
end MarcadorBaloncesto_tb2;

architecture tb of MarcadorBaloncesto_tb2 is

		-- Entradas
		signal clk		   : std_logic := '0';
		signal rst			: std_logic := '0';
		
		signal arrancar_btn   : std_logic := '0';
		signal iniciar_tiempo : STD_LOGIC := '0';
		
		signal inc1_loc :  STD_LOGIC := '0';
		signal inc2_loc :  STD_LOGIC := '0';
		signal inc3_loc :  STD_LOGIC := '0';
		
		signal inc1_vis :  STD_LOGIC := '0';
		signal inc2_vis :  STD_LOGIC := '0';
		signal inc3_vis :  STD_LOGIC := '0';
		
		
		signal inc_loc    : std_logic:= '0';	
		signal dec_loc    : std_logic:= '0';
		
		signal inc_vis    : std_logic:= '0';	
		signal dec_vis    : std_logic:= '0';
			
		signal inc_min    : std_logic:= '0';	
		signal dec_min    : std_logic:= '0';
		
		signal inc_sec    : std_logic:= '0';	
		signal dec_sec    : std_logic:= '0';
	
		-- Salidas
		signal sirena_out     : std_logic;
		signal punt_loc   : std_logic_vector (7 downto 0);
		signal punt_vis   : std_logic_vector (7 downto 0);
	--	signal tiempo_min : integer range 0 to 15;
	--	signal tiempo_seg : integer range 0 to 60;
		signal tiempo_min : std_logic_vector (3 downto 0);
		signal tiempo_seg : std_logic_vector (5 downto 0);
		
	--	signal rst_test : std_logic;
	 
	   constant T : time := 10 ns; 
begin


	clk <= not clk after T/2;
	
	
    -- connecting testbench signals with MarcadorBaloncesto_mainv2.vhd
    dut : entity work.MarcadorBaloncesto_mainv2(bdf_type) 
	 port map (
		clk    => clk, 
		rst    => rst,
		arrancar_btn => arrancar_btn,
		iniciar_tiempo => iniciar_tiempo,
		
		inc1_loc    => inc1_loc,
		inc2_loc    => inc2_loc,
		inc3_loc    => inc3_loc,
		
		inc1_vis    => inc1_vis,	
		inc2_vis    => inc2_vis,	
		inc3_vis    => inc3_vis,
		
		
		inc_loc    => inc_loc,
		dec_loc    => dec_loc,
		
		inc_vis    => inc_vis,	
		dec_vis    => dec_vis,
			
		inc_min    => inc_min,	
		dec_min    => dec_min,
	
		inc_sec    => inc_sec,	
		dec_sec    => dec_sec,
		
		-- Salidas
		sirena_out     => sirena_out,
		punt_loc   => punt_loc,
		punt_vis   => punt_vis,
		tiempo_min => tiempo_min, 
		tiempo_seg => tiempo_seg
	--	rst_test => rst_test
	 
	 );
	
 process
	begin
	
		-- Reseta el sistema
		rst       <= '1' after 10 ns,
						 '0' after 30 ns, -- Reset presionado por 1 ciclo (nada cambia)
						 '1' after 50 ns,
						 '0' after 300 ns, -- Reset presionado por 5 segundos (5*clk) borrará todo
						 '1' after 8400 ns,
						 '0' after 8650 ns; -- Reset presionado por 5 segundos (5*clk) borrará todo

						 
		-- Pone en el modo configurar (ya está)
	
		-- Define la puntuacion del visitante como 12
		inc_vis      <= '1' after 310 ns,
							 '0' after 670 ns; -- Presiona por 6 segundos, pues la frecuencia es 2Hz
							 
		-- Define la puntuacion del local como 3, pasando por 4
		inc_loc      <= '1' after 680 ns,
							 '0' after 800 ns, -- Presiona por 2 segundos para llegar a 4	
							 '1' after 8680 ns,
							 '0' after 8690 ns; -- Comproba que el botón no funciona en el modo arrancar
						 
		dec_loc      <= '1' after 810 ns,
							 '0' after 840 ns, -- Presiona por 0.5 segundos para llegar a 3	
							 '1' after 8700 ns,
							 '0' after 8710 ns; -- Comproba que el botón no funciona en el modo arrancar
					
		-- Define la duracion del partido como 1 min y 30 segundos pasando por 1:34
		inc_min 		 <= '1' after 850 ns,
							 '0' after 880 ns, -- Presiona por 0.5 segundo para llegar a 1
							 '1' after 8720 ns,
							 '0' after 8730 ns; -- Comproba que el botón no funciona en el modo arrancar
							 
		inc_sec 		 <= '1' after 910 ns,
							 '0' after 1930 ns,  -- Presiona por 1 segundo para llegar a 2 
							 '1' after 8740 ns,
							 '0' after 8750 ns; -- Comproba que el botón no funciona en el modo arrancar
							 
		dec_sec 		 <= '1' after 1940 ns,
							 '0' after 2060 ns, -- Presiona por 1 segundo para llegar a 2 
							 '1' after 8760 ns,
							 '0' after 8770 ns; -- Comproba que el botón no funciona en el modo arrancar
				
		
		iniciar_tiempo <= '1' after 2070 ns,-- Comproba que los botones del modo arrancar no funcionan en el modo configurar
								'0' after 2080 ns,
								'1' after 2240 ns, -- Incia el partido
								'0' after 2250 ns,
								'1' after 2300 ns, -- Pausa el partido
								'0' after 2310 ns,
								'1' after 2460 ns, -- Continua el partido
								'0' after 2470 ns;  			
					
		
		inc1_loc  	 	<= '1' after 2090 ns,-- Comproba que los botones del modo arrancar no funcionan en el modo configurar
								'0' after 2100 ns,
								'1' after 2380 ns,-- Incrementa la puntuacion de local con el reloj inactivo
								'0' after 2390 ns; 
								
		inc2_loc   		<= '1' after 2110 ns, -- Comproba que los botones del modo arrancar no funcionan en el modo configurar
								'0' after 2120 ns,
								'1' after 2400 ns, -- Incrementa la puntuacion de local con el reloj inactivo
								'0' after 2410 ns; 
								
		inc3_loc    	<= '1' after 2130 ns,
								'0' after 2140 ns,
								'1' after 2420 ns,-- Incrementa la puntuacion de local con el reloj inactivo
								'0' after 2430 ns; 	
		
		inc1_vis   		<= '1' after 2150 ns,-- Comproba que los botones del modo arrancar no funcionan en el modo configurar
								'0' after 2160 ns, 
								'1' after 2320 ns, -- Incrementa la puntuacion de visitante con el reloj inactivo 
								'0' after 2330 ns; 	
								
		inc2_vis   		<= '1' after 2170 ns,-- Comproba que los botones del modo arrancar no funcionan en el modo configurar
								'0' after 2180 ns, 
								'1' after 2340 ns,-- Incrementa la puntuacion de visitante con el reloj activo 
								'0' after 2350 ns; 
								
		inc3_vis   		<= '1' after 2190 ns, -- Comproba que los botones del modo arrancar no funcionan en el modo configurar
								'0' after 2200 ns,
								'1' after 2360 ns, -- Incrementa la puntuacion de visitante con el reloj inactivo 
								'0' after 2370 ns; 
								
		-- Cambia al modo configurar 
		arrancar_btn <= '1' after 2210 ns;
		
		
		
		dec_vis <=		 '1' after 8780 ns,
							 '0' after 8790 ns; -- Comproba que el botón no funciona en el modo arrancar
							 

			
	wait for 8850 ns;
	assert false report "Test: OK" severity failure;
end process;
	 
	

end architecture tb ;