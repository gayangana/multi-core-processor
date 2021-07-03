`timescale 1ns/1ns

module top_tb();
    
    reg clk;
    reg [15:0]com_data_in;
    reg data_write_start;
    reg data_write_done;
    reg [3:0]n_cores;
    
    wire [15:0]com_data_out;
    wire [1:0]state;
    wire output_write_done;
    wire output_write_start;
    
    
    integer data_file;
    integer scan_file;
    integer out_file;
    
    initial begin
        //4 cores 4'b1111
        //3 cores 4'b0111
        //2 cores 4'b0011
        //1 cores 4'b0001
        
        n_cores = 4'b1111;
        
        clk              = 1'b0;
        data_write_start = 1'b1;
        data_write_done  = 1'b0;
        data_file        = $fopen("memory.txt","r");
        out_file         = $fopen("out.txt","w");
        
    end
    
    always #(5) clk <= ~clk;
    
    
    always @(posedge clk) begin
        if (output_write_start == 1'b0)begin
            scan_file = $fscanf(data_file, "%d\n", com_data_in);
            if ($feof(data_file)) begin
                data_write_done  <= 1'b1;
                data_write_start <= 1'b0;
            end
        end
        
        else begin
        $fwrite(out_file,"%d\n",com_data_out);
        if (output_write_done)begin
            $fclose(data_file);
            $fclose(out_file);
            $stop;
        end
    end
    end
    
    main main1(
    .clk(clk),
    .com_data_in(com_data_in),
    .data_write_start(data_write_start),
    .data_write_done(data_write_done),
    .state(state),
    .n_cores(n_cores),
    .com_data_out(com_data_out),
    .output_write_done(output_write_done),
    .output_write_start(output_write_start)
    );
    
endmodule
