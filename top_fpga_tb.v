`include "definitions.v"

`timescale 1ns/1ns

module top_fpga_tb ();
    
    reg clk;
    reg [1:0] status;
    wire end_process;
    
    initial begin
        clk    = 1'b0;
        status = 2'b01;
    end
    
    always #(`CLOCK) clk <= ~clk;
    
    always @(posedge clk) begin
        if (end_process) begin
            $stop;
        end
    end
    
    top_fpga top_fpga (
    .clk(clk),
    .status(status),
    .end_process(end_process)
    );
    
endmodule
