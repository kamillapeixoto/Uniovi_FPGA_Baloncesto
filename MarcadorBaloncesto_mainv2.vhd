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
-- CREATED		"Sat May 13 22:37:34 2023"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY MarcadorBaloncesto_mainv2 IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		rst :  IN  STD_LOGIC;
		arrancar_btn :  IN  STD_LOGIC;
		iniciar_tiempo :  IN  STD_LOGIC;
		inc1_loc :  IN  STD_LOGIC;
		inc2_loc :  IN  STD_LOGIC;
		inc3_loc :  IN  STD_LOGIC;
		inc1_vis :  IN  STD_LOGIC;
		inc2_vis :  IN  STD_LOGIC;
		inc3_vis :  IN  STD_LOGIC;
		inc_loc :  IN  STD_LOGIC;
		dec_loc :  IN  STD_LOGIC;
		inc_vis :  IN  STD_LOGIC;
		dec_vis :  IN  STD_LOGIC;
		inc_min :  IN  STD_LOGIC;
		dec_min :  IN  STD_LOGIC;
		inc_sec :  IN  STD_LOGIC;
		dec_sec :  IN  STD_LOGIC;
		rst_test :  OUT  STD_LOGIC;
		sirena_out :  OUT  STD_LOGIC;
		punt_loc :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		punt_vis :  OUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
		tiempo_min :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		tiempo_seg :  OUT  STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END MarcadorBaloncesto_mainv2;

ARCHITECTURE bdf_type OF MarcadorBaloncesto_mainv2 IS 

