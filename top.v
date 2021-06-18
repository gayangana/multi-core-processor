module top(
    input clk,
    output reg end_process
);

processor core1 (
    .clk(clk),
    .bus(bus),
    .end_process(end_process)
);

DRAM data_mem(
    
);

