module selector(input clk,
                input [1:0]status,
                input [15:0]com_data_in,
                input [15:0]com_addr,
                input com_wr_en,
                input [15:0]proc_bus,
                input [15:0]proc_addr,
                input proc_wr_en,
                input [15:0]DM_out,
                output reg [15:0]DM_data_in,
                output reg [15:0]DM_addr,
                output reg DM_write_en,
                output reg [15:0]com_data_out,
                output reg [15:0]proc_data_out);
    
    always @(*)begin
        case(status)
            2'b00: begin
                DM_data_in  = com_data_in;
                DM_addr     = com_addr;
                DM_write_en = com_wr_en;
            end
            
            2'b01: begin
                DM_data_in    = proc_bus;
                DM_addr       = proc_addr;
                DM_write_en   = proc_wr_en;
                proc_data_out = DM_out;
            end
            
            2'b10: begin
                DM_addr      = com_addr;
                DM_write_en  = com_wr_en;
                com_data_out = DM_out;
            end
        endcase
    end
endmodule
