module DRAM (input clk,
             input write_en,
             input [15:0] addr,
             input [15:0] data_in,
             output reg [15:0] data_out);
    
    reg [15:0] ram [1024:0];
    
    initial begin
        ram[0]  = 16'd1;
        ram[1]  = 16'd5;
        ram[2]  = 16'd3;
        ram[3]  = 16'd15;
        ram[4]  = 16'd8;
        ram[5]  = 16'd23;
        ram[6]  = 16'd68;
        ram[7]  = 16'd143;
        ram[8]  = 16'd14;
        ram[9]  = 16'd14;
        ram[10] = 16'd4;
        ram[11] = 16'd9;
        ram[12] = 16'd6;
        ram[13] = 16'd13;
        ram[14] = 16'd29;
        ram[15] = 16'd15;
        ram[16] = 16'd14;
        ram[17] = 16'd9;
        ram[18] = 16'd3;
        ram[19] = 16'd21;
        ram[20] = 16'd1;
        ram[21] = 16'd2;
        ram[22] = 16'd23;
        ram[23] = 16'd30;
        ram[24] = 16'd15;
        ram[25] = 16'd7;
        ram[26] = 16'd17;
        ram[27] = 16'd9;
        ram[28] = 16'd24;
        ram[29] = 16'd13;
        ram[30] = 16'd9;
        ram[31] = 16'd26;
        ram[32] = 16'd25;
        ram[33] = 16'd9;
        ram[34] = 16'd12;
        ram[35] = 16'd17;
        ram[36] = 16'd24;
        ram[37] = 16'd4;
        ram[38] = 16'd23;
        ram[39] = 16'd2;
        ram[40] = 16'd0;
        ram[41] = 16'd15;
        ram[42] = 16'd1;
        ram[43] = 16'd28;
        ram[44] = 16'd17;
        ram[45] = 16'd6;
        ram[46] = 16'd23;
        ram[47] = 16'd12;
        ram[48] = 16'd22;
        ram[49] = 16'd15;
        ram[50] = 16'd20;
        ram[51] = 16'd27;
        ram[52] = 16'd16;
        ram[53] = 16'd16;
        ram[54] = 16'd20;
        ram[55] = 16'd16;
        ram[56] = 16'd23;
        ram[57] = 16'd10;
        ram[58] = 16'd20;
        ram[59] = 16'd27;
        ram[60] = 16'd21;
        ram[61] = 16'd24;
        ram[62] = 16'd25;
        ram[63] = 16'd30;
        ram[64] = 16'd20;
        ram[65] = 16'd0;
        ram[66] = 16'd24;
        ram[67] = 16'd7;
        ram[68] = 16'd0;
    end
    
    integer i;
    
    always @(posedge clk) begin
        if (write_en == 1)
            ram[addr] <= data_in;
        else
            data_out <= ram[addr];
    end
    
endmodule
