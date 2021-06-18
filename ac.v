module AC(
    input clk,
    input ac_inc_en,
    input ac_write_en,
    input [15:0]data_in,
    input alu_to_ac,
    input ALU_write_en,
    input ac_to_r,
    input [15:0] alu_out, //output from alu
    output reg [15:0] data_out=16'd0
);
	reg [15:0]ac_write_en_i;

    always @(posedge clk) begin
        ac_write_en_i <= ac_write_en;
    end

    always @(posedge clk) begin
        if (ac_write_en_i==1)
            data_out <= data_in;
        if (ac_inc_en ==1)
            data_out <= data_out + 16'd1;
        if (alu_to_ac ==1)
            data_out <= alu_out;
        if (ALU_write_en ==1)
            data_out <= data_in; 
        if (ac_to_r == 1)
            data_out <= data_in;
            
    end
endmodule