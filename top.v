module top(
    input clk,
    input [1:0]status,
    input [15:0]com_data_in,
    input [15:0]com_addr,
    input com_wr_en,

    output end_process,
    output [15:0]com_data_out
);

    wire [15:0] DM_data_in_1;
    wire [15:0] DM_addr_1;
    wire DM_write_en_1;

    wire [15:0] bus;
    wire [15:0] proc_addr_1;
    wire proc_write_en_1;

    wire [15:0] PC_out;
    wire [15:0] IM_out;
    wire [15:0] DM_out_1;

    wire [15:0]proc_data_out_1;

    wire [15:0]proc_data_out_2;
    wire [15:0]proc_addr_2;
    wire [15:0]proc_write_en_2;
    wire [15:0]proc_data_in_2;


   
    
    processor  #(.cid(16'd0)) core1 (
        //inputs
        .clk(clk),
        .status(status),
        .DM_out(proc_data_out_1),
        .IM_out(IM_out),
        //outputs
        .bus(bus),
        .AR_out(proc_addr_1),
        .DM_write_en(proc_write_en_1),
        .PC_out(PC_out),
        .end_process(end_process)
    );

    processor  #(.cid(16'd1)) core2 (
        //inputs
        .clk(clk),
        .status(status),
        .DM_out(proc_data_out_2),
        .IM_out(IM_out),
        //outputs
        .bus(bus),
        .AR_out(proc_addr_2),
        .DM_write_en(proc_write_en_2),
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
        .proc_addr(proc_addr_1),
        .proc_wr_en(proc_write_en_1),
        .DM_out(DM_out_1),
        //outputs
        .DM_data_in(DM_data_in_1),
        .DM_addr(DM_addr_1),
        .DM_write_en(DM_write_en_1),
        .proc_data_out(proc_data_out_1),
        .com_data_out(com_data_out)
    );

    DRAM data_mem(
        //inputs
        .clk(clk),
        .write_en_1(DM_write_en_1),	
        .addr_1(DM_addr_1),
        .data_in_1(DM_data_in_1),
        .write_en_2(proc_write_en_2),	
        .addr_2(proc_addr_2),
        .data_in_2(proc_data_in_2),
        //outputs
        .data_out_1(DM_out_1),
        .data_out_2(proc_data_out_2)
        );

    IRAM instr_mem(
        .clk(clk),
        .data_in(bus),
        .addr(PC_out),
        //output
        .data_out(IM_out)
    );
endmodule