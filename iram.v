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

        
        // ram[0] = LDAC;
        // ram[1] = 16'd2;
        // ram[2] = MVACR;  //TOTAL
        // ram[3] = LDAC;
        // ram[4] = 16'd4;
        // ram[5] = MUL;
        // ram[6] = STAC;
        // ram[7] = 16'd65400;
        // ram[8] = ENDOP;

        //assmebly code
        ram[0] = CLAC;
        ram[1] = STAC;
        ram[2] = 16'd6;
        ram[3] = LDAC;
        ram[4] = 16'd5;
        ram[5] = STAC;
        ram[6] = 16'd11;
        ram[7] = CLAC;
        ram[8] = STAC;
        ram[9] = 16'd7;
        ram[10] = CLAC;
        ram[11] = STAC;
        ram[12] = 16'd8;
        ram[13] = MVACC;
        ram[14] = LDAC;
        ram[15] = 16'd6;
        ram[16] = MVACR;
        ram[17] = LDAC;
        ram[18] = 16'd1;
        ram[19] = MUL;
        ram[20] = MVACR;
        ram[21] = LDAC;
        ram[22] = 16'd8;
        ram[23] = ADD;
        ram[24] = MVACR;
        ram[25] = LDAC;
        ram[26] = 16'd3;
        ram[27] = ADD;
        ram[28] = STAC;
        ram[29] = 16'd9;
        ram[30] = LDA;
        ram[31] = 16'd9;
        ram[32] = LDAC;
        ram[33] = 16'd8;
        ram[34] = MVACR;
        ram[35] = LDAC;
        ram[36] = 16'd2;
        ram[37] = MUL;
        ram[38] = MVACR;
        ram[39] = LDAC;
        ram[40] = 16'd7;
        ram[41] = ADD;
        ram[42] = MVACR;
        ram[43] = LDAC;
        ram[44] = 16'd4;
        ram[45] = ADD;
        ram[46] = STAC;
        ram[47] = 16'd10;
        ram[48] = LDB;
        ram[49] = 16'd10;
        ram[50] = MVA;
        ram[51] = MVACR;
        ram[52] = MVB;
        ram[53] = MUL;
        ram[54] = MVACR;
        ram[55] = MVC;
        ram[56] = ADD;
        ram[57] = MVACC;
        ram[58] = LDAC;
        ram[59] = 16'd1;
        ram[60] = MVACR;
        ram[61] = LDAC;
        ram[62] = 16'd8;
        ram[63] = INAC;
        ram[64] = STAC;
        ram[65] = 16'd8;
        ram[66] = SUB;
        ram[67] = JPNZ;
        ram[68] = 16'd14;
        ram[69] = STC;
        ram[70] = 16'd11;
        ram[71] = LDAC;
        ram[72] = 16'd11;
        ram[73] = INAC;
        ram[74] = STAC;
        ram[75] = 16'd11;
        ram[76] = LDAC;
        ram[77] = 16'd2;
        ram[78] = MVACR;
        ram[79] = LDAC;
        ram[80] = 16'd7;
        ram[81] = INAC;
        ram[82] = STAC;
        ram[83] = 16'd7;
        ram[84] = SUB;
        ram[85] = JPNZ;
        ram[86] = 16'd10;
        ram[87] = LDAC;
        ram[88] = 16'd0;
        ram[89] = MVACR;
        ram[90] = LDAC;
        ram[91] = 16'd6;
        ram[92] = INAC;
        ram[93] = STAC;
        ram[94] = 16'd6;
        ram[95] = SUB;
        ram[96] = JPNZ;
        ram[97] = 16'd7;
        ram[98] = ENDOP;




        // ram[0] = LDA;
        // ram[1] = 16'd2;
        // ram[2] = MVA;
        // ram[3] = LDB;
        // ram[4] = 16'd4;
        // ram[5] = MVB;
        // ram[6] = LDC;
        // ram[7] = 16'd6;
        // ram[8] = STC;
        // ram[9] = 16'd8;
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

        
    end

    always @(posedge clk) begin
        data_out <= ram[addr];
    end

endmodule