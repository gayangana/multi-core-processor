module DRAM (
    input clk,
    input write_en,
    input addr_write_en,
    input [15:0]addr,
    input [15:0] data_in,
    output reg [15:0] data_out
    );

    reg [15:0] addr_write_en_i;
    reg [15:0] addr_write_en_ii;
    reg [15:0] addr_op;
    reg [15:0] ram [65535:0];

    initial begin
        ram[25] = 16'd12;
        ram[26] =16'd8;
        ram[40] = 16'd23;
        ram[41] = 16'd4;
    end

    always @(posedge clk)begin
        addr_write_en_i <= addr_write_en;
        //addr_write_en_ii<= addr_write_en_i;
    end

    always @(posedge clk)begin
        if (addr_write_en_i==1)
            addr_op <= data_in;
    end

    always @(posedge clk)begin
        if (write_en == 1)
            ram[addr_op] <= data_in;
        else
            data_out <= ram[data_in];
    end

endmodule