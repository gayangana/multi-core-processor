`include "definitions.v"

module DRAM (input clk,
             input write_en_1,
             input [15:0]addr_1,
             input [15:0] data_in_1,
             output reg [15:0] data_out_1,
             input [`NUM_C-2:0] write_en,
             input [((`NUM_C-1)*16)-1:0] addr, 
             input [((`NUM_C-1)*16)-1:0] data_in, 
             output reg [((`NUM_C-1)*16)-1:0] data_out);
    
    reg [15:0] ram [1024:0];
    
    initial begin
        // ram[0]  = 16'd8;
        // ram[1]  = 16'd3;
        // ram[2]  = 16'd2;
        // ram[3]  = 16'd4;
        // ram[4]  = 16'd8;
        // ram[5]  = 16'd14;
        // ram[6]  = 16'd22;
        // ram[7]  = 16'd34;
        // ram[8]  = 16'd2;
        // ram[9]  = 16'd5;
        // ram[10] = 16'd7;
        // ram[11] = 16'd1;
        // ram[12] = 16'd5;
        // ram[13] = 16'd4;
        // ram[14] = 16'd3;
        // ram[15] = 16'd1;
        // ram[16] = 16'd2;
        // ram[17] = 16'd6;
        // ram[18] = 16'd5;
        // ram[19] = 16'd3;
        // ram[20] = 16'd2;
        // ram[21] = 16'd1;
    end
    
    integer i;
    
    always @(posedge clk) begin
        if (write_en_1 == 1)
            ram[addr_1] <= data_in_1;
        else
            data_out_1 <= ram[addr_1];
        
        for (i = 0; i < `NUM_C; i = i + 1) begin
            if (write_en[i] == 1)
                ram[addr[i*16 +:16]] <= data_in[i*16 +:16];
            else
                data_out[i*16 +:16] <= ram[addr[i*16 +:16]];
        end
    end
    
endmodule
