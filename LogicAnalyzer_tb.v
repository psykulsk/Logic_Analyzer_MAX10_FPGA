module LogicAnalyzer_tb();

//inputs
reg inclk0_10MHz_sig;
reg [2:0] dataIn_sig;
reg rst_sig;

//outputs
wire TxD_sig;
wire [4:0] state_debug_sig;
wire [7:0] dataOut_debug_sig;

// Unit under test instance (UUT)
LogicAnalyzer LogicAnalyzer_inst
(
	.inclk0_10MHz(inclk0_10MHz_sig) ,	// input  inclk0_10MHz_sig
	.dataIn(dataIn_sig) ,	// input [2:0] dataIn_sig
	.rst(rst_sig) ,	// input  rst_sig
	.TxD(TxD_sig) ,	// output  TxD_sig
	.state_debug(state_debug_sig) ,	// output [4:0] state_debug_sig
	.dataOut_debug(dataOut_debug_sig) 	// output [7:0] dataOut_debug_sig
);



//clk generation

always #50 inclk0_10MHz_sig = ~inclk0_10MHz_sig;  //Clock period = 100ns, thus f = 10MHz

initial
begin
	rst_sig = 1;
	dataIn_sig = 3'b000;
	inclk0_10MHz_sig = 1;
	#10
	rst_sig=0;
	#150
	dataIn_sig = 3'b010;
	#150
	dataIn_sig = 3'b001;
	#150
	dataIn_sig = 3'b001;
	#150
	dataIn_sig = 3'b010;
	#150
	dataIn_sig = 3'b010;
	#150
	dataIn_sig = 3'b010;
	#1000 ;
end	

endmodule

