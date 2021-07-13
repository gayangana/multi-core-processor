module ALU (input i_clk,
           input [15:0] i_in1,
           input [15:0] i_in2,
           input [2:0] i_alu_op,
           output reg [15:0] o_alu_out,
           output reg o_z);
    
    always @(posedge i_clk) begin
        case (i_alu_op)
            3'd1: o_alu_out <= i_in1 + i_in2;
            3'd2: begin
                if (i_in2 > i_in1)
                    o_alu_out <= i_in2 - i_in1;
                else
                    o_alu_out <= 16'b0;
            end
            
            3'd3: o_alu_out <= i_in1 * i_in2;
            3'd4: o_alu_out <= i_in2 / i_in1;
            3'd5: o_alu_out <= i_in2 % i_in1;
        endcase
        
        if (o_alu_out == 0)
            o_z <= 1;
        else
            o_z <= 0;
    end
    
endmodule
