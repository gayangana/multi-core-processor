module IRAM (
    input clk,
    //input [15:0] data_in,
    input [15:0] addr_1,
    output reg [15:0] data_out_1,

    input [15:0] addr_2,
    output reg [15:0] data_out_2,

    input [15:0] addr_3,
    output reg [15:0] data_out_3
);

    reg [15:0] ram[1024:0];

    
    parameter LDAC  = 16'd5 ;
    parameter STAC  = 16'd7 ;
    parameter LDA   = 16'd9;
    parameter LDB   = 16'd14;
    parameter LDC   = 16'd19;
    parameter STC   = 16'd24;
    parameter MVACR = 16'd29;
    parameter MVACC = 16'd30;
    parameter MVA   = 16'd31;
    parameter MVB   = 16'd32;
    parameter MVC   = 16'd33;
    parameter INAC  = 16'd34;
    parameter CLAC  = 16'd35;
    parameter ADD   = 16'd36;
    parameter SUB   = 16'd38;
    parameter MUL   = 16'd40;
    parameter DIV   = 16'd42;
    parameter MOD   = 16'd44;
    parameter JUMP  = 16'd46;
    parameter JPNZ  = 16'd48;
    parameter NOP   = 16'd50;
    parameter ENDOP = 16'd51;
    parameter MVACA = 16'd52;
    parameter MVACB = 16'd53;
    parameter MVACD = 16'd54;
    parameter LDDAC = 16'd55;
    parameter STDAC = 16'd59;
    parameter JPPZ  = 16'd62;
    parameter MVCID = 16'd64;
    parameter MVD   = 16'd65;

    initial begin

        // assembly code multi core
        ram[0] = LDAC;
        ram[1] = 16'd7;
        ram[2] = MVACR;
        ram[3] = MVCID;
        ram[4] = ADD;
        ram[5] = MVACD;
        ram[6] = CLAC;
        ram[7] = STDAC;
        ram[8] = LDDAC;
        ram[9] = MVACR;
        ram[10] = LDAC;
        ram[11] = 16'd0;
        ram[12] = MUL;
        ram[13] = MVACR;
        ram[14] = MVCID;
        ram[15] = ADD;
        ram[16] = MVACR;
        ram[17] = MVACA;
        ram[18] = LDAC;
        ram[19] = 16'd1;
        ram[20] = SUB;
        ram[21] = JPPZ;
        ram[22] = 16'd234;
        ram[23] = MVD;
        ram[24] = MVACR;
        ram[25] = LDAC;
        ram[26] = 16'd0;
        ram[27] = ADD;
        ram[28] = MVACD;
        ram[29] = MVA;
        ram[30] = STDAC;
        ram[31] = MVD;
        ram[32] = MVACR;
        ram[33] = LDAC;
        ram[34] = 16'd0;
        ram[35] = ADD;
        ram[36] = MVACD;
        ram[37] = CLAC;
        ram[38] = STDAC;
        ram[39] = MVD;
        ram[40] = MVACR;
        ram[41] = LDAC;
        ram[42] = 16'd0;
        ram[43] = ADD;
        ram[44] = MVACD;
        ram[45] = CLAC;
        ram[46] = STDAC;
        ram[47] = MVACC;
        ram[48] = LDAC;
        ram[49] = 16'd7;
        ram[50] = MVACR;
        ram[51] = MVCID;
        ram[52] = ADD;
        ram[53] = MVACR;
        ram[54] = LDAC;
        ram[55] = 16'd0;
        ram[56] = ADD;
        ram[57] = MVACD;
        ram[58] = LDDAC;
        ram[59] = MVACR;
        ram[60] = LDAC;
        ram[61] = 16'd2;
        ram[62] = MUL;
        ram[63] = MVACR;
        ram[64] = MVACA;
        ram[65] = MVD;
        ram[66] = MVACR;
        ram[67] = LDAC;
        ram[68] = 16'd0;
        ram[69] = ADD;
        ram[70] = MVACR;
        ram[71] = LDAC;
        ram[72] = 16'd0;
        ram[73] = ADD;
        ram[74] = MVACD;
        ram[75] = LDDAC;
        ram[76] = MVACR;
        ram[77] = MVA;
        ram[78] = ADD;
        ram[79] = MVACR;
        ram[80] = LDAC;
        ram[81] = 16'd4;
        ram[82] = ADD;
        ram[83] = MVACD;
        ram[84] = LDDAC;
        ram[85] = MVACA;
        ram[86] = LDAC;
        ram[87] = 16'd7;
        ram[88] = MVACR;
        ram[89] = MVCID;
        ram[90] = ADD;
        ram[91] = MVACR;
        ram[92] = LDAC;
        ram[93] = 16'd0;
        ram[94] = ADD;
        ram[95] = MVACR;
        ram[96] = LDAC;
        ram[97] = 16'd0;
        ram[98] = ADD;
        ram[99] = MVACR;
        ram[100] = LDAC;
        ram[101] = 16'd0;
        ram[102] = ADD;
        ram[103] = MVACD;
        ram[104] = LDDAC;
        ram[105] = MVACR;
        ram[106] = LDAC;
        ram[107] = 16'd3;
        ram[108] = MUL;
        ram[109] = MVACR;
        ram[110] = MVACB;
        ram[111] = LDAC;
        ram[112] = 16'd0;
        ram[113] = MVACR;
        ram[114] = MVD;
        ram[115] = SUB;
        ram[116] = MVACD;
        ram[117] = LDDAC;
        ram[118] = MVACR;
        ram[119] = MVB;
        ram[120] = ADD;
        ram[121] = MVACR;
        ram[122] = LDAC;
        ram[123] = 16'd5;
        ram[124] = ADD;
        ram[125] = MVACD;
        ram[126] = LDDAC;
        ram[127] = MVACB;
        ram[128] = MVACR;
        ram[129] = MVA;
        ram[130] = MUL;
        ram[131] = MVACR;
        ram[132] = MVC;
        ram[133] = ADD;
        ram[134] = MVACC;
        ram[135] = LDAC;
        ram[136] = 16'd7;
        ram[137] = MVACR;
        ram[138] = MVCID;
        ram[139] = ADD;
        ram[140] = MVACR;
        ram[141] = LDAC;
        ram[142] = 16'd0;
        ram[143] = ADD;
        ram[144] = MVACR;
        ram[145] = LDAC;
        ram[146] = 16'd0;
        ram[147] = ADD;
        ram[148] = MVACR;
        ram[149] = LDAC;
        ram[150] = 16'd0;
        ram[151] = ADD;
        ram[152] = MVACD;
        ram[153] = LDDAC;
        ram[154] = INAC;
        ram[155] = STDAC;
        ram[156] = MVACR;
        ram[157] = LDAC;
        ram[158] = 16'd2;
        ram[159] = SUB;
        ram[160] = JPNZ;
        ram[161] = 16'd48;
        ram[162] = LDAC;
        ram[163] = 16'd7;
        ram[164] = MVACR;
        ram[165] = MVCID;
        ram[166] = ADD;
        ram[167] = MVACR;
        ram[168] = LDAC;
        ram[169] = 16'd0;
        ram[170] = ADD;
        ram[171] = MVACD;
        ram[172] = LDDAC;
        ram[173] = MVACR;
        ram[174] = LDAC;
        ram[175] = 16'd3;
        ram[176] = MUL;
        ram[177] = MVACR;
        ram[178] = MVACA;
        ram[179] = MVD;
        ram[180] = MVACR;
        ram[181] = LDAC;
        ram[182] = 16'd0;
        ram[183] = ADD;
        ram[184] = MVACD;
        ram[185] = LDDAC;
        ram[186] = MVACR;
        ram[187] = MVA;
        ram[188] = ADD;
        ram[189] = MVACR;
        ram[190] = LDAC;
        ram[191] = 16'd6;
        ram[192] = ADD;
        ram[193] = MVACD;
        ram[194] = MVC;
        ram[195] = STDAC;
        ram[196] = LDAC;
        ram[197] = 16'd7;
        ram[198] = MVACR;
        ram[199] = MVCID;
        ram[200] = ADD;
        ram[201] = MVACR;
        ram[202] = LDAC;
        ram[203] = 16'd0;
        ram[204] = ADD;
        ram[205] = MVACR;
        ram[206] = LDAC;
        ram[207] = 16'd0;
        ram[208] = ADD;
        ram[209] = MVACD;
        ram[210] = LDDAC;
        ram[211] = INAC;
        ram[212] = STDAC;
        ram[213] = MVACR;
        ram[214] = LDAC;
        ram[215] = 16'd3;
        ram[216] = SUB;
        ram[217] = JPNZ;
        ram[218] = 16'd39;
        ram[219] = LDAC;
        ram[220] = 16'd7;
        ram[221] = MVACR;
        ram[222] = MVCID;
        ram[223] = ADD;
        ram[224] = MVACD;
        ram[225] = LDDAC;
        ram[226] = INAC;
        ram[227] = STDAC;
        ram[228] = MVACR;
        ram[229] = LDAC;
        ram[230] = 16'd1;
        ram[231] = SUB;
        ram[232] = JPNZ;
        ram[233] = 16'd8;
        ram[234] = ENDOP;


        // ram[0] = MVCID;
        // ram[1] = MVACD;
        // ram[2] = LDAC;
        // ram[3] = 16'd4;
        // ram[4] = STDAC;
        // ram[5] = LDAC;
        // ram[6] = 16'd23;
        // ram[7] = ENDOP;


        //assmebly code single core
        // ram[0] = CLAC;
        // ram[1] = STAC;
        // ram[2] = 16'd6;
        // ram[3] = LDAC;
        // ram[4] = 16'd5;
        // ram[5] = STAC;
        // ram[6] = 16'd11;
        // ram[7] = CLAC;
        // ram[8] = STAC;
        // ram[9] = 16'd7;
        // ram[10] = CLAC;
        // ram[11] = STAC;
        // ram[12] = 16'd8;
        // ram[13] = MVACC;
        // ram[14] = LDAC;
        // ram[15] = 16'd6;
        // ram[16] = MVACR;
        // ram[17] = LDAC;
        // ram[18] = 16'd1;
        // ram[19] = MUL;
        // ram[20] = MVACR;
        // ram[21] = LDAC;
        // ram[22] = 16'd8;
        // ram[23] = ADD;
        // ram[24] = MVACR;
        // ram[25] = LDAC;
        // ram[26] = 16'd3;
        // ram[27] = ADD;
        // ram[28] = STAC;
        // ram[29] = 16'd9;
        // ram[30] = LDA;
        // ram[31] = 16'd9;
        // ram[32] = LDAC;
        // ram[33] = 16'd8;
        // ram[34] = MVACR;
        // ram[35] = LDAC;
        // ram[36] = 16'd2;
        // ram[37] = MUL;
        // ram[38] = MVACR;
        // ram[39] = LDAC;
        // ram[40] = 16'd7;
        // ram[41] = ADD;
        // ram[42] = MVACR;
        // ram[43] = LDAC;
        // ram[44] = 16'd4;
        // ram[45] = ADD;
        // ram[46] = STAC;
        // ram[47] = 16'd10;
        // ram[48] = LDB;
        // ram[49] = 16'd10;
        // ram[50] = MVA;
        // ram[51] = MVACR;
        // ram[52] = MVB;
        // ram[53] = MUL;
        // ram[54] = MVACR;
        // ram[55] = MVC;
        // ram[56] = ADD;
        // ram[57] = MVACC;
        // ram[58] = LDAC;
        // ram[59] = 16'd8;
        // ram[60] = INAC;
        // ram[61] = STAC;
        // ram[62] = 16'd8;
        // ram[63] = MVACR;
        // ram[64] = LDAC;
        // ram[65] = 16'd1;
        // ram[66] = SUB;
        // ram[67] = JPNZ;
        // ram[68] = 16'd14;
        // ram[69] = STC;
        // ram[70] = 16'd11;
        // ram[71] = LDAC;
        // ram[72] = 16'd11;
        // ram[73] = INAC;
        // ram[74] = STAC;
        // ram[75] = 16'd11;
        // ram[76] = LDAC;
        // ram[77] = 16'd7;
        // ram[78] = INAC;
        // ram[79] = STAC;
        // ram[80] = 16'd7;
        // ram[81] = MVACR;
        // ram[82] = LDAC;
        // ram[83] = 16'd2;
        // ram[84] = SUB;
        // ram[85] = JPNZ;
        // ram[86] = 16'd10;
        // ram[87] = LDAC;
        // ram[88] = 16'd6;
        // ram[89] = INAC;
        // ram[90] = STAC;
        // ram[91] = 16'd6;
        // ram[92] = MVACR;
        // ram[93] = LDAC;
        // ram[94] = 16'd0;
        // ram[95] = SUB;
        // ram[96] = JPNZ;
        // ram[97] = 16'd7;
        // ram[98] = ENDOP;





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
        data_out_1 <= ram[addr_1];
    end

    always @(posedge clk) begin
        data_out_2 <= ram[addr_2];
    end

    always @(posedge clk) begin
        data_out_3 <= ram[addr_3];
    end

endmodule