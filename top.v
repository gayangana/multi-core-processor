module top (input clk,
            input [1:0] status,
            input [15:0] com_data_in,
            input [15:0] com_addr,
            input com_wr_en,
            output end_process,
            output [15:0] com_data_out);
    
    wire [15:0] bus;
    wire [15:0] addr;
    wire write_en;
    wire [15:0] data_out;
    
    wire [15:0] DM_data_in;
    wire [15:0] DM_addr;
    wire DM_write_en;
    wire [15:0] DM_out;

    wire [15:0] IM_out;
    wire [15:0] PC_out;
    wire end_proc;
    
    assign end_process = end_proc;
    
    processor #(.cid(0)) core (
    // inputs
    .clk(clk),
    .status(status),
    .IM_out(IM_out),
    .DM_out(data_out),
    // outputs
    .PC_out(PC_out),
    .DM_write_en(write_en),
    .AR_out(addr),
    .bus(bus),
    .end_process(end_proc)
    );
    
    selector selector(
    //inputs
    .clk(clk),
    .status(status),
    .com_data_in(com_data_in),
    .com_addr(com_addr),
    .com_wr_en(com_wr_en),
    .proc_bus(bus),
    .proc_addr(addr),
    .proc_wr_en(write_en),
    .DM_out(DM_out),
    //outputs
    .com_data_out(com_data_out),
    .proc_data_out(data_out),
    .DM_data_in(DM_data_in),
    .DM_addr(DM_addr),
    .DM_write_en(DM_write_en)
    );

    DRAM data_mem (
    // inputs
    .clk(clk),
    .write_en(DM_write_en),	
    .addr(DM_addr),
    .data_in(DM_data_in),
    // outputs
    .data_out(DM_out)
    );
    
    IM instr_mem (
    // inputs
    .clk(clk),
    .addr(PC_out),
    // outputs
    .data_out(IM_out)
    );
    
endmodule
