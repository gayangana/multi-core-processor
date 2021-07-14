module ALU (input [15:0] in1,
            input [15:0] in2,
            input [2:0] alu_op,
            output reg [15:0] alu_out,
            output reg z);

    always @(*) begin
        case (alu_op)
            3'd1: alu_out <= in2 + in1;
            3'd2: alu_out <= in2 - in1;
            3'd3: alu_out <= in2 * in1;
            3'd4: alu_out <= in2 / in1;
            3'd5: alu_out <= in2 % in1;
        endcase
        
        if (alu_out[15] == 1'b1)
            z <= 1;
        else if (alu_out == 16'd0)
            z <= 1;
        else
            z <= 0;
    end

endmodule
