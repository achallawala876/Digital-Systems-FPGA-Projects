-- megafunction wizard: %RAM: 2-PORT%
-- GENERATION: STANDARD
-- VERSION: WM1.0
-- MODULE: altsyncram 

-- ============================================================
-- File Name: VRAM.vhd
-- Megafunction Name(s):
-- 			altsyncram
--
-- Simulation Library Files(s):
-- 			altera_mf
-- ============================================================
-- ************************************************************
-- THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--
-- 18.1.0 Build 625 09/12/2018 SJ Lite Edition
-- ************************************************************


--Copyright (C) 2018  Intel Corporation. All rights reserved.
--Your use of Intel Corporation's design tools, logic functions 
--and other software and tools, and its AMPP partner logic 
--functions, and any output files from any of the foregoing 
--(including device programming or simulation files), and any 
--associated documentation or information are expressly subject 
--to the terms and conditions of the Intel Program License 
--Subscription Agreement, the Intel Quartus Prime License Agreement,
--the Intel FPGA IP License Agreement, or other applicable license
--agreement, including, without limitation, that your use is for
--the sole purpose of programming logic devices manufactured by
--Intel and sold by Intel or its authorized distributors.  Please
--refer to the applicable agreement for further details.


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY VRAM IS
	PORT
	(
		address_a		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		address_b		: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		byteena_a		: IN STD_LOGIC_VECTOR (3 DOWNTO 0) :=  (OTHERS => '1');
		clock		: IN STD_LOGIC  := '1';
		data_a		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		data_b		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rden_a		: IN STD_LOGIC  := '1';
		rden_b		: IN STD_LOGIC  := '1';
		wren_a		: IN STD_LOGIC  := '0';
		wren_b		: IN STD_LOGIC  := '0';
		q_a		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		q_b		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END VRAM;


ARCHITECTURE SYN OF vram IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC_VECTOR (31 DOWNTO 0);

BEGIN
	q_a    <= sub_wire0(31 DOWNTO 0);
	q_b    <= sub_wire1(31 DOWNTO 0);

	altsyncram_component : altsyncram
	GENERIC MAP (
		address_reg_b => "CLOCK0",
		byte_size => 8,
		clock_enable_input_a => "BYPASS",
		clock_enable_input_b => "BYPASS",
		clock_enable_output_a => "BYPASS",
		clock_enable_output_b => "BYPASS",
		indata_reg_b => "CLOCK0",
		intended_device_family => "MAX 10",
		lpm_type => "altsyncram",
		numwords_a => 32,
		numwords_b => 32,
		operation_mode => "BIDIR_DUAL_PORT",
		outdata_aclr_a => "NONE",
		outdata_aclr_b => "NONE",
		outdata_reg_a => "CLOCK0",
		outdata_reg_b => "CLOCK0",
		power_up_uninitialized => "FALSE",
		ram_block_type => "M9K",
		read_during_write_mode_mixed_ports => "DONT_CARE",
		read_during_write_mode_port_a => "NEW_DATA_WITH_NBE_READ",
		read_during_write_mode_port_b => "NEW_DATA_WITH_NBE_READ",
		widthad_a => 5,
		widthad_b => 5,
		width_a => 32,
		width_b => 32,
		width_byteena_a => 4,
		width_byteena_b => 1,
		wrcontrol_wraddress_reg_b => "CLOCK0"
	)
	PORT MAP (
		address_a => address_a,
		address_b => address_b,
		byteena_a => byteena_a,
		clock0 => clock,
		data_a => data_a,
		data_b => data_b,
		rden_a => rden_a,
		rden_b => rden_b,
		wren_a => wren_a,
		wren_b => wren_b,
		q_a => sub_wire0,
		q_b => sub_wire1
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
-- Retrieval info: PRIVATE: ADDRESSSTALL_B NUMERIC "0"
-- Retrieval info: PRIVATE: BYTEENA_ACLR_A NUMERIC "0"
-- Retrieval info: PRIVATE: BYTEENA_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_ENABLE_A NUMERIC "1"
-- Retrieval info: PRIVATE: BYTE_ENABLE_B NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
-- Retrieval info: PRIVATE: BlankMemory NUMERIC "1"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "0"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_B NUMERIC "0"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "0"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_B NUMERIC "0"
-- Retrieval info: PRIVATE: CLRdata NUMERIC "0"
-- Retrieval info: PRIVATE: CLRq NUMERIC "0"
-- Retrieval info: PRIVATE: CLRrdaddress NUMERIC "0"
-- Retrieval info: PRIVATE: CLRrren NUMERIC "0"
-- Retrieval info: PRIVATE: CLRwraddress NUMERIC "0"
-- Retrieval info: PRIVATE: CLRwren NUMERIC "0"
-- Retrieval info: PRIVATE: Clock NUMERIC "0"
-- Retrieval info: PRIVATE: Clock_A NUMERIC "0"
-- Retrieval info: PRIVATE: Clock_B NUMERIC "0"
-- Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
-- Retrieval info: PRIVATE: INDATA_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: INDATA_REG_B NUMERIC "1"
-- Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_A"
-- Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "MAX 10"
-- Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "0"
-- Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
-- Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
-- Retrieval info: PRIVATE: MEMSIZE NUMERIC "1024"
-- Retrieval info: PRIVATE: MEM_IN_BITS NUMERIC "1"
-- Retrieval info: PRIVATE: MIFfilename STRING ""
-- Retrieval info: PRIVATE: OPERATION_MODE NUMERIC "3"
-- Retrieval info: PRIVATE: OUTDATA_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: OUTDATA_REG_B NUMERIC "1"
-- Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "2"
-- Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_MIXED_PORTS NUMERIC "2"
-- Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_A NUMERIC "4"
-- Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_B NUMERIC "4"
-- Retrieval info: PRIVATE: REGdata NUMERIC "1"
-- Retrieval info: PRIVATE: REGq NUMERIC "1"
-- Retrieval info: PRIVATE: REGrdaddress NUMERIC "0"
-- Retrieval info: PRIVATE: REGrren NUMERIC "1"
-- Retrieval info: PRIVATE: REGwraddress NUMERIC "1"
-- Retrieval info: PRIVATE: REGwren NUMERIC "1"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: USE_DIFF_CLKEN NUMERIC "0"
-- Retrieval info: PRIVATE: UseDPRAM NUMERIC "1"
-- Retrieval info: PRIVATE: VarWidth NUMERIC "0"
-- Retrieval info: PRIVATE: WIDTH_READ_A NUMERIC "32"
-- Retrieval info: PRIVATE: WIDTH_READ_B NUMERIC "32"
-- Retrieval info: PRIVATE: WIDTH_WRITE_A NUMERIC "32"
-- Retrieval info: PRIVATE: WIDTH_WRITE_B NUMERIC "32"
-- Retrieval info: PRIVATE: WRADDR_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: WRADDR_REG_B NUMERIC "1"
-- Retrieval info: PRIVATE: WRCTRL_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: enable NUMERIC "0"
-- Retrieval info: PRIVATE: rden NUMERIC "1"
-- Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
-- Retrieval info: CONSTANT: ADDRESS_REG_B STRING "CLOCK0"
-- Retrieval info: CONSTANT: BYTE_SIZE NUMERIC "8"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_A STRING "BYPASS"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_B STRING "BYPASS"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_A STRING "BYPASS"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_B STRING "BYPASS"
-- Retrieval info: CONSTANT: INDATA_REG_B STRING "CLOCK0"
-- Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "MAX 10"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
-- Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "32"
-- Retrieval info: CONSTANT: NUMWORDS_B NUMERIC "32"
-- Retrieval info: CONSTANT: OPERATION_MODE STRING "BIDIR_DUAL_PORT"
-- Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "NONE"
-- Retrieval info: CONSTANT: OUTDATA_ACLR_B STRING "NONE"
-- Retrieval info: CONSTANT: OUTDATA_REG_A STRING "CLOCK0"
-- Retrieval info: CONSTANT: OUTDATA_REG_B STRING "CLOCK0"
-- Retrieval info: CONSTANT: POWER_UP_UNINITIALIZED STRING "FALSE"
-- Retrieval info: CONSTANT: RAM_BLOCK_TYPE STRING "M9K"
-- Retrieval info: CONSTANT: READ_DURING_WRITE_MODE_MIXED_PORTS STRING "DONT_CARE"
-- Retrieval info: CONSTANT: READ_DURING_WRITE_MODE_PORT_A STRING "NEW_DATA_WITH_NBE_READ"
-- Retrieval info: CONSTANT: READ_DURING_WRITE_MODE_PORT_B STRING "NEW_DATA_WITH_NBE_READ"
-- Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "5"
-- Retrieval info: CONSTANT: WIDTHAD_B NUMERIC "5"
-- Retrieval info: CONSTANT: WIDTH_A NUMERIC "32"
-- Retrieval info: CONSTANT: WIDTH_B NUMERIC "32"
-- Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "4"
-- Retrieval info: CONSTANT: WIDTH_BYTEENA_B NUMERIC "1"
-- Retrieval info: CONSTANT: WRCONTROL_WRADDRESS_REG_B STRING "CLOCK0"
-- Retrieval info: USED_PORT: address_a 0 0 5 0 INPUT NODEFVAL "address_a[4..0]"
-- Retrieval info: USED_PORT: address_b 0 0 5 0 INPUT NODEFVAL "address_b[4..0]"
-- Retrieval info: USED_PORT: byteena_a 0 0 4 0 INPUT VCC "byteena_a[3..0]"
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT VCC "clock"
-- Retrieval info: USED_PORT: data_a 0 0 32 0 INPUT NODEFVAL "data_a[31..0]"
-- Retrieval info: USED_PORT: data_b 0 0 32 0 INPUT NODEFVAL "data_b[31..0]"
-- Retrieval info: USED_PORT: q_a 0 0 32 0 OUTPUT NODEFVAL "q_a[31..0]"
-- Retrieval info: USED_PORT: q_b 0 0 32 0 OUTPUT NODEFVAL "q_b[31..0]"
-- Retrieval info: USED_PORT: rden_a 0 0 0 0 INPUT VCC "rden_a"
-- Retrieval info: USED_PORT: rden_b 0 0 0 0 INPUT VCC "rden_b"
-- Retrieval info: USED_PORT: wren_a 0 0 0 0 INPUT GND "wren_a"
-- Retrieval info: USED_PORT: wren_b 0 0 0 0 INPUT GND "wren_b"
-- Retrieval info: CONNECT: @address_a 0 0 5 0 address_a 0 0 5 0
-- Retrieval info: CONNECT: @address_b 0 0 5 0 address_b 0 0 5 0
-- Retrieval info: CONNECT: @byteena_a 0 0 4 0 byteena_a 0 0 4 0
-- Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
-- Retrieval info: CONNECT: @data_a 0 0 32 0 data_a 0 0 32 0
-- Retrieval info: CONNECT: @data_b 0 0 32 0 data_b 0 0 32 0
-- Retrieval info: CONNECT: @rden_a 0 0 0 0 rden_a 0 0 0 0
-- Retrieval info: CONNECT: @rden_b 0 0 0 0 rden_b 0 0 0 0
-- Retrieval info: CONNECT: @wren_a 0 0 0 0 wren_a 0 0 0 0
-- Retrieval info: CONNECT: @wren_b 0 0 0 0 wren_b 0 0 0 0
-- Retrieval info: CONNECT: q_a 0 0 32 0 @q_a 0 0 32 0
-- Retrieval info: CONNECT: q_b 0 0 32 0 @q_b 0 0 32 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL VRAM.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL VRAM.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL VRAM.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL VRAM.bsf FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL VRAM_inst.vhd FALSE
-- Retrieval info: LIB_FILE: altera_mf
