module processor(
    input clk,
    output end_process,
    input [1:0]status
);

    wire PC_read_en;
    wire AR_read_en; 
    wire IR_read_en;
    wire AC_read_en;
    wire R_read_en;
    wire DM_read_en;
    wire IM_read_en;

    wire PC_write_en;
    wire AR_write_en;
    wire IR_write_en;
    wire AC_write_en;
    wire R_write_en;
    wire DM_write_en;
    wire DM_addr_write_en;
    wire IM_write_en;

    wire PC_inc_en;
    wire AC_inc_en;

    wire ALU_to_AC_write_en;
    wire ALU_write_en;

    wire AC_to_R_en;

    wire [1:0]alu_op;
    wire z;

    wire [15:0] alu_out;
    wire [15:0] alu_in_1;
    wire [15:0] alu_in_2;

    

    wire [15:0]instruction;

    wire [15:0]bus;
    wire [15:0]PC_out;
    wire [15:0]AR_out;
    wire [15:0]IR_out;
    wire [15:0]AC_out;
    wire [15:0]R_out;
    wire [15:0]DM_out;
    wire [15:0]IM_out;

    register IR(
        //inputs
        .clk(clk),
        .reg_write_en(IR_write_en),
        .data_in(bus),
        //outputs
        .data_out(IR_out)
    );
	


    register AR(
        //inputs
        .clk(clk),
        .reg_write_en(AR_write_en),
        .data_in(bus),
        //outputs
        .data_out(AR_out)
    );

    reg_inc PC(
        //inputs
        .clk(clk),
        .reg_write_en(PC_write_en),
        .reg_inc_en(PC_inc_en),
        .data_in(bus),
        //outputs
        .data_out(PC_out)
    );


    AC AC1(
        //inputs
        .clk(clk),
        .ac_inc_en(AC_inc_en),
        .ac_write_en(AC_write_en),
        .alu_to_ac(ALU_to_AC_write_en), 
		.ALU_write_en(ALU_write_en),
        .ac_to_r(AC_to_R_en),
        .alu_out(alu_out),
        .data_in(bus),
        //outputs
        .data_out(AC_out)
    );

    regR R(
        //inputs
        .clk(clk),
        .reg_write_en(R_write_en),
        .ALU_write_en(ALU_write_en),
        .ac_to_r(AC_to_R_en),
        .data_in(AC_out),
        //
        .data_r_to_alu(alu_in_1),
        .data_out(R_out)
    );

    ALU alu(
        .i_clk(clk),
        .i_in1(R_out),
        .i_in2(AC_out),
        .i_alu_op(alu_op),
        .o_alu_out(alu_out),
        .o_z(z)
	);
  
   

   
	control_unit control(
        //inputs
        .clk(clk),
        .z(z),
        .instruction(IR_out),
        .status(status),
        //outputs
        .alu_op(alu_op),
        .end_process(end_process),
        .PC_read_en(PC_read_en),
        .AR_read_en(AR_read_en), 
        .AC_read_en(AC_read_en),
        .R_read_en(R_read_en),  
        .DM_read_en(DM_read_en), 
        .IM_read_en(IM_read_en), 
		.IR_read_en(IR_read_en),

        .PC_write_en(PC_write_en), 
        .AR_write_en(AR_write_en), 
        .IR_write_en(IR_write_en), 
        .AC_write_en(AC_write_en), 
        .R_write_en(R_write_en),  
        .DM_write_en(DM_write_en),
        .DM_addr_write_en(DM_addr_write_en), 
        .IM_write_en(IM_write_en), 

        .PC_inc_en(PC_inc_en),
        .AC_inc_en(AC_inc_en),

        .ALU_to_AC_write_en(ALU_to_AC_write_en),
        .ALU_write_en(ALU_write_en),

        .AC_to_R_en(AC_to_R_en)
    );

    bus bus1(
        .clk(clk),
        .PC_out(PC_out),
        .AR_out(AR_out),
        .AC_out(AC_out),
        .R_out(R_out),
        .DM_out(DM_out),
        .IM_out(IM_out),
        .PC_read_en(PC_read_en),
        .AR_read_en(AR_read_en),
        .AC_read_en(AC_read_en),
        .R_read_en(R_read_en),
        .IM_read_en(IM_read_en),
        .DM_read_en(DM_read_en),
        //output
        .bus(bus)
    );

    

    

    DRAM data_mem(
        .clk(clk),
        .write_en(DM_write_en),	
        .addr(bus),
        .addr_write_en(DM_addr_write_en),
        .data_in(bus),
        .data_out(DM_out)
    );

    IRAM instr_mem(
        .clk(clk),
        .data_in(bus),
        //output
        .data_out(IM_out)
    );

endmodule