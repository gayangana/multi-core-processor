module IRAM (
    input clk,
    input [15:0] data_in,
    input [15:0] addr,
    output reg [15:0] data_out
);

    reg [15:0] ram[65535:0];

    parameter NOP   = 16'd41;
    parameter LDAC  = 16'd7 ;
    parameter STAC  = 16'd11 ;
    parameter MVACR  = 16'd15;
    parameter MVR   = 16'd16;
    parameter ADD   = 16'd17;
    parameter ADDM  = 16'd19;
    parameter INAC  = 16'd23;
    parameter SUB   = 16'd24;
    parameter MUL   = 16'd26;
    parameter MULM  = 16'd28;
    parameter CLAC  = 16'd32;
    parameter JUMP  = 16'd33;
    parameter JPNZ  = 16'd35;
    parameter ENDOP = 16'd40;
    parameter LDA   = 16'd45;
    parameter LDB   = 16'd51;
    parameter LDC   = 16'd57;
    parameter MVA   = 16'd16;
    parameter MVB   = 16'd42;
    parameter MVC   = 16'd43;
    parameter MVACC = 16'd44;
    parameter STC   = 16'd63;

    initial begin
        //assmebly code
        ram[0] = CLAC;
        ram[1] = STAC;
        ram[2] = 16'd6;
        ram[3] = CLAC;
        ram[4] = STAC;
        ram[5] = 16'd7;
        ram[6] = CLAC;
        ram[7] = STAC;
        ram[8] = 16'd8;
        ram[9] = MVACC;
        ram[10] = LDAC;
        ram[11] = 16'd6;
        ram[12] = MVACR;
        ram[13] = LDAC;
        ram[14] = 16'd1;
        ram[15] = MUL;
        ram[16] = MVACR;
        ram[17] = LDAC;
        ram[18] = 16'd8;
        ram[19] = ADD;
        ram[20] = MVACR;
        ram[21] = LDAC;
        ram[22] = 16'd3;
        ram[23] = ADD;
        ram[24] = STAC;
        ram[25] = 16'd9;
        ram[26] = LDA;
        ram[27] = 16'd9;
        ram[28] = LDAC;
        ram[29] = 16'd8;
        ram[30] = MVACR;
        ram[31] = LDAC;
        ram[32] = 16'd2;
        ram[33] = MUL;
        ram[34] = MVACR;
        ram[35] = LDAC;
        ram[36] = 16'd7;
        ram[37] = ADD;
        ram[38] = MVACR;
        ram[39] = LDAC;
        ram[40] = 16'd4;
        ram[41] = ADD;
        ram[42] = STAC;
        ram[43] = 16'd10;
        ram[44] = LDB;
        ram[45] = 16'd10;
        ram[46] = MVA;
        ram[47] = MVACR;
        ram[48] = MVB;
        ram[49] = MUL;
        ram[50] = MVACR;
        ram[51] = MVC;
        ram[52] = ADD;
        ram[53] = MVACC;
        ram[54] = LDAC;
        ram[55] = 16'd1;
        ram[56] = MVACR;
        ram[57] = LDAC;
        ram[58] = 16'd8;
        ram[59] = INAC;
        ram[60] = STAC;
        ram[61] = 16'd8;
        ram[62] = SUB;
        ram[63] = JPNZ;
        ram[64] = 16'd10;
        ram[65] = STC;
        ram[66] = 16'd11;
        ram[67] = LDAC;
        ram[68] = 16'd11;
        ram[69] = INAC;
        ram[70] = STAC;
        ram[71] = 16'd11;
        ram[72] = LDAC;
        ram[73] = 16'd2;
        ram[74] = MVACR;
        ram[75] = LDAC;
        ram[76] = 16'd7;
        ram[77] = INAC;
        ram[78] = STAC;
        ram[79] = 16'd7;
        ram[80] = SUB;
        ram[81] = JPNZ;
        ram[82] = 16'd6;
        ram[83] = LDAC;
        ram[84] = 16'd0;
        ram[85] = MVACR;
        ram[86] = LDAC;
        ram[87] = 16'd6;
        ram[88] = INAC;
        ram[89] = STAC;
        ram[90] = 16'd6;
        ram[91] = SUB;
        ram[92] = JPNZ;
        ram[93] = 16'd3;
        ram[94] = ENDOP;




        // ram[0] = LDA;
        // ram[1] = 16'd5;
        // ram[2] = MVA;
        // ram[3] = LDB;
        // ram[4] = 16'd10;
        // ram[5] = MVB;
        // ram[6] = LDC;
        // ram[7] = 16'd15;
        // ram[8] = STC;
        // ram[9] = 16'd25;
        // ram[10] = LDAC;
        // ram[11] = 16'd5;
        // ram[12] = ENDOP;




        // ram[0] = CLAC;
        // ram[1] = STAC;
        // ram[2] = 16'd65400;  //TOTAL
        // ram[3] = STAC;
        // ram[4] = 16'd65401;     //i
        // ram[5] = LDAC;
        // ram[6] = 16'd65401;
        // ram[7] = INAC;
        // ram[8] = STAC;
        // ram[9] = 16'd65401;
        // ram[10] = MVACR;
        // ram[11] = LDAC;
        // ram[12]= 16'd65400;
        // ram[13]= ADD;
        // ram[14]= STAC;
        // ram[15]= 16'd65400;
        // ram[16]= LDAC;
        // ram[17]= 16'd65402;  //N
        // ram[18]= SUB;
        // ram[19]= JPNZ;
        // ram[20]= 16'd5;
        // ram[21]= LDAC;
        // ram[22]= 16'd65400;
        // ram[23]= STAC;
        // ram[24]= 16'd65405;
        // ram[25]= ENDOP;
        //...

        // ram[0] = LDAC;
        // ram[1] = 16'd5;
        // ram[2] = MVACR;  //TOTAL
        // ram[3] = LDAC;
        // ram[4] = 16'd10;
        // ram[5] = MUL;
        // ram[6] = STAC;
        // ram[7] = 16'd65400;
        // ram[8] = ENDOP;
        
    end

    always @(posedge clk) begin
        data_out <= ram[addr];
    end

endmodule