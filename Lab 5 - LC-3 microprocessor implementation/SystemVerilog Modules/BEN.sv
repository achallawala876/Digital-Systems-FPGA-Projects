// REDO THIS PLEASE

module BEN(
	input logic LD_CC, LD_BEN, Clk, Reset,
	input logic [2:0] IR,
    input logic [15:0] bus_in,
	output logic Dout
);

    logic n, z, p, n_output, z_output, p_output, logic_output;

    always_ff @ (posedge Clk) 
	 begin
            if(Reset)
                Dout <= 1'b0;
            else if(LD_BEN)
                Dout <= (IR[2] && n_output || IR[1] && z_output || IR[0] && p_output);

            if(LD_CC) 
				begin
             n_output <= n;
			    z_output <= z;
			    p_output <= p;
				end
    end

    always_comb begin
		if(bus_in == 16'h0000) begin
			n = 1'b0;
			z = 1'b1;
			p = 1'b0;
		end 
		else if(bus_in[15] == 1'b1) begin
			n = 1'b1;
			z = 1'b0;
			p = 1'b0;
		end 
		else if(bus_in[15] == 1'b0 && bus_in != 16'h0000) begin
			n = 1'b0;
			z = 1'b0;
			p = 1'b1;
		end 
		else begin
			n = 1'bZ;
			z = 1'bZ;
			p = 1'bZ;
		end 
	end 
endmodule