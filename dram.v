module DRAM (
    input clk,
    input write_en,
    input [15:0]addr,
    input [15:0] data_in,
    output reg [15:0] data_out
    );

    reg [15:0] ram [65535:0];

    initial begin
        ram[5]  = 16'd75;
        ram[10] = 16'd85;
        ram[15] = 16'd95;
        ram[25] = 16'd65450;
        ram[75] = 16'd91;
        ram[85] = 16'd101;
        ram[95] = 16'd111;
    end


    always @(posedge clk)begin
        if (write_en == 1)
            ram[addr] <= data_in;
        else
            data_out <= ram[addr];
    end

endmodule