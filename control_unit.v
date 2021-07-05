module control_unit(input clk,
                    input z,
                    input [15:0] instruction,
                    input [1:0] status,
                    output reg [2:0] alu_op,
                    output reg end_process,
                    output reg PC_read_en,
                    output reg AR_read_en,
                    output reg IR_read_en,
                    output reg AC_read_en,
                    output reg R_read_en,
                    output reg DM_read_en,
                    output reg DR_read_en,
                    output reg IM_read_en,
                    output reg A_read_en,
                    output reg B_read_en,
                    output reg C_read_en,
                    output reg D_read_en,
                    output reg CID_read_en,
                    output reg PC_write_en,
                    output reg AR_write_en,
                    output reg IR_write_en,
                    output reg AC_write_en,
                    output reg R_write_en,
                    output reg DM_write_en,
                    output reg DR_write_en,
                    output reg IM_write_en,
                    output reg A_write_en,
                    output reg B_write_en,
                    output reg C_write_en,
                    output reg D_write_en,
                    output reg PC_inc_en,
                    output reg AC_inc_en,
                    output reg AC_clear_en,
                    output reg ALU_to_AC_write_en);
    
    reg [16:0] state = 16'd0;
    
    parameter idle = 16'd0,
    
    fetch1 = 16'd1,
    fetch2 = 16'd2,
    fetch3 = 16'd3,
    fetch4 = 16'd4,
    
    ldac1 = 16'd5,
    ldac2 = 16'd6,
    
    stac1 = 16'd7,
    stac2 = 16'd8,
    
    lda1 = 16'd9,
    lda2 = 16'd10,
    lda3 = 16'd11,
    lda4 = 16'd12,
    lda5 = 16'd13,
    
    ldb1 = 16'd14,
    ldb2 = 16'd15,
    ldb3 = 16'd16,
    ldb4 = 16'd17,
    ldb5 = 16'd18,
    
    ldc1 = 16'd19,
    ldc2 = 16'd20,
    ldc3 = 16'd21,
    ldc4 = 16'd22,
    ldc5 = 16'd23,
    
    stc1 = 16'd24,
    stc2 = 16'd25,
    stc3 = 16'd26,
    stc4 = 16'd27,
    stc5 = 16'd28,
    
    mvacr1 = 16'd29,
    
    mvacc1 = 16'd30,
    
    mvaca1 = 16'd52,
    
    mvacb1 = 16'd53,
    
    mvacd1 = 16'd54,
    
    mva1 = 16'd31,
    
    mvb1 = 16'd32,
    
    mvc1 = 16'd33,
    
    mvd1 = 16'd65,
    
    mvcid1 = 16'd64,
    
    inac1 = 16'd34,
    
    clac1 = 16'd35,
    
    add1 = 16'd36,
    add2 = 16'd37,
    
    sub1 = 16'd38,
    sub2 = 16'd39,
    
    mul1 = 16'd40,
    mul2 = 16'd41,
    
    div1 = 16'd42,
    div2 = 16'd43,
    
    mod1 = 16'd44,
    mod2 = 16'd45,
    
    jump1 = 16'd46,
    jump2 = 16'd47,
    
    jpnz1 = 16'd48,
    jpnz2 = 16'd49,
    
    no_op = 16'd50,
    
    endop = 16'd51,
    
    lddac1 = 16'd55,
    lddac2 = 16'd56,
    lddac3 = 16'd57,
    lddac4 = 16'd58,
    
    stdac1 = 16'd59,
    stdac2 = 16'd60,
    stdac3 = 16'd61,
    
    jppz1 = 16'd62,
    jppz2 = 16'd63;
    
    always @(posedge clk) begin
        case (state)
            idle: begin
                alu_op <= 3'd0;
                
                PC_read_en  <= 1'b0;
                AR_read_en  <= 1'b0;
                IR_read_en  <= 1'b0;
                AC_read_en  <= 1'b0;
                R_read_en   <= 1'b0;
                DM_read_en  <= 1'b0;
                DR_read_en  <= 1'b0;
                IM_read_en  <= 1'b0;
                A_read_en   <= 1'b0;
                B_read_en   <= 1'b0;
                C_read_en   <= 1'b0;
                CID_read_en <= 1'b0;

                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                D_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                end_process <= 1'b0;
                
                if (status == 2'b01)
                    state <= fetch1;
                else
                    state <= idle;
            end
            
            fetch1: begin
                alu_op <= 3'd0;
                
                PC_read_en  <= 1'b0;
                AR_read_en  <= 1'b0;
                IR_read_en  <= 1'b0;
                AC_read_en  <= 1'b0;
                R_read_en   <= 1'b0;
                DM_read_en  <= 1'b0;
                DR_read_en  <= 1'b0;
                IM_read_en  <= 1'b1;    // IM write data to bus (PC is pointed to address of IM)
                A_read_en   <= 1'b0;
                B_read_en   <= 1'b0;
                C_read_en   <= 1'b0;
                CID_read_en <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b1;    // bus write data to IR
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                D_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b1;  // PC = PC+1 (PC pointing to next instr)
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch2;
            end
            
            fetch2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;      // PC = PC+1
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch3;
            end
            
            fetch3: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b1;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch4;
            end
            
            fetch4: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                state <= instruction;
            end

            ldac1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b1;      // PC = PC+1
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= ldac2;
            end

            ldac2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;     // DM write data to bus
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            lddac1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                D_read_en  <= 1'b1;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                D_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= lddac2;
            end
            
            lddac2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                D_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                D_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= lddac3;
            end
            
            lddac3: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                D_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                D_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= lddac4;
            end
            
            lddac4: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                D_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                D_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            stdac1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                D_read_en  <= 1'b1;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                D_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= stdac2;
            end
            
            stdac2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                D_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                D_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= stdac3;
            end
            
            stdac3: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                D_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b1;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                D_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            
            stac1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b1;  // PC = PC+1
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= stac2;
            end
            
            stac2: begin
                
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b1;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            lda1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b1;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= lda2;
            end

            lda2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= lda3;
            end
            lda3: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= lda4;
            end
            
            lda4: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= lda5;
            end

            lda5: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b1;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            ldb1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b1;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= ldb2;
            end

            ldb2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= ldb3;
            end

            ldb3: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= ldb4;
            end
            
            ldb4: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= ldb5;
            end
            
            ldb5: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b1;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            ldc1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b1;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= ldc2;
            end

            ldc2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= ldc3;
            end
            ldc3: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= ldc4;
            end
            
            ldc4: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= ldc5;
            end

            ldc5: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b1;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            stc1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b1;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b1;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= stc2;
            end
            
            stc2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b1;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= stc3;
            end
            
            stc3: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b1;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= stc4;
            end
            
            stc4: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b1;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= stc5;
            end
            
            stc5: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b1;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b1;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            mvacr1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b1;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            mvacc1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b1;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            mvaca1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b1;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            mvacb1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b1;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            mvacd1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b1;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                D_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                D_write_en  <= 1'b1;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            mva1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b1;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            mvb1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b1;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            mvc1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b1;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            mvd1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                D_read_en  <= 1'b1;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            mvcid1: begin
                alu_op <= 3'd0;
                
                PC_read_en  <= 1'b0;
                AR_read_en  <= 1'b0;
                IR_read_en  <= 1'b0;
                AC_read_en  <= 1'b0;
                R_read_en   <= 1'b0;
                DM_read_en  <= 1'b0;
                IM_read_en  <= 1'b0;
                A_read_en   <= 1'b0;
                B_read_en   <= 1'b0;
                C_read_en   <= 1'b0;
                CID_read_en <= 1'b1;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b1;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            add1: begin
                alu_op <= 3'd1;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= add2;
            end
            
            add2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b1;
                
                state <= fetch1;
            end
            
            inac1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b1;  // AC = AC+1
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            sub1: begin
                alu_op <= 3'd2;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= sub2;
            end
            
            sub2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b1;
                
                state <= fetch1;
            end
            
            mul1: begin
                alu_op <= 3'd3;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= mul2;
            end
            
            mul2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b1;
                
                state <= fetch1;
            end
            
            div1: begin
                alu_op <= 3'd4;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= add2;
            end
            
            div2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b1;
                
                state <= fetch1;
            end
            
            mod1: begin
                alu_op <= 3'd5;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= mod2;
            end
            
            mod2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b1;
                
                state <= fetch1;
            end
            
            clac1: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b1;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            jpnz1: begin
                if (z == 1) begin
                    alu_op <= 3'd0;
                    
                    PC_read_en <= 1'b0;
                    AR_read_en <= 1'b0;
                    IR_read_en <= 1'b0;
                    AC_read_en <= 1'b0;
                    R_read_en  <= 1'b0;
                    DM_read_en <= 1'b0;
                    IM_read_en <= 1'b0;
                    A_read_en  <= 1'b0;
                    B_read_en  <= 1'b0;
                    C_read_en  <= 1'b0;
                    
                    PC_write_en <= 1'b0;
                    AR_write_en <= 1'b0;
                    IR_write_en <= 1'b0;
                    AC_write_en <= 1'b0;
                    R_write_en  <= 1'b0;
                    DM_write_en <= 1'b0;
                    DR_write_en <= 1'b0;
                    IM_write_en <= 1'b0;
                    A_write_en  <= 1'b0;
                    B_write_en  <= 1'b0;
                    C_write_en  <= 1'b0;
                    
                    PC_inc_en <= 1'b1;
                    AC_inc_en <= 1'b0;
                    
                    AC_clear_en        <= 1'b0;
                    ALU_to_AC_write_en <= 1'b0;
                    
                    state <= jpnz2;
                end
                
                
                else begin
                    alu_op <= 3'd0;
                    
                    PC_read_en <= 1'b0;
                    AR_read_en <= 1'b1;
                    IR_read_en <= 1'b0;
                    AC_read_en <= 1'b0;
                    R_read_en  <= 1'b0;
                    DM_read_en <= 1'b0;
                    IM_read_en <= 1'b0;
                    A_read_en  <= 1'b0;
                    B_read_en  <= 1'b0;
                    C_read_en  <= 1'b0;
                    
                    PC_write_en <= 1'b1;
                    AR_write_en <= 1'b0;
                    IR_write_en <= 1'b0;
                    AC_write_en <= 1'b0;
                    R_write_en  <= 1'b0;
                    DM_write_en <= 1'b0;
                    DR_write_en <= 1'b0;
                    IM_write_en <= 1'b0;
                    A_write_en  <= 1'b0;
                    B_write_en  <= 1'b0;
                    C_write_en  <= 1'b0;
                    
                    PC_inc_en <= 1'b0;
                    AC_inc_en <= 1'b0;
                    
                    AC_clear_en        <= 1'b0;
                    ALU_to_AC_write_en <= 1'b0;
                    
                    state <= jpnz2;
                end
            end
            
            jpnz2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;    // Bus write to PC
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            jppz1: begin
                if (z == 0) begin
                    alu_op <= 3'd0;
                    
                    PC_read_en <= 1'b0;
                    AR_read_en <= 1'b0;
                    IR_read_en <= 1'b0;
                    AC_read_en <= 1'b0;
                    R_read_en  <= 1'b0;
                    DM_read_en <= 1'b0;
                    IM_read_en <= 1'b0;
                    A_read_en  <= 1'b0;
                    B_read_en  <= 1'b0;
                    C_read_en  <= 1'b0;
                    
                    PC_write_en <= 1'b0;
                    AR_write_en <= 1'b0;
                    IR_write_en <= 1'b0;
                    AC_write_en <= 1'b0;
                    R_write_en  <= 1'b0;
                    DM_write_en <= 1'b0;
                    DR_write_en <= 1'b0;
                    IM_write_en <= 1'b0;
                    A_write_en  <= 1'b0;
                    B_write_en  <= 1'b0;
                    C_write_en  <= 1'b0;
                    
                    PC_inc_en <= 1'b1;
                    AC_inc_en <= 1'b0;
                    
                    AC_clear_en        <= 1'b0;
                    ALU_to_AC_write_en <= 1'b0;
                    
                    state <= jppz2;
                end
                
                
                else begin
                    alu_op <= 3'd0;
                    
                    PC_read_en <= 1'b0;
                    AR_read_en <= 1'b1;
                    IR_read_en <= 1'b0;
                    AC_read_en <= 1'b0;
                    R_read_en  <= 1'b0;
                    DM_read_en <= 1'b0;
                    IM_read_en <= 1'b0;
                    A_read_en  <= 1'b0;
                    B_read_en  <= 1'b0;
                    C_read_en  <= 1'b0;
                    
                    PC_write_en <= 1'b1;
                    AR_write_en <= 1'b0;
                    IR_write_en <= 1'b0;
                    AC_write_en <= 1'b0;
                    R_write_en  <= 1'b0;
                    DM_write_en <= 1'b0;
                    DR_write_en <= 1'b0;
                    IM_write_en <= 1'b0;
                    A_write_en  <= 1'b0;
                    B_write_en  <= 1'b0;
                    C_write_en  <= 1'b0;
                    
                    PC_inc_en <= 1'b0;
                    AC_inc_en <= 1'b0;
                    
                    AC_clear_en        <= 1'b0;
                    ALU_to_AC_write_en <= 1'b0;
                    
                    state <= jppz2;
                end
            end
            
            jppz2: begin
                alu_op <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= fetch1;
            end
            
            endop : begin
                end_process <= 1'b1;
                alu_op      <= 3'd0;
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                IM_read_en <= 1'b0;
                A_read_en  <= 1'b0;
                B_read_en  <= 1'b0;
                C_read_en  <= 1'b0;
                
                PC_write_en <= 1'b0;
                AR_write_en <= 1'b0;
                IR_write_en <= 1'b0;
                AC_write_en <= 1'b0;
                R_write_en  <= 1'b0;
                DM_write_en <= 1'b0;
                DR_write_en <= 1'b0;
                IM_write_en <= 1'b0;
                A_write_en  <= 1'b0;
                B_write_en  <= 1'b0;
                C_write_en  <= 1'b0;
                D_write_en  <= 1'b0;
                
                PC_inc_en <= 1'b0;
                AC_inc_en <= 1'b0;
                
                AC_clear_en        <= 1'b0;
                ALU_to_AC_write_en <= 1'b0;
                
                state <= endop;
            end
        endcase
    end

endmodule
