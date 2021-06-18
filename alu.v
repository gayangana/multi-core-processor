module ALU( 
    input i_clk,
    input [15:0] i_in1,
    input [15:0] i_in2,
    input [1:0] i_alu_op,
    output reg [15:0] o_alu_out,
    output reg o_z 
	);

    always @(posedge i_clk)begin
        case(i_alu_op)
            2'd1: o_alu_out <= i_in1 + i_in2;
            2'd2: o_alu_out <= i_in2 - i_in1;
            2'd3: o_alu_out <= i_in1 * i_in2;
        endcase

    	if (o_alu_out==0)
        	o_z <= 1;
    	else
        	o_z <= 0;
    	end

endmodule