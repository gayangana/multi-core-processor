`include "definitions.v"

module top (input clk,
            input [1:0] status,
            input [15:0] com_data_in,
            input [15:0] com_addr,
            input com_wr_en,
            output end_process,
            output [15:0] com_data_out);
    
    wire [(`NUM_C*16)-1:0] bus;
    wire [(`NUM_C*16)-1:0] addr;
    wire [`NUM_C-1:0] write_en;
    wire [(`NUM_C*16)-1:0] data_out;
    
    wire com_to_dm;
    wire [15:0] com_ar;

    wire [(`NUM_C*16)-1:0] IM_out;
    wire [(`NUM_C*16)-1:0] PC_out;
    wire [`NUM_C-1:0] end_proc;
    
    assign end_process = end_proc[0];
    
    genvar i;
    
    generate
    for (i = 0; i < `NUM_C; i = i + 1) begin : gen_core
    processor #(.cid(i)) core (
    // inputs
    .clk(clk),
    .status(status),
    .IM_out(IM_out[i*16 +:16]),
    .DM_out(data_out[i*16 +:16]),
    // outputs
    .PC_out(PC_out[i*16 +:16]),
    .DM_write_en(write_en[i]),
    .AR_out(addr[i*16 +:16]),
    .bus(bus[i*16 +:16]),
    .end_process(end_proc[i])
    );
    end
    endgenerate
    
    selector selector (
    // inputs
    .clk(clk),
    .status(status),
    .com_data_in(com_data_in),
    .com_addr(com_addr),
    .com_wr_en(com_wr_en),
    .DM_out(data_out[15:0]),
    // outputs
    .com_data_out(com_data_out),
    .DM_data_in(bus[15:0]),
    .DM_addr(com_ar),
    .DM_write_en(com_to_dm)
    );
    
    DRAM data_mem (
    // inputs
    .clk(clk),
    .com_en(com_to_dm),
    .com_addr(com_ar),
    .write_en(write_en),
    .addr(addr),
    .data_in(bus),
    // outputs
    .data_out(data_out)
    );
    
    IM instr_mem (
    // inputs
    .clk(clk),
    .addr(PC_out),
    // outputs
    .data_out(IM_out)
    );
    
endmodule
