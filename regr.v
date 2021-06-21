module regR(
    input clk,
    input write_en , 
    input [15:0]data_in,
    output reg [15:0]data_out
);


    always @(posedge clk)begin
        if (write_en == 1)              //Write data to the register
            data_out <= data_in;

    end

endmodule