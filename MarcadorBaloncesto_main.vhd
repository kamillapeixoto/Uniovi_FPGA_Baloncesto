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
-- CREATED		"Sat Apr 22 22:43:15 2023"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY MarcadorBaloncesto_main IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		enable :  IN  STD_LOGIC;
		rst :  IN  STD_LOGIC;
		tempo :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		alarm :  OUT  STD_LOGIC;
		rst_verify :  OUT  STD_LOGIC;
		minutes :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		seconds :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END MarcadorBaloncesto_main;

ARCHITECTURE bdf_type OF MarcadorBaloncesto_main IS 

COMPONENT cronometro
GENERIC (MAX_COUNT_CLK : INTEGER;
			MAX_COUNT_MIN : INTEGER;
			MAX_COUNT_SEC : INTEGER;
			MIN_COUNT_CLK : INTEGER;
			MIN_COUNT_MIN : INTEGER;
			MIN_COUNT_SEC : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 duration : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 alarm : OUT STD_LOGIC;
		 time_min : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 time_sec : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;

COMPONENT rst_delay
GENERIC (MAX_COUNT_CLK : INTEGER;
			MIN_COUNT_CLK : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 rst_btn : IN STD_LOGIC;
		 rst_on : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;


BEGIN 
rst_verify <= SYNTHESIZED_WIRE_0;



b2v_inst : cronometro
GENERIC MAP(MAX_COUNT_CLK => 5,
			MAX_COUNT_MIN => 15,
			MAX_COUNT_SEC => 59,
			MIN_COUNT_CLK => 0,
			MIN_COUNT_MIN => 0,
			MIN_COUNT_SEC => 0
			)
PORT MAP(clk => clk,
		 reset => SYNTHESIZED_WIRE_0,
		 enable => enable,
		 duration => tempo,
		 alarm => alarm,
		 time_min => minutes,
		 time_sec => seconds);


b2v_inst1 : rst_delay
GENERIC MAP(MAX_COUNT_CLK => 5,
			MIN_COUNT_CLK => 0
			)
PORT MAP(clk => clk,
		 rst_btn => rst,
		 rst_on => SYNTHESIZED_WIRE_0);


END bdf_type;