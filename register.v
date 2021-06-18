module register(
    input clk,
    input reg_write_en , 
    input [15:0]data_in,
    output reg [15:0]data_out
); 

	reg [15:0]reg_write_en_i;
    always @(posedge clk)begin
        reg_write_en_i <= reg_write_en;
    end


    always @(posedge clk)begin
        if (reg_write_en_i == 1'b1)              //Write data to the register
            data_out <= data_in;
        
    end

endmodule