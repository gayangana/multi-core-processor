module top_fpga (input clk,
                 input [1:0] status,
                 output end_process);

    wire [15:0] bus;
    wire [15:0] addr;
    wire write_en;
    wire [15:0] data_out;

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

    DRAM data_mem (
    // inputs
    .clk(clk),
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