COMPONENT btn_delay
GENERIC (MAX_COUNT_CLK : INTEGER;
			MIN_COUNT_CLK : INTEGER
			);
	PORT(clk : IN STD_LOGIC;
		 btn_in : IN STD_LOGIC;
		 btn_out : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT modo_configurar
	PORT(clk : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 inc_loc : IN STD_LOGIC;
		 dec_loc : IN STD_LOGIC;
		 inc_vis : IN STD_LOGIC;
		 dec_vis : IN STD_LOGIC;
		 inc_min : IN STD_LOGIC;
		 dec_min : IN STD_LOGIC;
		 inc_sec : IN STD_LOGIC;
		 dec_sec : IN STD_LOGIC;
		 local_punt : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 time_min : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 time_sec : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
		 visit_punt : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END COMPONENT;

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
		 config_act : IN STD_LOGIC;
		 total_min : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 total_sec : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 alarm : OUT STD_LOGIC;
		 time_min : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 time_sec : OUT STD_LOGIC_VECTOR(5 DOWNTO 0)
	);
END COMPONENT;

COMPONENT modo_arrancar
	PORT(clk : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 rst : IN STD_LOGIC;
		 iniciar_tiempo : IN STD_LOGIC;
		 inc_loc1 : IN STD_LOGIC;
		 inc_loc2 : IN STD_LOGIC;
		 inc_loc3 : IN STD_LOGIC;
		 inc_vis1 : IN STD_LOGIC;
		 inc_vis2 : IN STD_LOGIC;
		 inc_vis3 : IN STD_LOGIC;
		 tot_local_con : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 tot_visit_con : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 contador_on : OUT STD_LOGIC;
		 tot_local : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 tot_visit : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
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
SIGNAL	SYNTHESIZED_WIRE_17 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_9 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_12 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_13 :  STD_LOGIC_VECTOR(5 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_15 :  STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_16 :  STD_LOGIC_VECTOR(7 DOWNTO 0);


BEGIN 
rst_test <= SYNTHESIZED_WIRE_17;



SYNTHESIZED_WIRE_0 <= NOT(arrancar_btn);



b2v_inst14 : btn_delay
GENERIC MAP(MAX_COUNT_CLK => 6,
			MIN_COUNT_CLK => 0
			)
PORT MAP(clk => clk,
		 btn_in => inc_loc,
		 btn_out => SYNTHESIZED_WIRE_2);


b2v_inst15 : modo_configurar
PORT MAP(clk => clk,
		 enable => SYNTHESIZED_WIRE_0,
		 rst => SYNTHESIZED_WIRE_17,
		 inc_loc => SYNTHESIZED_WIRE_2,
		 dec_loc => SYNTHESIZED_WIRE_3,
		 inc_vis => SYNTHESIZED_WIRE_4,
		 dec_vis => SYNTHESIZED_WIRE_5,
		 inc_min => SYNTHESIZED_WIRE_6,
		 dec_min => SYNTHESIZED_WIRE_7,
		 inc_sec => SYNTHESIZED_WIRE_8,
		 dec_sec => SYNTHESIZED_WIRE_9,
		 local_punt => SYNTHESIZED_WIRE_15,
		 time_min => SYNTHESIZED_WIRE_12,
		 time_sec => SYNTHESIZED_WIRE_13,
		 visit_punt => SYNTHESIZED_WIRE_16);


b2v_inst18 : cronometro
GENERIC MAP(MAX_COUNT_CLK => 5,
			MAX_COUNT_MIN => 15,
			MAX_COUNT_SEC => 59,
			MIN_COUNT_CLK => 0,
			MIN_COUNT_MIN => 0,
			MIN_COUNT_SEC => 0
			)
PORT MAP(clk => clk,
		 reset => SYNTHESIZED_WIRE_17,
		 enable => SYNTHESIZED_WIRE_11,
		 config_act => arrancar_btn,
		 total_min => SYNTHESIZED_WIRE_12,
		 total_sec => SYNTHESIZED_WIRE_13,
		 alarm => sirena_out,
		 time_min => tiempo_min,
		 time_sec => tiempo_seg);


b2v_inst20 : btn_delay
GENERIC MAP(MAX_COUNT_CLK => 6,
			MIN_COUNT_CLK => 0
			)
PORT MAP(clk => clk,
		 btn_in => dec_loc,
		 btn_out => SYNTHESIZED_WIRE_3);


b2v_inst21 : btn_delay
GENERIC MAP(MAX_COUNT_CLK => 6,
			MIN_COUNT_CLK => 0
			)
PORT MAP(clk => clk,
		 btn_in => inc_vis,
		 btn_out => SYNTHESIZED_WIRE_4);


b2v_inst22 : btn_delay
GENERIC MAP(MAX_COUNT_CLK => 6,
			MIN_COUNT_CLK => 0
			)
PORT MAP(clk => clk,
		 btn_in => dec_vis,
		 btn_out => SYNTHESIZED_WIRE_5);


b2v_inst23 : btn_delay
GENERIC MAP(MAX_COUNT_CLK => 6,
			MIN_COUNT_CLK => 0
			)
PORT MAP(clk => clk,
		 btn_in => inc_min,
		 btn_out => SYNTHESIZED_WIRE_6);


b2v_inst24 : btn_delay
GENERIC MAP(MAX_COUNT_CLK => 6,
			MIN_COUNT_CLK => 0
			)
PORT MAP(clk => clk,
		 btn_in => dec_min,
		 btn_out => SYNTHESIZED_WIRE_7);


b2v_inst25 : btn_delay
GENERIC MAP(MAX_COUNT_CLK => 6,
			MIN_COUNT_CLK => 0
			)
PORT MAP(clk => clk,
		 btn_in => inc_sec,
		 btn_out => SYNTHESIZED_WIRE_8);


b2v_inst26 : btn_delay
GENERIC MAP(MAX_COUNT_CLK => 6,
			MIN_COUNT_CLK => 0
			)
PORT MAP(clk => clk,
		 btn_in => dec_sec,
		 btn_out => SYNTHESIZED_WIRE_9);


b2v_inst_arrancar : modo_arrancar
PORT MAP(clk => clk,
		 enable => arrancar_btn,
		 rst => SYNTHESIZED_WIRE_17,
		 iniciar_tiempo => iniciar_tiempo,
		 inc_loc1 => inc1_loc,
		 inc_loc2 => inc2_loc,
		 inc_loc3 => inc3_loc,
		 inc_vis1 => inc1_vis,
		 inc_vis2 => inc2_vis,
		 inc_vis3 => inc3_vis,
		 tot_local_con => SYNTHESIZED_WIRE_15,
		 tot_visit_con => SYNTHESIZED_WIRE_16,
		 contador_on => SYNTHESIZED_WIRE_11,
		 tot_local => punt_loc,
		 tot_visit => punt_vis);


b2v_inst_rst : rst_delay
GENERIC MAP(MAX_COUNT_CLK => 5,
			MIN_COUNT_CLK => 0
			)
PORT MAP(clk => clk,
		 rst_btn => rst,
		 rst_on => SYNTHESIZED_WIRE_17);


END bdf_type;