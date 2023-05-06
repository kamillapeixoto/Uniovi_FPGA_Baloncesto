-- References: https://vhdlguide.readthedocs.io/en/latest/vhdl/testbench.html

library ieee;
use ieee.std_logic_1164.all;


entity rst_delay_tb is
end rst_delay_tb;

architecture tb of rst_delay_tb is
	 -- inputs    
	signal clk : std_logic := '0';
	signal rst_btn : std_logic := '0';  
	 -- output
    signal rst_on : std_logic; 
	 
	 constant T : time := 20 ns; 
begin



	clk <= not clk after T/2;
	
	
    -- connecting testbench signals with rst_delay.vhd
    dut : entity work.rst_delay(rtl) port map (clk => clk, rst_btn => rst_btn, rst_on => rst_on);

	
		  

	
 process
	begin
	rst_btn  <= '1' after 60 ns,
					'0' after 100 ns, 
					'1' after 200 ns,
					'0' after 900 ns;
	wait for 1000 ns;
	assert false report "Test: OK" severity failure;
end process;
	 
	

end architecture tb ;