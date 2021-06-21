module reg_inc(
    input clk,
    input reg_write_en , 
    input reg_inc_en,
    input [15:0]data_in,
    output reg [15:0]data_out = 16'b0
);

    reg [15:0]reg_write_en_i;


    always @(posedge clk)begin
        if (reg_write_en== 1'b1)              //Write data to the register
            data_out <= data_in;    
        if (reg_inc_en ==1'b1)                 //increment the value
            data_out <= data_out + 16'b1;
    end

endmodule