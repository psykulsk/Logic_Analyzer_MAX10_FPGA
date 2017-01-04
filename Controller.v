module Controller (
	uartMessage,
	clk_10MHz,
	fifoFull,
	fifoEmpty,
	triggerIn,
	triggerMask,
	triggerBlockReset,
	fifoClear,
	fifoWriteEnable,
	fifoReadEnable,
	uartWrite,
	uartRead
	);
	
	input [7:0] uartMessage; // We need to specify commands and their length
	input clk_10MHz;
	input fifoFull;
	input fifoEmpty;
	input triggerIn;
	
	output [2:0] triggerMask;
	output triggerBlockReset;
	output fifoClear;
	output fifoWriteEnable;
	output fifoReadEnable;
	output uartWrite;
	output uartRead;
	
endmodule