// Copyright (C) 2016  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Intel and sold by Intel or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 16.1.0 Build 196 10/24/2016 SJ Lite Edition"
// CREATED		"Fri May 19 13:28:31 2017"

module LogicAnalyzer(
	inclk0_10MHz,
	rst,
	dataIn,
	TxD,
	pll_output_debug,
	clk_div16_debug,
	dataOut_debug,
	state_debug
);


input wire	inclk0_10MHz;
input wire	rst;
input wire	[2:0] dataIn;
output wire	TxD;
output wire	pll_output_debug;
output wire	clk_div16_debug;
output wire	[7:0] dataOut_debug;
output wire	[4:0] state_debug;

wire	SYNTHESIZED_WIRE_20;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_3;
wire	[2:0] SYNTHESIZED_WIRE_4;
wire	[2:0] SYNTHESIZED_WIRE_5;
wire	[1:0] SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_12;
wire	[2:0] SYNTHESIZED_WIRE_13;
wire	SYNTHESIZED_WIRE_14;
wire	SYNTHESIZED_WIRE_15;
wire	SYNTHESIZED_WIRE_16;
wire	SYNTHESIZED_WIRE_17;
wire	[7:0] SYNTHESIZED_WIRE_19;

assign	pll_output_debug = SYNTHESIZED_WIRE_20;
assign	clk_div16_debug = SYNTHESIZED_WIRE_15;
assign	dataOut_debug = SYNTHESIZED_WIRE_19;




FIFO_smaller	b2v_inst(
	.rdclk(SYNTHESIZED_WIRE_20),
	.rdreq(SYNTHESIZED_WIRE_1),
	.wrclk(SYNTHESIZED_WIRE_20),
	.wrreq(SYNTHESIZED_WIRE_3),
	.data(SYNTHESIZED_WIRE_4),
	.rdempty(SYNTHESIZED_WIRE_9),
	.wrfull(SYNTHESIZED_WIRE_8),
	.q(SYNTHESIZED_WIRE_5));


PLL_LogicAnalyzer	b2v_inst1(
	.inclk0(inclk0_10MHz),
	.c0(SYNTHESIZED_WIRE_20),
	.c1(SYNTHESIZED_WIRE_15));


Bit_Padder	b2v_inst2(
	.dataIn(SYNTHESIZED_WIRE_5),
	.optionSel(SYNTHESIZED_WIRE_6),
	.dataOut(SYNTHESIZED_WIRE_19));


FIFO_to_UART_Controller	b2v_inst3(
	.rst(rst),
	.clk(SYNTHESIZED_WIRE_20),
	.FIFO_wrfull(SYNTHESIZED_WIRE_8),
	.FIFO_rdempty(SYNTHESIZED_WIRE_9),
	.UART_txempty(SYNTHESIZED_WIRE_10),
	.FIFO_rdreq(SYNTHESIZED_WIRE_1),
	.UART_rst(SYNTHESIZED_WIRE_14),
	.UART_ld_tx_data(SYNTHESIZED_WIRE_16),
	.UART_tx_enable(SYNTHESIZED_WIRE_17),
	.triggerBlock_Syncrst(SYNTHESIZED_WIRE_12),
	.Bit_Padder_Sel(SYNTHESIZED_WIRE_6),
	.state_debug(state_debug),
	.triggerBlock_Mask(SYNTHESIZED_WIRE_13));


TriggerBlock	b2v_TriggerBlock_inst(
	.clk_PLL(SYNTHESIZED_WIRE_20),
	.reset(SYNTHESIZED_WIRE_12),
	.dataIn(dataIn),
	.triggerMask(SYNTHESIZED_WIRE_13),
	.triggerOut(SYNTHESIZED_WIRE_3),
	.dataOut(SYNTHESIZED_WIRE_4));


uart	b2v_uart_inst(
	.reset(SYNTHESIZED_WIRE_14),
	.txclk(SYNTHESIZED_WIRE_15),
	.ld_tx_data(SYNTHESIZED_WIRE_16),
	.tx_enable(SYNTHESIZED_WIRE_17),
	.rxclk(SYNTHESIZED_WIRE_20),
	
	
	
	.tx_data(SYNTHESIZED_WIRE_19),
	.tx_out(TxD),
	.tx_empty(SYNTHESIZED_WIRE_10)
	
	);


endmodule
