module PCMUX (input logic [1:0] select_bits,
				  input logic [15:0] incremented_PC, BUS_input, ADDED_addr_input,
				  output logic [15:0] output_PCMUX);
				  

always_comb begin

if (select_bits == 2'b00)
	output_PCMUX = incremented_PC;


else if (select_bits == 2'b01) 
	output_PCMUX = BUS_input;
	

else if (select_bits == 2'b10) 
	output_PCMUX = ADDED_addr_input; // address adder
	
else
	output_PCMUX = 16'hxxxx;
	

end

endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////


module ADDR1MUX (input logic [15:0] input_PC, input_SR1,
					  input logic ADDR1MUXselect,
					  output logic [15:0] output_ADDR1MUX);
					  
always_comb begin
	case (ADDR1MUXselect)
	1'b0 : output_ADDR1MUX = input_PC;
	1'b1 : output_ADDR1MUX = input_SR1;
	default : output_ADDR1MUX = 16'hxxxx;
	endcase
end

endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////

module ADDR2MUX (input logic [15:0] input_IRSEXT6, input_IRSEXT9, input_IRSEXT11,
					  input logic [1:0] ADDR2MUXselect,
					  output logic [15:0] output_ADDR2MUX);

always_comb begin
	case (ADDR2MUXselect)
	2'b00 : output_ADDR2MUX = 16'h0000;
	2'b01 : output_ADDR2MUX = input_IRSEXT6;
	2'b10 : output_ADDR2MUX = input_IRSEXT9;
	2'b11 : output_ADDR2MUX = input_IRSEXT11;
	default : output_ADDR2MUX = 16'hxxxx;
	endcase
end

endmodule
					  
					  

///////////////////////////////////////////////////////////////////////////////////////////////////
// MDRMUX

module MIOMUX  (input logic [15:0] BUS_input, Data_CPU_In, 
				    input logic MIO_en,
				    output logic [15:0] output_MIOMUX);
				 

always_comb begin
				  
if (MIO_en == 1'b0) 
	output_MIOMUX = BUS_input;
	
	
else if (MIO_en == 1'b1) 
	output_MIOMUX = Data_CPU_In;
	
else
	output_MIOMUX = 16'hxxxx;
		
end 

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////

module DRMUX (input logic [2:0] input_IR11to9,
				  input logic DRMUXselect,
				  output logic [2:0] output_DRMUX);	  

always_comb begin
	case (DRMUXselect)
	1'b0 : output_DRMUX = input_IR11to9;
	1'b1 : output_DRMUX = 3'b111;
	default : output_DRMUX = 3'bxxx;
	endcase
end

endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

module SR1MUX (input logic [2:0] input_IR11to9, input_IR8to6,
				   input logic SR1MUXselect,
				   output logic [2:0] output_SR1MUX);	  

always_comb begin
	case (SR1MUXselect)
	1'b0 : output_SR1MUX = input_IR11to9;
	1'b1 : output_SR1MUX = input_IR8to6;
	default : output_SR1MUX = 3'bxxx;
	endcase
end

endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////

module SR2MUX (input logic [15:0] input_SR2, input_IRSEXT5,
					  input logic SR2MUXselect, // IR[5]
					  output logic [15:0] output_SR2MUX);
					  
always_comb begin
	case (SR2MUXselect)
	1'b0 : output_SR2MUX = input_SR2;
	1'b1 : output_SR2MUX = input_IRSEXT5;
	default : output_SR2MUX = 16'hxxxx;
	endcase
end

endmodule

