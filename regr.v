module regR(
    input clk,
    input reg_write_en , 
    input ALU_write_en,
    input ac_to_r,
    input [15:0]data_in,
    output reg[15:0] data_r_to_alu,
    output reg [15:0]data_out
);


    always @(posedge clk)begin
        if (reg_write_en == 1)              //Write data to the register
            data_out <= data_in;
        if (ac_to_r == 1)
            data_out <= data_in;
        if (ALU_write_en == 1)
            data_out <= data_in;
    end

endmodule