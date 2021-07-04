`define NUM_C 16 // # Predifined cores - 1

module main(input clk,
            input [15:0]com_data_in,
            input data_write_start,
            input data_write_done,
            input [`NUM_C-1:0]n_cores,
            output [15:0]com_data_out,
            output reg [1:0]state,
            output reg output_write_done,
            output reg output_write_start);
    
    reg [15:0]com_addr;
    reg com_wr_en;
    reg [1:0] status = 2'b11;

    top top1(
    .n_cores(n_cores),
    .clk(clk),
    .status(status),
    .com_data_in(com_data_in),//
    .com_addr(com_addr),
    .com_wr_en(com_wr_en),
    
    .end_process(end_process),
    .com_data_out(com_data_out)//
    );
    
    always @(posedge clk)begin
        case(status)
            2'b11: begin
                com_addr          <= 16'd65535;
                output_write_done <= 1'b0;
                if (data_write_start)begin
                    com_wr_en          <= 1'b1;
                    output_write_start <= 1'b0;
                    state              <= 2'b00;
                    status             <= 2'b00;
                end
                
            end
            
            
            2'b00: begin
                com_addr <= com_addr +1'b1;
                if (data_write_done) begin
                    com_addr  <= com_addr +1'b1;
                    com_wr_en <= 1'b0;
                    state     <= 2'b01;
                    status    <= 2'b01;
                end
            end
            
            2'b01: begin
                if (end_process == 1'b1)begin
                    com_addr <= 16'd0;
                    status   <= 2'b10;
                end
            end
            
            2'b10: begin
                output_write_start <= 1'b1;
                com_addr           <= com_addr + 1'b1;
                if (com_addr == 16'd1024)begin
                    output_write_done <= 1'b1;
                    state             <= 2'b11;
                    status            <= 2'b11;
                end
            end
        endcase
    end
endmodule
