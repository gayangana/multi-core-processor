`include "definitions.v"

`timescale 1ns/1ns

module ALU_tb ();
    
    reg [15:0] in1;
    reg [15:0] in2;
    reg [2:0] alu_op;

    wire [15:0] alu_out;
    wire z;
    
    initial begin
        alu_op = 3'd0;
        in1    = 15'b0;
        in2    = 15'b0;
    end
    
    initial begin
        #20
        alu_op <= 3'd1;
        in1    <= 15'd5;
        in2    <= 15'd20;

        #20
        alu_op <= 3'd2;
        in1    <= 15'd5;
        in2    <= 15'd20;
                
        #20
        alu_op <= 3'd3;
        in1    <= 15'd3;
        in2    <= 15'd20;

        #20
        alu_op <= 3'd4;
        in1    <= 15'd5;
        in2    <= 15'd20;

        #20
        alu_op <= 3'd5;
        in1    <= 15'd3;
        in2    <= 15'd20;

        #20
        alu_op = 3'd0;
    end
    
    ALU ALU (
    .in1(in1),
    .in2(in2),
    .alu_op(alu_op),
    .alu_out(alu_out),
    .z(z)
    );
    
endmodule
