`include "definitions.v"

`timescale 1ns/1ns

module ALU_tb ();
    
    reg [15:0] in1;
    reg [15:0] in2;
    reg [2:0] alu_op;
    reg clk;
    
    wire [15:0] alu_out;
    wire z;
    
    initial begin
        clk    = 1'b0;
        in1    = 15'b0;
        in2    = 15'b0;
        alu_op = 3'd0;
    end
    
    always #(`CLOCK) clk = ~clk;
    
    initial begin
        @(posedge clk)
        alu_op <= 3'd1;
        in1    <= 15'd10;
        in2    <= 15'd20;

        
        @(posedge clk)
        alu_op <= 3'd2;
        in1    <= 15'd25;
        in2    <= 15'd21;
        
        
        @(posedge clk)
        alu_op <= 3'd3;
        in1    <= 15'd3;
        in2    <= 15'd25;
        
    
    end
    
    ALU ALU (
    .i_clk(clk),
    .i_in1(in1),
    .i_in2(in2),
    .i_alu_op(alu_op),
    .o_alu_out(alu_out),
    .o_z(z)
    );
    
endmodule
