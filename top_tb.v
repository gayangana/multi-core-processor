`timescale 1ns/1ns

module top_tb();

    reg clk;
    reg [1:0]status;
    reg [15:0]com_data_in;
    reg [15:0]com_addr;
    reg com_wr_en;
    wire end_p;
    wire [15:0]com_data_out;


    integer data_file;
    integer scan_file;
    integer out_file;


    initial begin
        clk = 1'b0;
        status = 2'b00;
        //com_data_in = 16'b0;
        com_addr = 16'd65535;
        com_wr_en = 1'b1;
        data_file =$fopen("memory.txt","r");  
        out_file = $fopen("src/out.txt","w"); 
    end

    always #(5) clk <= ~clk;   

    always @(posedge clk) begin
        if (end_p==1'b1)
            status <= 2'b10;
            com_addr <= 16'd0;
    end
		
    always @(posedge clk) begin
        case (status)
            2'b00:begin
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

            2'b10: begin
                com_addr <= com_addr +1'b1;
                $fwrite(out_file,"%d\n",com_data_out);
            end
        endcase
    end
		
	top top1(	  
	
	.clk(clk),
    .status(status),
    .com_data_in(com_data_in),
    .com_addr(com_addr),
    .com_wr_en(com_wr_en),
	.end_process(end_p),
    .com_data_out(com_data_out)
    
	);

endmodule