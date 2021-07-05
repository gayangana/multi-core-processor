module processor #(parameter cid)
                  (input clk,
                   input [1:0] status,
                   input [15:0] DM_out,
                   input [15:0] IM_out,
                   output [15:0] bus,
                   output [15:0] AR_out,
                   output [15:0] PC_out,
                   output DM_write_en,
                   output end_process);
    
    wire PC_read_en;
    wire AR_read_en;
    wire IR_read_en;
    wire AC_read_en;
    wire R_read_en;
    wire DM_read_en;
    wire IM_read_en;
    wire DR_read_en;
    wire A_read_en;
    wire B_read_en;
    wire C_read_en;
    wire D_read_en;
    wire CID_read_en;
    
    wire PC_write_en;
    wire AR_write_en;
    wire IR_write_en;
    wire AC_write_en;
    wire R_write_en;
    wire DR_write_en;
    wire IM_write_en;
    wire A_write_en;
    wire B_write_en;
    wire C_write_en;
    wire D_write_en;
    
    wire PC_inc_en;
    wire AC_inc_en;
    
    wire AC_clear_en;
    wire ALU_to_AC_write_en;
    
    wire [2:0] alu_op;
    wire z;
    
    wire [15:0] alu_out;
    wire [15:0] alu_in_1;
    wire [15:0] alu_in_2;
    
    wire [15:0] instruction;
    
    wire [15:0] IR_out;
    wire [15:0] AC_out;
    wire [15:0] R_out;
    wire [15:0] DR_out;
    wire [15:0] A_out;
    wire [15:0] B_out;
    wire [15:0] C_out;
    wire [15:0] D_out;
    wire [15:0] CID_out;
    
    register IR (
    // inputs
    .clk(clk),
    .reg_write_en(IR_write_en),
    .data_in(bus),
    // outputs
    .data_out(IR_out)
    );
    
    register AR (
    // inputs
    .clk(clk),
    .reg_write_en(AR_write_en),
    .data_in(bus),
    // outputs
    .data_out(AR_out)
    );
    
    register DR (
    // inputs
    .clk(clk),
    .reg_write_en(DR_write_en),
    .data_in(bus),
    // outputs
    .data_out(DR_out)
    );
    
    reg_inc PC (
    // inputs
    .clk(clk),
    .reg_write_en(PC_write_en),
    .reg_inc_en(PC_inc_en),
    .data_in(bus),
    // outputs
    .data_out(PC_out)
    );
    
    AC AC (
    // inputs
    .clk(clk),
    .ac_inc_en(AC_inc_en),
    .ac_write_en(AC_write_en),
    .alu_to_ac(ALU_to_AC_write_en),
    .alu_out(alu_out),
    .data_in(bus),
    .ac_clear(AC_clear_en),
    // outputs
    .data_out(AC_out)
    );
    
    register R (
    // inputs
    .clk(clk),
    .reg_write_en(R_write_en),
    .data_in(bus),
    // outputs
    .data_out(R_out)
    );
    
    register A (
    // inputs
    .clk(clk),
    .reg_write_en(A_write_en),
    .data_in(bus),
    // outputs
    .data_out(A_out)
    );
    
    register B (
    // inputs
    .clk(clk),
    .reg_write_en(B_write_en),
    .data_in(bus),
    // outputs
    .data_out(B_out)
    );
    
    register C (
    // inputs
    .clk(clk),
    .reg_write_en(C_write_en),
    .data_in(bus),
    // outputs
    .data_out(C_out)
    );
    
    register D (
    // inputs
    .clk(clk),
    .reg_write_en(D_write_en),
    .data_in(bus),
    // outputs
    .data_out(D_out)
    );
    
    CID #(.cid(cid)) CID (
    // inputs
    .data_out(CID_out)
    );
    
    ALU ALU (
    // inputs
    .i_clk(clk),
    .i_in1(R_out),
    .i_in2(AC_out),
    .i_alu_op(alu_op),
    // outputs
    .o_alu_out(alu_out),
    .o_z(z)
    );
    
    control_unit control (
    // inputs
    .clk(clk),
    .z(z),
    .instruction(IR_out),
    .status(status),
    // outputs
    .alu_op(alu_op),
    .end_process(end_process),
    //
    .PC_read_en(PC_read_en),
    .AR_read_en(AR_read_en),
    .AC_read_en(AC_read_en),
    .R_read_en(R_read_en),
    .DM_read_en(DM_read_en),
    .IM_read_en(IM_read_en),
    .IR_read_en(IR_read_en),
    .DR_read_en(DR_read_en),
    .A_read_en(A_read_en),
    .B_read_en(B_read_en),
    .C_read_en(C_read_en),
    .D_read_en(D_read_en),
    .CID_read_en(CID_read_en),
    //
    .PC_write_en(PC_write_en),
    .AR_write_en(AR_write_en),
    .IR_write_en(IR_write_en),
    .AC_write_en(AC_write_en),
    .R_write_en(R_write_en),
    .DM_write_en(DM_write_en),
    .DR_write_en(DR_write_en),
    .IM_write_en(IM_write_en),
    .A_write_en(A_write_en),
    .B_write_en(B_write_en),
    .C_write_en(C_write_en),
    .D_write_en(D_write_en),
    //
    .PC_inc_en(PC_inc_en),
    .AC_inc_en(AC_inc_en),
    //
    .AC_clear_en(AC_clear_en),
    .ALU_to_AC_write_en(ALU_to_AC_write_en)
    );
    
    bus proc_bus (
    // inputs
    .clk(clk),
    .PC_out(PC_out),
    .AR_out(AR_out),
    .AC_out(AC_out),
    .R_out(R_out),
    .DM_out(DM_out),
    .IM_out(IM_out),
    .DR_out(DR_out),
    .A_out(A_out),
    .B_out(B_out),
    .C_out(C_out),
    .D_out(D_out),
    .CID_out(CID_out),
    .PC_read_en(PC_read_en),
    .AR_read_en(AR_read_en),
    .AC_read_en(AC_read_en),
    .R_read_en(R_read_en),
    .IM_read_en(IM_read_en),
    .DM_read_en(DM_read_en),
    .DR_read_en(DR_read_en),
    .A_read_en(A_read_en),
    .B_read_en(B_read_en),
    .C_read_en(C_read_en),
    .D_read_en(D_read_en),
    .CID_read_en(CID_read_en),
    // outputs
    .bus(bus)
    );
    
endmodule
