module TriggerBlock (
	dataIn,
	triggerMask,
	clk_PLL,
	reset,
	triggerOut,
	dataOut
	);
	

	input [2:0] dataIn;
	input [2:0] triggerMask;
	input reset;
	input clk_PLL;
	output triggerOut;
	output [2:0] dataOut;
	

	wire [2:0] dataIn;
	wire [2:0] triggerMask;
	wire reset;
	wire clk_PLL;
	wire [2:0] dataOut;
	reg triggerOut;
	
		
	reg [2:0] newDataReg;
	reg [2:0] prevDataReg;
	reg [2:0] differenceReg;
	reg [2:0] triggerMaskReg;
	
	
	assign dataOut = newDataReg;
	
	always @( posedge clk_PLL )
	begin
		if ( triggerOut == 1'b0)
			begin
				prevDataReg = newDataReg;
				newDataReg = dataIn;
				differenceReg = prevDataReg^newDataReg;
				triggerOut = |(differenceReg&triggerMask);
			end
		else
			begin
				newDataReg = dataIn;
			end
		
		if( reset == 1'b1 )
			begin
				triggerOut = 1'b0;
			end
		
	end
	


	
	always @(triggerMask)
	begin
		triggerMaskReg <= triggerMask;
	end
	
	endmodule