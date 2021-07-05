`include "definitions.v"

module IM (input clk,
           input [(`NUM_C*16)-1:0] addr, 
           output reg [(`NUM_C*16)-1:0] data_out);
    
    reg [15:0] ram[1024:0];
    
    parameter NOP   = 16'd5;
    parameter LDAC  = 16'd6;
    parameter STAC  = 16'd8;
    parameter LDDAC = 16'd10;
    parameter STDAC = 16'd14;
    parameter ADD   = 16'd17;
    parameter SUB   = 16'd19;
    parameter MUL   = 16'd21;
    parameter DIV   = 16'd23;
    parameter MOD   = 16'd25;
    parameter CLAC  = 16'd27;
    parameter INAC  = 16'd28;
    parameter JPNZ  = 16'd29;
    parameter JPPZ  = 16'd31;
    parameter MVCID = 16'd33;
    parameter MVA   = 16'd34;
    parameter MVB   = 16'd35;
    parameter MVC   = 16'd36;
    parameter MVD   = 16'd37;
    parameter MVACR = 16'd38;
    parameter MVACA = 16'd39;
    parameter MVACB = 16'd40;
    parameter MVACC = 16'd41;
    parameter MVACD = 16'd42;
    parameter ENDOP = 16'd43;
    
    initial begin
        ram[0]   = MVCID;
        ram[1]   = MVACR;
        ram[2]   = LDAC;
        ram[3]   = 16'd0;
        ram[4]   = SUB;
        ram[5]   = JPPZ;
        ram[6]   = 16'd216;
        ram[7]   = LDAC;
        ram[8]   = 16'd7;
        ram[9]   = MVACR;
        ram[10]  = MVCID;
        ram[11]  = ADD;
        ram[12]  = MVACD;
        ram[13]  = CLAC;
        ram[14]  = STDAC;
        ram[15]  = LDDAC;
        ram[16]  = MVACR;
        ram[17]  = LDAC;
        ram[18]  = 16'd0;
        ram[19]  = MUL;
        ram[20]  = MVACR;
        ram[21]  = MVCID;
        ram[22]  = ADD;
        ram[23]  = MVACR;
        ram[24]  = MVACA;
        ram[25]  = LDAC;
        ram[26]  = 16'd3;
        ram[27]  = MVACR;
        ram[28]  = MVA;
        ram[29]  = DIV;
        ram[30]  = MVACR;
        ram[31]  = MVACB;
        ram[32]  = LDAC;
        ram[33]  = 16'd1;
        ram[34]  = SUB;
        ram[35]  = JPPZ;
        ram[36]  = 16'd216;
        ram[37]  = MVD;
        ram[38]  = MVACR;
        ram[39]  = LDAC;
        ram[40]  = 16'd0;
        ram[41]  = ADD;
        ram[42]  = MVACD;
        ram[43]  = MVB;
        ram[44]  = STDAC;
        ram[45]  = MVD;
        ram[46]  = MVACR;
        ram[47]  = LDAC;
        ram[48]  = 16'd0;
        ram[49]  = ADD;
        ram[50]  = MVACD;
        ram[51]  = LDAC;
        ram[52]  = 16'd3;
        ram[53]  = MVACR;
        ram[54]  = MVA;
        ram[55]  = MOD;
        ram[56]  = STDAC;
        ram[57]  = MVD;
        ram[58]  = MVACR;
        ram[59]  = LDAC;
        ram[60]  = 16'd0;
        ram[61]  = ADD;
        ram[62]  = MVACD;
        ram[63]  = CLAC;
        ram[64]  = STDAC;
        ram[65]  = MVACC;
        ram[66]  = LDAC;
        ram[67]  = 16'd7;
        ram[68]  = MVACR;
        ram[69]  = MVCID;
        ram[70]  = ADD;
        ram[71]  = MVACR;
        ram[72]  = LDAC;
        ram[73]  = 16'd0;
        ram[74]  = ADD;
        ram[75]  = MVACD;
        ram[76]  = LDDAC;
        ram[77]  = MVACR;
        ram[78]  = LDAC;
        ram[79]  = 16'd2;
        ram[80]  = MUL;
        ram[81]  = MVACR;
        ram[82]  = MVACA;
        ram[83]  = MVD;
        ram[84]  = MVACR;
        ram[85]  = LDAC;
        ram[86]  = 16'd0;
        ram[87]  = ADD;
        ram[88]  = MVACR;
        ram[89]  = LDAC;
        ram[90]  = 16'd0;
        ram[91]  = ADD;
        ram[92]  = MVACD;
        ram[93]  = LDDAC;
        ram[94]  = MVACR;
        ram[95]  = MVACB;
        ram[96]  = MVA;
        ram[97]  = ADD;
        ram[98]  = MVACR;
        ram[99]  = LDAC;
        ram[100] = 16'd4;
        ram[101] = ADD;
        ram[102] = MVACD;
        ram[103] = LDDAC;
        ram[104] = MVACA;
        ram[105] = MVB;
        ram[106] = MVACR;
        ram[107] = LDAC;
        ram[108] = 16'd3;
        ram[109] = MUL;
        ram[110] = MVACR;
        ram[111] = MVACB;
        ram[112] = LDAC;
        ram[113] = 16'd7;
        ram[114] = MVACR;
        ram[115] = MVCID;
        ram[116] = ADD;
        ram[117] = MVACR;
        ram[118] = LDAC;
        ram[119] = 16'd0;
        ram[120] = ADD;
        ram[121] = MVACR;
        ram[122] = LDAC;
        ram[123] = 16'd0;
        ram[124] = ADD;
        ram[125] = MVACD;
        ram[126] = LDDAC;
        ram[127] = MVACR;
        ram[128] = MVB;
        ram[129] = ADD;
        ram[130] = MVACR;
        ram[131] = LDAC;
        ram[132] = 16'd5;
        ram[133] = ADD;
        ram[134] = MVACD;
        ram[135] = LDDAC;
        ram[136] = MVACB;
        ram[137] = MVACR;
        ram[138] = MVA;
        ram[139] = MUL;
        ram[140] = MVACR;
        ram[141] = MVC;
        ram[142] = ADD;
        ram[143] = MVACC;
        ram[144] = LDAC;
        ram[145] = 16'd7;
        ram[146] = MVACR;
        ram[147] = MVCID;
        ram[148] = ADD;
        ram[149] = MVACR;
        ram[150] = LDAC;
        ram[151] = 16'd0;
        ram[152] = ADD;
        ram[153] = MVACR;
        ram[154] = LDAC;
        ram[155] = 16'd0;
        ram[156] = ADD;
        ram[157] = MVACR;
        ram[158] = LDAC;
        ram[159] = 16'd0;
        ram[160] = ADD;
        ram[161] = MVACD;
        ram[162] = LDDAC;
        ram[163] = INAC;
        ram[164] = STDAC;
        ram[165] = MVACR;
        ram[166] = LDAC;
        ram[167] = 16'd2;
        ram[168] = SUB;
        ram[169] = JPNZ;
        ram[170] = 16'd66;
        ram[171] = LDAC;
        ram[172] = 16'd7;
        ram[173] = MVACR;
        ram[174] = MVCID;
        ram[175] = ADD;
        ram[176] = MVACR;
        ram[177] = LDAC;
        ram[178] = 16'd0;
        ram[179] = ADD;
        ram[180] = MVACD;
        ram[181] = LDDAC;
        ram[182] = MVACR;
        ram[183] = LDAC;
        ram[184] = 16'd3;
        ram[185] = MUL;
        ram[186] = MVACR;
        ram[187] = MVACA;
        ram[188] = MVD;
        ram[189] = MVACR;
        ram[190] = LDAC;
        ram[191] = 16'd0;
        ram[192] = ADD;
        ram[193] = MVACD;
        ram[194] = LDDAC;
        ram[195] = MVACR;
        ram[196] = MVA;
        ram[197] = ADD;
        ram[198] = MVACR;
        ram[199] = LDAC;
        ram[200] = 16'd6;
        ram[201] = ADD;
        ram[202] = MVACD;
        ram[203] = MVC;
        ram[204] = STDAC;
        ram[205] = LDAC;
        ram[206] = 16'd7;
        ram[207] = MVACR;
        ram[208] = MVCID;
        ram[209] = ADD;
        ram[210] = MVACD;
        ram[211] = LDDAC;
        ram[212] = INAC;
        ram[213] = STDAC;
        ram[214] = JPNZ;
        ram[215] = 16'd15;
        ram[216] = ENDOP;
    end
    
    integer i;
    
    always @(posedge clk) begin
        for (i = 0; i < `NUM_C; i = i + 1) begin
            data_out[i*16 +:16] <= ram[addr[i*16 +:16]];
        end
    end
    
endmodule