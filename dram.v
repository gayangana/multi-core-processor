module DRAM (
    input clk,
    input write_en,
    input [15:0]addr,
    input [15:0] data_in,
    output reg [15:0] data_out
    );

    reg [15:0] ram [65535:0];

    initial begin
        ram[65402] = 16'd5;
        ram[26] =16'd8;
        ram[40] = 16'd23;
        ram[130] = 16'd46;
        ram[135] = 16'd85;
    end


    always @(posedge clk)begin
        if (write_en == 1)
            ram[addr] <= data_in;
        else
            data_out <= ram[addr];
    end

endmodule