module FIFO_to_UART_Controller(
	rst,
	clk,
	FIFO_wrfull,
	FIFO_rdempty,
	UART_txempty,
	
	FIFO_rdreq,
	UART_rst,
	UART_ld_tx_data,
	UART_tx_enable,
	
	triggerBlock_Syncrst,
	triggerBlock_Mask,
	
	Bit_Padder_Sel,
	
	state_debug
);
//Opis wejść/wyjść
input wire rst;
input wire clk;			//Clock of the system
input wire FIFO_wrfull;		//write-full flag from FIFO
input wire FIFO_rdempty;		//read-empty flag.
input wire UART_txempty;		//TxD-empty flag. Set when UART 8-bit data buffer is empty

output reg FIFO_rdreq;
output reg UART_rst;
output reg UART_tx_enable;	//enables tx_tansmission.
output reg UART_ld_tx_data;

output reg triggerBlock_Syncrst;	//Triger Block has to be rst after each full read from FIFO
output wire [2:0]triggerBlock_Mask;			//Masks which inputs trigger the TriggerBlock

output reg [1:0] Bit_Padder_Sel; //Used to select what type of data is pushed into UART
											// 00 => Pipe (pads 3 bit sream with 5 zero bits)
											// 01 => 0x0A (new line ASCII symbol)
											// 10 => Pipe
											// 11 => Pipe  
											
output wire [4:0] state_debug;

//Lokalne stałe
localparam [4:0] INITIAL				= 5'b00000;
localparam [4:0] IDLE 					= 5'b00001;
localparam [4:0] SET_READ_REQUEST 		= 5'b00010;
localparam [4:0] WAIT_TX_EMPTY 			= 5'b00100;
localparam [4:0] LOAD_DATA_TO_UART 		= 5'b01000;
localparam [4:0] FINALIZE_DATA_CYCLE 	= 5'b10000;
localparam [4:0] SEND_NEW_LINE_CHAR 	= 5'b10001;
localparam [4:0] WAIT_FOR_NEW_LINE_CHAR_SEND 	= 5'b10010;

//Lokalne zmienne
reg counter;	
reg [4:0] state;
reg [4:0] next_state;

assign state_debug = state;
	
//Przypisanie nowego stanu co takt zegara
always @ (posedge clk)	begin
		if(rst)
			state <= INITIAL;
		else
			state <= next_state;				
end

assign triggerBlock_Mask = 3'b111;
	
//Logika obliczania następnego stanu
always @ * begin
	FIFO_rdreq = 1'b0;
	UART_ld_tx_data= 1'b0;
	UART_rst = 1'b0;
	UART_tx_enable = 1'b1;
	triggerBlock_Syncrst = 1'b1; // Trigger is disabled by default, except for the IDLE state
	Bit_Padder_Sel = 2'b00;
	
	case(state)
	INITIAL:	begin
					triggerBlock_Syncrst = 1;
					UART_rst = 1;	
					next_state = IDLE;
				end
	IDLE:	begin 
				triggerBlock_Syncrst = 1'b0;     // Enable trigger so the FIFO can fill up
				if(FIFO_wrfull)
					next_state = SET_READ_REQUEST;
				else
					next_state = state;
			end
	
	SET_READ_REQUEST:	begin
								FIFO_rdreq = 1'b1;
								next_state = WAIT_TX_EMPTY;
							end
	WAIT_TX_EMPTY:	begin
							if(UART_txempty)
								next_state = LOAD_DATA_TO_UART;
							else
								next_state = state;
						end
	LOAD_DATA_TO_UART:	begin
									UART_ld_tx_data = 1'b1;	
									if(UART_txempty)
										next_state = state;
									else
										next_state = FINALIZE_DATA_CYCLE;										
								end
	FINALIZE_DATA_CYCLE: begin
                          UART_ld_tx_data = 1'b0;
                          if(FIFO_rdempty) //FIFO is empty go back to IDLE when transmission is over
                            begin
                              if(UART_txempty) begin
                                next_state = SEND_NEW_LINE_CHAR;
                                end
                              else
                                next_state = state;
                            end
                          else
                            begin
                              if(UART_txempty)
                                next_state = SET_READ_REQUEST;
                              else
                                next_state = state;
                            end
                      	end
  SEND_NEW_LINE_CHAR: begin
                        Bit_Padder_Sel = 2'b01;
                        UART_ld_tx_data = 1'b1;	
                        if(UART_txempty) begin
                          next_state = state;
                        end
                        else begin
                          UART_ld_tx_data = 1'b0;	
                          next_state = WAIT_FOR_NEW_LINE_CHAR_SEND;
                        end
                      end
  WAIT_FOR_NEW_LINE_CHAR_SEND: begin
    															Bit_Padder_Sel = 2'b01;
                                  if(UART_txempty)
                                    next_state = IDLE;
                                  else
                                    next_state = state;
  														 end
	default: next_state = state; // stay in current state - when hung it means reached default.
endcase

end
  
////Logika wyjść
//always @ (state)
//begin
////Domyślne wartości
//FIFO_rdreq = 1'b0;
//UART_ld_tx_data= 1'b0;
//UART_rst = 1'b0;
//UART_tx_enable = 1'b1;
//triggerBlock_Syncrst = 1'b0;
//Bit_Padder_Sel = 2'b00;
//	case(state)
//		INITIAL: begin
//						triggerBlock_Syncrst = 1;
//						UART_rst = 1;
//					end
//		IDLE:	 ;//nothing
//		SET_READ_REQUEST: FIFO_rdreq = 1'b1;
//		WAIT_TX_EMPTY: ;//nothing
//		LOAD_DATA_TO_UART:	UART_ld_tx_data = 1'b1;
//		FINALIZE_DATA_CYCLE: begin
//										UART_ld_tx_data = 1'b0;
//										triggerBlock_Syncrst = 1'b1;
//										Bit_Padder_Sel = 2'b01;
//									end
//		default: ;//stay in default state
//	endcase
//end
  
endmodule