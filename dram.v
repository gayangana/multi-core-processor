module DRAM (
    input clk,
    input write_en,
    input [15:0]addr,
    input [15:0] data_in,
    output reg [15:0] data_out
    );

    reg [15:0] ram [1024:0];

    initial begin
        //ram[10]= 16'd85;

        // ram[0] = 3;
        // ram[1] = 3;
        // ram[2] = 3;
        // ram[3] = 12;
        // ram[4] = 21;
        // ram[5] = 30;
        // ram[6] = 0;
        // ram[7] = 0;
        // ram[8] = 0;
        // ram[9] = 0;
        // ram[10] = 0;
        // ram[11] = 0;
        // ram[12] = 13;
        // ram[13] = 15;
        // ram[14] = 22;
        // ram[15] = 43;
        // ram[16] = 64;
        // ram[17] = 12;
        // ram[18] = 62;
        // ram[19] = 25;
        // ram[20] = 37;
        // ram[21] = 78;
        // ram[22] = 145;
        // ram[23] = 13;
        // ram[24] = 54;
        // ram[25] = 31;
        // ram[26] = 17;
        // ram[27] = 61;
        // ram[28] = 42;
        // ram[29] = 79;
        // ram[30] = 0;
        // ram[31] = 0;
        // ram[32] = 0;
        // ram[33] = 0;
        // ram[34] = 0;
        // ram[35] = 0;
        // ram[36] = 0;
        // ram[37] = 0;
        // ram[38] = 0;

    end


    always @(posedge clk)begin
        if (write_en == 1)
            ram[addr] <= data_in;
        else
            data_out <= ram[addr];
    end

endmodule