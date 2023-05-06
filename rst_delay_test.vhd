-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Sat Apr 22 22:32:40 2023"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY rst_delay_test IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		rst :  IN  STD_LOGIC;
		rst_verify :  OUT  STD_LOGIC
	);
END rst_delay_test;

ARCHITECTURE bdf_type OF rst_delay_test IS 

COMPONENT rst_delay
GENERIC (MAX_COUNT_CLK : INTEGER;
			MIN_COUNT_CLK : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 rst_btn : IN STD_LOGIC;
		 rst_on : OUT STD_LOGIC
	);
END COMPONENT;



BEGIN 



b2v_inst1 : rst_delay
GENERIC MAP(MAX_COUNT_CLK => 5,
			MIN_COUNT_CLK => 0
			)
PORT MAP(clk => clk,
		 rst_btn => rst,
		 rst_on => rst_verify);


END bdf_type;