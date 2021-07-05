module control_unit (input clk,
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
    
    lddac1 = 16'd9,
    lddac2 = 16'd10,
    lddac3 = 16'd11,
    lddac4 = 16'd12,
    
    stdac1 = 16'd13,
    stdac2 = 16'd14,
    stdac3 = 16'd15,
    
    add1 = 16'd16,
    add2 = 16'd17,
    
    sub1 = 16'd18,
    sub2 = 16'd19,
    
    mul1 = 16'd20,
    mul2 = 16'd21,
    
    div1 = 16'd22,
    div2 = 16'd23,
    
    mod1 = 16'd24,
    mod2 = 16'd25,
    
    clac1 = 16'd26,
    
    inac1 = 16'd27,
    
    jpnz1 = 16'd28,
    jpnz2 = 16'd29,
    
    jppz1 = 16'd30,
    jppz2 = 16'd31,
    
    mvcid1 = 16'd32,
    
    mva1 = 16'd33,
    
    mvb1 = 16'd34,
    
    mvc1 = 16'd35,
    
    mvd1 = 16'd36,
    
    mvacr1 = 16'd37,
    
    mvaca1 = 16'd38,
    
    mvacb1 = 16'd39,
    
    mvacc1 = 16'd40,
    
    mvacd1 = 16'd41,
    
    endop1 = 16'd42;
    
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
                
                PC_read_en <= 1'b0;
                AR_read_en <= 1'b0;
                IR_read_en <= 1'b0;
                AC_read_en <= 1'b0;
                R_read_en  <= 1'b0;
                DM_read_en <= 1'b0;
                DR_read_en <= 1'b0;
                IM_read_en  <= 1'b1;    // IM write data to bus (PC = > Address of IM)
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

            endop1 : begin
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
                
                state <= endop1;
            end
        endcase
    end
    
endmodule
