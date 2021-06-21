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
        ram[0] = LDA;
        ram[1] = 16'd5;
        ram[2] = MVA;
        ram[3] = LDB;
        ram[4] = 16'd10;
        ram[5] = MVB;
        ram[6] = LDC;
        ram[7] = 16'd15;
        ram[8] = STC;
        ram[9] = 16'd25;
        ram[10] = LDAC;
        ram[11] = 16'd5;
        ram[12] = ENDOP;




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