`timescale 1ns/1ns

module top_tb();
    
    reg clk = 1'b0; 
    reg [1:0]status;
    wire end_p;


    always #(5) clk <= ~clk;   

    initial begin
        @(posedge clk)
        status <= 2'b00;

        @(posedge clk)
        status <= 2'b01;
    end
		
	processor p1(
	.clk(clk),
	.end_process(end_p),
    .status(status)
	);

endmodule