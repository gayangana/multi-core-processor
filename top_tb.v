`timescale 1ns/1ns

module top_tb();

    reg clk;
    reg [1:0]status;
    reg [15:0]com_data_in;
    reg [15:0]com_addr;
    reg com_wr_en;
    wire end_p;


    integer data_file;
    integer scan_file;


    initial begin
        clk = 1'b0;
        status = 2'b00;
        //com_data_in = 16'b0;
        com_addr = 16'd65535;
        com_wr_en = 1'b1;
        data_file =$fopen("memory.txt","r");  
    end

    always #(5) clk <= ~clk;   


		
    always @(posedge clk) begin
        scan_file = $fscanf(data_file, "%d\n", com_data_in); 
        if (!$feof(data_file)) begin 
			com_addr <= com_addr + 1'b1;
		end
		else begin
			com_addr <= com_addr +1'b1;
            status <= 2'b01;	 
			com_wr_en <= 1'b0 ;
        end
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