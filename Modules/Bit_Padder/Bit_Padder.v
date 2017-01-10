module Bit_Padder(
dataIn,
optionSel,
dataOut
);
	
input [2:0] dataIn;
input [1:0] optionSel;
output reg [7:0]dataOut;

always @(dataIn or optionSel)
	begin
		if(optionSel == 2'b00)
			begin
				dataOut[7:3] = 4'b0000;
				dataOut[2:0] = dataIn;
			end
		else if(optionSel == 2'b01)
			dataOut = 8'hA;
		else
			begin
				dataOut[7:3] = 4'b0000;
				dataOut[2:0] = dataIn;
			end
	end

endmodule
