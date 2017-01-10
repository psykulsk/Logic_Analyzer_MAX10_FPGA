module pulseGenerator(
	asyncIn,
	clk,
	pulseOut
	);
	
input asyncIn;
input clk;
output pulseOut;

wire asyncIn;
wire clk;
reg pulseOut;

reg state;
reg next_state;


always @(posedge clk or posedge asyncIn)
begin
	if( asyncIn == 1 )
		state <= 1;
	else
		state <=next_state;
end



always @(state )
begin

	if(state == 1)
		pulseOut <= 1;
	else
		pulseOut <= 0;
		
	next_state <= 0;

end

endmodule