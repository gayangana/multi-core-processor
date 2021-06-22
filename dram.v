module DRAM (
    input clk,
    input write_en,
    input [15:0]addr,
    input [15:0] data_in,
    output reg [15:0] data_out
    );

    reg [15:0] ram [65535:0];

    initial begin
        ram[0] = 3;
        ram[1] = 2;
        ram[2] = 4;
        ram[3] = 12;
        ram[4] = 18;
        ram[5] = 26;
        ram[6] = 0;
        ram[7] = 0;
        ram[8] = 0;
        ram[9] = 0;
        ram[10] = 0;
        ram[11] = 0;
        ram[12] = 2;
        ram[13] = 5;
        ram[14] = 7;
        ram[15] = 1;
        ram[16] = 5;
        ram[17] = 4;
        ram[18] = 3;
        ram[19] = 1;
        ram[20] = 2;
        ram[21] = 6;
        ram[22] = 5;
        ram[23] = 3;
        ram[24] = 2;
        ram[25] = 1;
        ram[26] = 0;
        ram[27] = 0;
        ram[28] = 0;
        ram[29] = 0;
        ram[30] = 0;
        ram[31] = 0;
        ram[32] = 0;
        ram[33] = 0;
        ram[34] = 0;
        ram[35] = 0;
        ram[36] = 0;
        ram[37] = 0;
    end


    always @(posedge clk)begin
        if (write_en == 1)
            ram[addr] <= data_in;
        else
            data_out <= ram[addr];
    end

endmodule