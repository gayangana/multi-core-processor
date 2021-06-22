module selector(
    input clk,
    input [1:0]status,
    input [15:0]com_data_in,
    input [15:0]com_addr,
    input com_wr_en,
    input [15:0]proc_bus,
    input [15:0]proc_addr,
    input proc_wr_en,

    output reg [15:0]DM_data_in,
    output reg [15:0]DM_addr,
    output reg DM_write_en
);



    always @(status)begin
        case(status)
            2'b00: begin
                assign DM_data_in  = com_data_in;
                assign DM_addr     = com_addr;
                assign DM_write_en = com_wr_en;
            end

            2'b01: begin
                assign DM_data_in  = proc_bus;
                assign DM_addr     = proc_addr;
                assign DM_write_en = proc_wr_en;
            end
        endcase
    end
endmodule
