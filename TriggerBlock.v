module TriggerBlock (
	dataIn,
	triggerMask,
	clk,
	reset,
	triggerOut,
	dataOut
	);
	

	input [2:0] dataIn;
	input [2:0] triggerMask;
	input reset;
	input clk;
	output triggerOut;
	output [2:0] dataOut;
	

	wire [2:0] dataIn;
	wire [2:0] triggerMask;
	wire reset;
	wire clk;
	reg [2:0] dataOut;
	reg triggerOut;
	

	
	
	endmodule