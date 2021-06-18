module IRAM (
    input clk,
    input [15:0] data_in,
    output reg [15:0] data_out
);

    reg [15:0] ram[65535:0];

    parameter NOP   = 16'd38;
    parameter LDAC  = 16'd7 ;
    parameter STAC  = 16'd11 ;
    parameter MVAC  = 16'd15;
    parameter MVR   = 16'd16;
    parameter ADD   = 16'd17;
    parameter ADDM  = 16'd19;
    parameter INAC  = 16'd23;
    parameter SUB   = 16'd24;
    parameter MUL   = 16'd25;
    parameter MULM  = 16'd26;
    parameter CLAC  = 16'd30;
    parameter JUMP  = 16'd31;
    parameter JUMPZ = 16'd33;
    parameter ENDOP = 16'd37;

    initial begin
        //assmebly code
        ram[0] = LDAC;
        ram[1] = 16'd25;
        ram[2] = MVAC;
        ram[3] = LDAC;
        ram[4] = 16'd26;
        ram[5] = MUL;
        ram[6] = STAC;
        ram[7] = 16'd65000;
        ram[8] = LDAC;
        ram[9] = 16'd40;
        ram[10]= MVAC;
        ram[11]= LDAC;
        ram[12]= 16'd41;
        ram[13]= MUL;
        ram[14]= STAC;
        ram[15]= 16'd65001;
        ram[16]= LDAC;
        ram[17]= 16'd65000;
        ram[18]= MVAC;
        ram[19]= LDAC;
        ram[20]= 16'd65001;
        ram[21]= ADD;
        ram[22]= STAC;
        ram[23]= 16'd65002;
        ram[24] = ENDOP;
        //...
        
    end

    always @(posedge clk) begin
        data_out <= ram[data_in];
    end

endmodule