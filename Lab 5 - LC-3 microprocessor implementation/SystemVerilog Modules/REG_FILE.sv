module REGISTER_FILE (input logic [15:0] input_fromBUS, 
							 input logic [2:0] DR_info, SR2_info, SR1_info,
							 input logic reset_registerfile, Clk, load_registerfile, // do we need this?
							 output logic [15:0] SR1OUT, SR2OUT);
							 

logic [15:0] register [7:0]; // making a 2D array of registers from R0 till R8

always_ff @(posedge Clk) begin

	if (reset_registerfile) begin
		for (int i = 0; i < 8; i=i+1) begin
		register[i] <= 16'h0000;
		end
	end
	
	else if (load_registerfile)
		register[DR_info] <= input_fromBUS;
	
end 

// don't need an else statement in always_ff since always_ff can INFER A LATCH (previous values are preserved if nothing happens)

always_comb begin 
	SR1OUT = register[SR1_info];
	SR2OUT = register[SR2_info];	
end
endmodule



//// our prior implementation before TA recommendations
//							 
//always_comb begin 
//
//if (load_registerfile) begin
//
//	case(DR_info)
//	
//	
//	
//	3'b111 : LDR7 = 1;
//	3'b000 : LDR0 = 1;
//	3'b001 : LDR1 = 1;
//	3'b010 : LDR2 = 1;
//	3'b011 : LDR3 = 1;
//	3'b100 : LDR4 = 1;
//	3'b101 : LDR5 = 1;
//	3'b110 : LDR6 = 1;
//	3'b111 : LDR7 = 1;	
//	
//	LDR0 = 0;
//	LDR1 = 0;
//	LDR2 = 0;
//	LDR3 = 0;
//	LDR4 = 0;
//	LDR5 = 0;
//	LDR6 = 0;
//	LDR7 = 0;
//	
//	endcase 
//	
//	end 
//
//if (reset_registerfile) begin
//	
//	LDR0 = 0;
//	LDR1 = 0;
//	LDR2 = 0;
//	LDR3 = 0;
//	LDR4 = 0;
//	LDR5 = 0;
//	LDR6 = 0;
//	LDR7 = 0;
//	
//end
//
//
//	case(SR1MUX_info)
//	
//	3'b000 : SR1OUT = internalreg_output [0]
//	3'b001 : SR1OUT = internalreg_output [1];
//	3'b010 : SR1OUT = internalreg_output [2];
//	3'b011 : SR1OUT = internalreg_output [3];
//	3'b100 : SR1OUT = internalreg_output [4];
//	3'b101 : SR1OUT = internalreg_output [5];
//	3'b110 : SR1OUT = internalreg_output [6];
//	3'b111 : SR1OUT = internalreg_output [7];
//	default: SR1OUT = 16'hxxxx;
//	
//	endcase
//	
//	
//	case(SR2_info)
//	
//	3'b000 : SR2OUT = internalreg_output [0]
//	3'b001 : SR2OUT = internalreg_output [1];
//	3'b010 : SR2OUT = internalreg_output [2];
//	3'b011 : SR2OUT = internalreg_output [3];
//	3'b100 : SR2OUT = internalreg_output [4];
//	3'b101 : SR2OUT = internalreg_output [5];
//	3'b110 : SR2OUT = internalreg_output [6];
//	3'b111 : SR2OUT = internalreg_output [7];
//	default: SR2OUT = 16'hxxxx;
//	
//	endcase
//	
//
//end
//	
//	
//REGISTER R0(.Clk(Clk), .Reset(reset_registerfile), .Load(LDR0), .D(input_fromBUS), .Data_Out(internalreg_output[0]));
//REGISTER R0(.Clk(Clk), .Reset(reset_registerfile), .Load(LDR1), .D(input_fromBUS), .Data_Out(internalreg_output[1]));
//REGISTER R0(.Clk(Clk), .Reset(reset_registerfile), .Load(LDR2), .D(input_fromBUS), .Data_Out(internalreg_output[2]));
//REGISTER R0(.Clk(Clk), .Reset(reset_registerfile), .Load(LDR3), .D(input_fromBUS), .Data_Out(internalreg_output[3]));
//REGISTER R0(.Clk(Clk), .Reset(reset_registerfile), .Load(LDR4), .D(input_fromBUS), .Data_Out(internalreg_output[4]));
//REGISTER R0(.Clk(Clk), .Reset(reset_registerfile), .Load(LDR5), .D(input_fromBUS), .Data_Out(internalreg_output[5]));
//REGISTER R0(.Clk(Clk), .Reset(reset_registerfile), .Load(LDR6), .D(input_fromBUS), .Data_Out(internalreg_output[6]));
//REGISTER R0(.Clk(Clk), .Reset(reset_registerfile), .Load(LDR7), .D(input_fromBUS), .Data_Out(internalreg_output[7]));

	
							 
