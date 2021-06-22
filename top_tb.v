`timescale 1ns/1ns

module top_tb();

    reg clk;
    reg [1:0]status;
    reg [15:0]com_data_in;
    reg [15:0]com_addr;
    reg com_wr_en;
    wire end_p;



    initial begin
        clk = 1'b0;
        status = 2'b01;
        com_data_in = 16'b0;
        com_addr = 16'b0;
        com_wr_en = 1'b0; 
    end

    always #(5) clk <= ~clk;   


    initial begin
        @(posedge clk)
        status <= 2'b01;
    end
		
	top top1(	  
	
	.clk(clk),
    .status(status),
    .com_data_in(com_data_in),
    .com_addr(com_addr),
    .com_wr_en(com_wr_en),
	.end_process(end_p)
    
	);

endmodule