`timescale 1ns / 1ps


module FIFO_to_UART_Controller_tb;

	// Inputs
	reg rst;
	reg clk;
	reg FIFO_wrfull;
	reg FIFO_rdempty;
	reg UART_txempty;

	// Outputs
	wire FIFO_rdreq;
	wire UART_rst;
	wire UART_ld_tx_data;
	wire UART_tx_enable;
	wire triggerBlock_Syncrst;
	wire [2:0] triggerBlock_Mask;
	wire [1:0] Bit_Padder_Sel;
	wire [4:0] state_debug;
  
// Instantiate the Unit Under Test (UUT)
FIFO_to_UART_Controller uut( 
.rst(rst),
.clk(clk),
.FIFO_wrfull(FIFO_wrfull),
.FIFO_rdempty(FIFO_rdempty),
.UART_txempty(UART_txempty),

.FIFO_rdreq(FIFO_rdreq),
.UART_rst(UART_rst),
.UART_ld_tx_data(UART_ld_tx_data),
.UART_tx_enable(UART_tx_enable),

.triggerBlock_Syncrst(triggerBlock_Syncrst),
.triggerBlock_Mask(triggerBlock_Mask),
.Bit_Padder_Sel(Bit_Padder_Sel),
.state_debug(state_debug)
);

  //clk generation
  initial clk=0;
  always #50 clk = ~clk;  //Clock period = 100ns, thus f = 10MHz

initial begin
	// Initialize Inputs
	rst = 1;
	clk = 1;
	FIFO_wrfull = 0;
	FIFO_rdempty = 0;
	UART_txempty = 1;
	#150
	rst = 0;
	#100
	FIFO_wrfull = 1;
	
	wait(UART_ld_tx_data)
	UART_txempty = 0;
	
	#1200
	UART_txempty = 1;
	wait(UART_ld_tx_data)
	UART_txempty = 0;
	#1200
	FIFO_wrfull = 0;
	UART_txempty = 1;
	wait(UART_ld_tx_data)
	UART_txempty = 0;
	#600;
	FIFO_rdempty = 1;
	#600;
	UART_txempty = 1;
	#1200
	
    $stop;

end
      
endmodule