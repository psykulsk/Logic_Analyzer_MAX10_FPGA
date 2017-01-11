module CLK_Div_16(
	clk_in,
	reset,
	clk_div16
	);
	
input wire clk_in;
input wire reset;
output reg clk_div16;

reg [3:0] counter;

always @(posedge clk_in or posedge reset)
begin
	if(reset == 1'b1)
		counter = 3'b0;
	counter = counter + 3'b1;
	clk_div16 = counter[3];
end

endmodule
