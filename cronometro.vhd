-- Quartus II VHDL Template
-- Binary Up/Down Counter with Saturation

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cronometro is

	generic
	(

		-- Segundos
		MIN_COUNT_SEC : natural := 0;
		MAX_COUNT_SEC : natural := 59;
	
		-- Minutos
		MIN_COUNT_MIN : natural := 0;
		MAX_COUNT_MIN : natural := 15; -- Valor arbitrario	
		
		-- Reloj
		MIN_COUNT_CLK  : natural:= 0;
		MAX_COUNT_CLK  : natural:= 5
		-- Clock de 50 Mhz de la FPGA, pero será usado 5 solamente para facilitar la simulacion
	);

	port 
	(
		clk		   : in std_logic;
		reset	      : in std_logic;
		enable	   : in std_logic;
		config_act  : in std_logic;
		total_min   : in std_logic_vector (3 downto 0);
		total_sec   : in std_logic_vector (5 downto 0);
		time_min    : out std_logic_vector (3 downto 0);
		time_sec    : out std_logic_vector (5 downto 0);
		alarm			: out std_logic
	);

end entity;

architecture rtl of cronometro is
	
begin

	process (clk)
		variable cnt  : integer range 0 to 5;
		variable done : integer range 0 to 4; -- Toca la alarma por 4 segundos
		variable end_count :std_logic;
		variable time_min_var : std_logic_vector (3 downto 0);
		variable time_sec_var : std_logic_vector (5 downto 0);
	begin

		-- Synchronously update the counter
		if (rising_edge(clk)) then

			if (reset = '1') then
				-- Reset the counter to 0
				cnt := MIN_COUNT_CLK;
				time_min_var := total_min;
				time_sec_var := total_sec;
				alarm <= '0';
				done := 0;
				end_count := '0';
			end if;
			if (config_act = '0') then --en modo configurar los botones van directamente a la salida
				time_min_var := total_min;
				time_sec_var := total_sec;
			elsif (enable = '1' and cnt /= MAX_COUNT_CLK and done < 4) then
				-- Decrement the counter, 
				-- if the limit is not exceeded
				cnt := cnt + 1;
			elsif (cnt = MAX_COUNT_CLK) then -- Ha pasado 1 segundo
				cnt := 0;
				if (end_count = '1') then
					done := done + 1;
					if (done = 4) then -- Conta 4 segundos y desactiva la alarma
						end_count := '0';
					end if;
				elsif (unsigned(time_sec_var) = 0) then
					if (unsigned(time_min_var) = 0) then
						end_count := '1';
					else						
						time_sec_var := "111011"; -- verificar se é lsb ou msb
						time_min_var := std_logic_vector(unsigned(time_min_var) -1);
						end if;
				else
					time_sec_var := std_logic_vector(unsigned(time_sec_var) - 1);
				end if;
			

			end if;
		end if;
		
		alarm <= end_count;
		time_sec <= time_sec_var;
		time_min <= time_min_var;
	end process;

end rtl;
