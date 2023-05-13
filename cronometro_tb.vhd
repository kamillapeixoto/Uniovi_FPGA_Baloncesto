-- References: https://vhdlguide.readthedocs.io/en/latest/vhdl/testbench.html

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity cronometro_tb is
end cronometro_tb;

architecture tb of cronometro_tb is

		-- Entradas
		signal clk		   : std_logic := '0';
		signal rst			: std_logic := '0';	
		signal enable     : std_logic := '0';
		signal total_min  : std_logic_vector (3 downto 0);
		signal total_seg  : std_logic_vector (5 downto 0);
	
		-- Salidas
		signal sirena     : std_logic;
		signal tiempo_min : std_logic_vector (3 downto 0);
		signal tiempo_seg : std_logic_vector (5 downto 0);
	 
	   constant T : time := 20 ns; 
begin


	clk <= not clk after T/2;
	
	
    -- connecting testbench signals with cronometro.vhd
    dut : entity work.cronometro(rtl) 
	 port map (
		clk    => clk, 
		rst    => rst,
		enable => enable,
		
		-- Salidas
		sirena     => sirena,
		tiempo_min => tiempo_min, 
		tiempo_seg => tiempo_seg
	
	 
	 );
	
 process
	begin
	
		-- Desde zero a 1000 ns el testbench estará en el modo configurar
		arrancar_btn <= '1' after 1000 ns;
		 
		 
		rst <= -- Modo Configurar
						 '1' after 10 ns,
						 '0' after 30 ns, -- Reset presionado por 1 ciclo (nada cambia)
						 '1' after 50 ns,
						 '0' after 370 ns, -- Reset presionado por 6 segundos (6*clk) borrará todo
						 '1' after 850 ns,
						 '0' after 950 ns, -- Reset presionado por 5 segundos (5*clk) borrará todo
						 -- Modo Arrancar
						 '1' after 1010 ns,
						 '0' after 1030 ns, -- Reset presionado por 1 ciclo (nada cambia)
						 '1' after 1050 ns,
						 '0' after 1370 ns, -- Reset presionado por 6 segundos (6*clk) borrará todo
						 '1' after 1850 ns,
						 '0' after 1950 ns; -- Reset presionado por 5 segundos (5*clk) borrará todo
				 
		iniciar_tiempo <= -- Modo Configurar
						'1' after 30 ns,
						'0' after 50 ns, -- Ese botón no tiene efecto en ese modo
						-- Modo Arrancar				
						'1' after 1030 ns,
						'0' after 1050 ns, -- Inicia la cuenta regresiva
						'1' after 1830 ns,
						'0' after 1850 ns, -- Para la cuenta regresiva
						'1' after 1930 ns,
						'0' after 1950 ns, -- Inicia la cuenta regresiva
						'1' after 1970 ns,
						'0' after 1990 ns; -- Para la cuenta regresiva
						
		inc_loc  <= -- Modo Configurar
						'1' after 70 ns,
						'0' after 90 ns, -- Nada cambia, pues es necesario presionarlo por lo menos 0,5s 
						'1' after 110 ns,
						'0' after 510 ns, -- Incrementa X en la puntuación de local
						-- Modo Arrancar				
						'1' after 1070 ns,
						'0' after 1090 ns, -- Nada cambia, pues ese boton no está activo en el modo arrancar
						'1' after 1110 ns,
						'0' after 1510 ns; -- Nada cambia, pues ese boton no está activo en el modo arrancar
						
		dec_loc  <= -- Modo Configurar
						'1' after 510 ns,
						'0' after 530 ns, -- Nada cambia, pues es necesario presionarlo por lo menos 0,5s 
						'1' after 550 ns,
						'0' after 670 ns, -- Decrementa X en la puntuación de local
						-- Modo Arrancar	
						'1' after 1510 ns,
						'0' after 1530 ns,  -- Nada cambia, pues ese boton no está activo en el modo arrancar
						'1' after 1550 ns,
						'0' after 1670 ns;  -- Nada cambia, pues ese boton no está activo en el modo arrancar 
						
		inc_vis  <= -- Modo Configurar
						'1' after 690 ns, 
						'0' after 810 ns, -- Incrementa X en la puntuacion del visitante
						-- Modo Arrancar	
						'1' after 1690 ns, 
						'0' after 1810 ns;
						
		
						
		
						
	wait for 2000 ns;
	assert false report "Test: OK" severity failure;
end process;
	 
	

end architecture tb ;