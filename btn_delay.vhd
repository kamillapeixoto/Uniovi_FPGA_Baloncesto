-- Quartus II VHDL Template
-- Binary Up/Down Counter with Saturation

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity btn_delay is

	generic
	(

		-- Reloj
		MIN_COUNT_CLK  : natural:= 0;
		MAX_COUNT_CLK  : natural:= 51000000
		-- Clock de 50 Mhz de la FPGA, pero será usado 6 solamente para facilitar la simulacion
	);

	port 
	(
		clk		   : in std_logic;
		btn_in      : in std_logic;
		btn_out   	: out std_logic
	);

end entity;

architecture rtl of btn_delay is
	signal count_05sec: integer;
	
	
begin

	process (clk)
		variable cnt  : integer range 0 to 5*MAX_COUNT_CLK;
		 
		
	begin
		count_05sec <= MAX_COUNT_CLK/2;
		
		-- Synchronously update the counter
		if (rising_edge(clk)) then

			if (btn_in = '1') then
				cnt := cnt + 1;
			else
				cnt := 0;
			end if;
			
			if (cnt >= count_05sec) then
				btn_out <= '1';
				cnt := 0;
			else
				btn_out <= '0';			
			end if;
			
		end if;
	end process;

end rtl;
