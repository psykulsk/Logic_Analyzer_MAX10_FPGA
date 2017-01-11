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
// CREATED		"Tue Jan 10 22:09:11 2017"

module LogicAnalyzer(
	inclk0_10MHz,
	rst,
	dataIn,
	TxD,
	state_debug
	
);


input wire	inclk0_10MHz;
input wire	rst;
input wire	[2:0] dataIn;
output wire	TxD;
output wire [4:0] state_debug;

wire	PLL_output;
wire	FIFO_rdreq;
wire	FIFO_wrreq;
wire	[2:0] FIFO_input_data;
wire	[2:0] PLL_data_out;
wire	[1:0] Bit_Padder_Sel;
wire	FIFO_wrfull;
wire	FIFO_rdempty;
wire	UART_txempty;
wire	triggerBlock_Syncrst;
wire	[2:0] triggerBlock_Mask;
wire	UART_rst;
wire	clk_div16;
wire	UART_ld_tx_data;
wire	UART_tx_enable;
wire	[7:0] UART_data_in;




FIFO_smaller	FIFO_smaller_inst(
	.rdclk(PLL_output),
	.rdreq(FIFO_rdreq),
	.wrclk(PLL_output),
	.wrreq(FIFO_wrreq),
	.data(FIFO_input_data),
	.rdempty(FIFO_rdempty),
	.wrfull(FIFO_wrfull),
	.q(PLL_data_out));


PLL_LogicAnalyzer	PLL_LogicAnalyzer_inst(
	.inclk0(inclk0_10MHz),
	.c0(PLL_output));


Bit_Padder	Bit_Padder_inst(
	.dataIn(PLL_data_out),
	.optionSel(Bit_Padder_Sel),
	.dataOut(UART_data_in));


FIFO_to_UART_Controller	FIFO_to_UART_Controller_inst(
	.rst(rst),
	.clk(PLL_output),
	.FIFO_wrfull(FIFO_wrfull),
	.FIFO_rdempty(FIFO_rdempty),
	.UART_txempty(UART_txempty),
	.FIFO_rdreq(FIFO_rdreq),
	.UART_rst(UART_rst),
	.UART_ld_tx_data(UART_ld_tx_data),
	.UART_tx_enable(UART_tx_enable),
	.triggerBlock_Syncrst(triggerBlock_Syncrst),
	.Bit_Padder_Sel(Bit_Padder_Sel),
	.state_debug(state_debug),
	.triggerBlock_Mask(triggerBlock_Mask));


	PLL_div16	PLL_div16_inst (
	.inclk0 ( PLL_output ),
	.c0 ( clk_div16 )
	);



TriggerBlock	TriggerBlock_inst(
	.clk_PLL(PLL_output),
	.reset(triggerBlock_Syncrst),
	.dataIn(dataIn),
	.triggerMask(triggerBlock_Mask),
	.triggerOut(FIFO_wrreq),
	.dataOut(FIFO_input_data));

uart uart_inst(
.reset(UART_rst)          ,
.txclk(clk_div16)          ,
.ld_tx_data(UART_ld_tx_data)     ,
.tx_data(UART_data_in)        ,
.tx_enable(UART_tx_enable)      ,
.tx_out(TxD)         ,
.tx_empty(UART_txempty)       ,
.rxclk()          ,
.uld_rx_data()    ,
.rx_data()        ,
.rx_enable()      ,
.rx_in()          ,
.rx_empty()
);

endmodule
