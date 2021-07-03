`define NUM_C 4 // # Predifined cores - 1

module top(input clk,
           input [1:0]status,
           input [15:0]com_data_in,
           input [15:0]com_addr,
           input com_wr_en,
           input [3:0]n_cores,
           output end_process,
           output [15:0]com_data_out);
    
    // For core 1
    wire [15:0] DM_data_in_1;
    wire [15:0] DM_addr_1;
    wire [15:0] DM_out_1;
    wire DM_write_en_1;
    
    wire [`NUM_C*16-1:0] proc_data_out;
    wire [`NUM_C*16-1:0] IM_out;
    
    //outputs
    wire [`NUM_C*16-1:0] bus;
    wire [`NUM_C*16-1:0] proc_addr;
    wire [`NUM_C*16-1:0] PC_out;
    wire [`NUM_C-1:0] proc_write_en;
    wire [`NUM_C-1:0] end_proc;
    
    assign end_process = end_proc[0];
    
    genvar i;
    
    generate
    for (i = 0; i < `NUM_C; i = i + 1) begin : gen_core
        processor #(.cid(i)) core (
        //inputs
        .clk(clk),
        .status(status),
        .DM_out(proc_data_out[i*16 +:16]),
        .IM_out(IM_out[i*16 +:16]),
        .core_activate(n_cores[i]),
        //outputs
        .bus(bus[i*16 +:16]),
        .AR_out(proc_addr[i*16 +:16]),
        .PC_out(PC_out[i*16 +:16]),
        .DM_write_en(proc_write_en[i]),
        .end_process(end_proc[i])
        );
    end
    endgenerate
    
    selector selector1(
    //inputs
    .clk(clk),
    .status(status),
    .com_data_in(com_data_in),
    .com_addr(com_addr),
    .com_wr_en(com_wr_en),
    .DM_out(DM_out_1),
    //outputs
    .DM_data_in(DM_data_in_1),
    .DM_addr(DM_addr_1),
    .DM_write_en(DM_write_en_1),
    .com_data_out(com_data_out)
    );
    
    DRAM data_mem(
    //inputs
    .clk(clk),

    .write_en_1(DM_write_en_1),	
    .addr_1(DM_addr_1),
    .data_in_1(DM_data_in_1),

    .write_en(proc_write_en),
    .addr(proc_addr),
    .data_in(bus),
    
    //outputs
    .data_out_1(DM_out_1),
    .data_out(proc_data_out)
    );
    
    IRAM instr_mem(
    .clk(clk),
    //.data_in(bus),
    .addr(PC_out),
    //output
    .data_out(IM_out)
    );
endmodule
