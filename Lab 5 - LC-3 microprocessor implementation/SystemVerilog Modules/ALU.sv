module ALU (input logic [1:0] ALUcontrolpins,
				input logic [15:0] A, B,
				output logic [15:0] ALU_output);
				

always_comb begin
	case (ALUcontrolpins)
	2'b00 : ALU_output = A + B;
	2'b01 : ALU_output = A & B;
	2'b10 : ALU_output = ~ A;
	2'b11 : ALU_output = A;
	default : ALU_output = 16'hxxxx;
	
	endcase
end

endmodule