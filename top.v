module top(
    input clk,
    input [1:0]status,
    input [15:0]com_data_in,
    input [15:0]com_addr,
    input com_wr_en,

    output reg end_process,
    output reg[15:0]com_data_out
);

    wire [15:0] DM_data_in;
    wire [15:0] DM_addr;
    wire DM_write_en;

    wire [15:0] bus;
    wire [15:0] proc_addr;
    wire proc_write_en;

    wire [15:0] PC_out;
    wire [15:0] IM_out;
    wire [15:0] DM_out;

    wire [15:0]proc_data_out;

    processor core1 (
        //inputs
        .clk(clk),
        .status(status),
        .DM_out(proc_data_out),
        .IM_out(IM_out),
        //outputs
        .bus(bus),
        .AR_out(proc_addr),
        .DM_write_en(proc_write_en),
        .PC_out(PC_out),
        .end_process(end_process)
    );


    selector selector1(
        //inputs
        .clk(clk),
        .status(status),
        .com_data_in(com_data_in),
        .com_addr(com_addr),
        .com_wr_en(com_wr_en),
        .proc_bus(bus),
        .proc_addr(proc_addr),
        .proc_wr_en(proc_write_en),
        .DM_out(DM_out),
        //outputs
        .DM_data_in(DM_data_in),
        .DM_addr(DM_addr),
        .DM_write_en(DM_write_en),
        .proc_data_out(proc_data_out),
        .com_data_out(com_data_out)
    );

    DRAM data_mem(
        //inputs
        .clk(clk),
        .write_en(DM_write_en),	
        .addr(DM_addr),
        .data_in(DM_data_in),
        //outputs
        .data_out(DM_out)
        );

    IRAM instr_mem(
        .clk(clk),
        .data_in(bus),
        .addr(PC_out),
        //output
        .data_out(IM_out)
    );
endmodule