`timescale 1ns / 100ps


module LogicAnalyzer_tb();

//inputs
reg inclk0_10MHz_sig;
reg [2:0] dataIn_sig;
reg rst_sig;

//outputs
wire TxD_sig;
wire [4:0] state_debug_sig;
wire [7:0] dataOut_debug_sig;
wire clk_div16_debug_sig;
wire pll_output_debug_sig;

// Unit under test instance (UUT)
LogicAnalyzer LogicAnalyzer_inst
(
	.inclk0_10MHz(inclk0_10MHz_sig) ,	// input  inclk0_10MHz_sig
	.rst(rst_sig) ,	// input  rst_sig
	.dataIn(dataIn_sig) ,	// input [2:0] dataIn_sig
	.TxD(TxD_sig) ,	// output  TxD_sig
	.pll_output_debug(pll_output_debug_sig) ,	// output  pll_output_debug_sig
	.clk_div16_debug(clk_div16_debug_sig) ,	// output  clk_div16_debug_sig
	.dataOut_debug(dataOut_debug_sig) ,	// output [7:0] dataOut_debug_sig
	.state_debug(state_debug_sig) 	// output [4:0] state_debug_sig
);



//clk generation

always #50 inclk0_10MHz_sig = ~inclk0_10MHz_sig;  //Clock period = 100ns, thus f = 10MHz

initial
begin
	rst_sig = 1;
	dataIn_sig = 3'b000;
	inclk0_10MHz_sig = 1;
	#500
	rst_sig=0;
	#150
	dataIn_sig = 3'b001;
	#150
	dataIn_sig = 3'b010;
	#150
	dataIn_sig = 3'b011;
	#150
	dataIn_sig = 3'b100;
	#150
	dataIn_sig = 3'b101;
	#150
	dataIn_sig = 3'b110;
	#100000 ;
	dataIn_sig = 3'b001;
	#150
	dataIn_sig = 3'b010;
	#150
	dataIn_sig = 3'b011;
	#150
	dataIn_sig = 3'b100;
	#150
	dataIn_sig = 3'b101;
	#150
	dataIn_sig = 3'b110;
end	

endmodule

